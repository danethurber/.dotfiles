let g:jsx_ext_required=0

" linting
let g:ale_linters = {}
let g:ale_fixers = {}
let g:ale_fix_on_save = 0
let g:ale_set_balloons = 1

:call extend(g:ale_fixers, {
	\	'*': ['trim_whitespace'],
	\	'json': ['fixjson']})

:call extend(g:ale_linters, {
	\	'javascript': ['eslint'],
	\	'typescript': ['tsserver', 'tslint'] })

:call extend(g:ale_fixers, {
	\	'javascript': ['eslint'],
	\	'typescript': ['tslint'],
	\	'html': [] })

let g:ale_typescript_tslint_use_global = 0
let g:ale_typescript_tslint_config_path = ''

let g:ale_lint_on_enter = 0
let g:ale_linters_explicit = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

let g:prettier#autoformat=0
let g:prettier#config#bracket_spacing="true"
let g:prettier#config#jsx_bracket_same_line="false"
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote="true"
let g:prettier#config#trailing_comma="none"

" Run prettier async before saving
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.json,*.graphql,*.md PrettierAsync
autocmd BufWritePre .babelrc,.eslintrc,.prettierrc PrettierAsync

" Movement between linting errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

