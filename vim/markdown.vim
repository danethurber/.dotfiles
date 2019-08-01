" no folds
let g:vim_markdown_folding_disabled = 1

" shrink toc if possible
let g:vim_markdown_toc_autofit = 1

" fancy syntax concealment
autocmd FileType markdown set conceallevel=2

" but not for code blocks
let g:vim_markdown_conceal_code_blocks = 0

" yaml frontmatter
let g:vim_markdown_frontmatter = 1

" NV search paths
let g:nv_search_paths = ['~/Notes']

" NV short file paths
let g:nv_use_short_pathnames = 1

" open N-FZF
nnoremap <silent> <localleader>N :NV<CR>
" create new note binding
let g:nv_create_note_key = 'ctrl-N'
" open new notes in main window
let g:nv_create_note_window = 'e'

" toggle checkboxes
function ToggleCheckbox()
  let l:line=getline('.')
  let l:curs=winsaveview()
  
  if l:line=~?'\s*-\s*\[\s*\].*'
      s/\[\s*\]/[.]/
  elseif l:line=~?'\s*-\s*\[\.\].*'
      s/\[.\]/[x]/
  elseif l:line=~?'\s*-\s*\[x\].*'
      s/\[x\]/[ ]/
  endif
  call winrestview(l:curs)
endfunction

autocmd FileType markdown nnoremap <silent> - :call ToggleCheckbox()<CR>

