let g:jsx_ext_required=0

" linting
let g:ale_linters = {}
let g:ale_fixers = {}
let g:ale_fix_on_save = 1
let g:ale_set_baloons = 1

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
let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:airline#extensions#ale#enabled = 1
let g:ale_linters_explicit = 1

let g:prettier#autoformat=0
let g:prettier#config#bracket_spacing="true"
let g:prettier#config#jsx_bracket_same_line="false"
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote="true"
let g:prettier#config#trailing_comma="none"

let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = { 'javascript.jsx' : { 'extends' : 'jsx'  } }

" Run prettier async before saving
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.json,*.graphql,*.md PrettierAsync
autocmd BufWritePre .babelrc,.eslintrc,.prettierrc PrettierAsync

" Movement between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

