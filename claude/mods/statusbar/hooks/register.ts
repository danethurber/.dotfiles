import type { EngineInterface, Register, SessionRateLimit } from 'claude-code'

type Git = { dir: string; worktree?: string; branch?: string; isDirty: boolean }

type Line = {
  git?: Git
  model?: string
  effort?: string | number
  style?: string
  contextPercent?: number
  limits: SessionRateLimit[]
  text: string
}

const BAR_CELLS = 8

const prettyModel = (id: string): string => {
  const match = /^claude-([a-z]+)-(\d+)(?:-(\d+))?/.exec(id)
  const [, family, major, minor] = match ?? []
  if (!family || !major) return id
  return `${family.charAt(0).toUpperCase()}${family.slice(1)} ${minor ? `${major}.${minor}` : major}`
}

const shortDir = (dir: string): string => dir.replace(/^\/Users\/[^/]+/, '~')

const bar = (percent: number): string => {
  const filled = Math.round((Math.min(100, Math.max(0, percent)) / 100) * BAR_CELLS)
  return `${'▰'.repeat(filled)}${'▱'.repeat(BAR_CELLS - filled)}`
}

const clock = (iso?: string): string | undefined => {
  if (!iso) return undefined
  const at = new Date(iso)
  if (Number.isNaN(at.getTime())) return undefined
  return `${String(at.getHours()).padStart(2, '0')}:${String(at.getMinutes()).padStart(2, '0')}`
}

const limitText = (limits: SessionRateLimit[]): string | undefined => {
  const five = limits.find(l => l.kind === 'five_hour')
  const week = limits.find(l => l.kind === 'seven_day')
  const reset = clock(five?.resetsAt)
  const parts = [
    five && `5h ${Math.round(five.percentUsed)}%${reset ? ` ↻${reset}` : ''}`,
    week && `wk ${Math.round(week.percentUsed)}%`,
  ].filter(Boolean)
  return parts.length ? parts.join(' · ') : undefined
}

const render = (line: Line): string => {
  const where = line.git
    ? [
        shortDir(line.git.dir),
        line.git.worktree && `wt:${line.git.worktree}`,
        line.git.branch && `⎇ ${line.git.branch}${line.git.isDirty ? '*' : ''}`,
      ]
        .filter(Boolean)
        .join(' ')
    : undefined
  const who = [line.model && prettyModel(line.model), line.effort, line.style]
    .filter(v => v !== undefined && v !== '')
    .join(' · ')
  const context = line.contextPercent === undefined ? undefined : `ctx ${bar(line.contextPercent)} ${Math.round(line.contextPercent)}%`
  return [where, who || undefined, context, limitText(line.limits)].filter(Boolean).join('  │  ')
}

const line: Line = { limits: [], text: '' }

async function show($: EngineInterface) {
  line.text = render(line)
  $.ui.invalidate('ui.render')
  const surfaces = await $.session.surfaces()
  const hasOtherSurface = surfaces.some(surface => surface !== 'terminal')
  $.ui.status(hasOtherSurface && line.text ? line.text : undefined)
}

async function readGit($: EngineInterface): Promise<Git> {
  const dir = await $.session.cwd()
  const where = await $.process.run(['git', 'rev-parse', '--git-dir'], { timeoutMs: 3000 })
  if (where.exitCode !== 0) return { dir, isDirty: false }
  const status = await $.process.run(['git', 'status', '--porcelain=v2', '--branch', '--untracked-files=no'], { timeoutMs: 3000 })
  const head = /^# branch\.head (.+)$/m.exec(status.stdout)?.[1]
  return {
    dir,
    worktree: /\/worktrees\/([^/\n]+)\s*$/.exec(where.stdout)?.[1],
    branch: head === '(detached)' ? 'detached' : head,
    isDirty: status.stdout.split('\n').some(row => /^[12u] /.test(row)),
  }
}

async function readStyle($: EngineInterface): Promise<string | undefined> {
  const rows = await $.config.list()
  const row = rows.find(r => /output.?style/i.test(r.key) || /output style/i.test(r.label))
  if (typeof row?.value !== 'string' || /^default$/i.test(row.value)) return undefined
  return row.value
}

async function refresh($: EngineInterface) {
  try {
    line.git = await readGit($)
  } catch {
    line.git = undefined
  }
  try {
    line.style = await readStyle($)
  } catch {
    line.style = undefined
  }
  await show($)
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    const result = await next(e)
    line.model = await $.session.model()
    await refresh($)
    return result
  })

  on('turn.step', async function* ($, e, next) {
    if (!e.agentId) {
      line.model = e.model
      line.effort = e.effort
      await show($)
    }
    return yield* next(e)
  })

  on('session.measure', async ($, e, next) => {
    line.contextPercent = e.context.percent
    line.limits = e.rateLimits
    await show($)
    return next(e)
  })

  on('turn.complete', async ($, e, next) => {
    const result = await next(e)
    await refresh($)
    return result
  })

  on('ui.render', { component: 'PromptHint' }, ($, e, next) =>
    e.surface === 'terminal' && line.text ? next({ ...e, props: { ...e.props, tail: `  ${line.text}` } }) : next(e),
  )
}
