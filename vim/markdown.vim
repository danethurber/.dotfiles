set spellsuggest+=10

" Toggle spellchecking
function! ToggleSpellCheck()
  set spell!

  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

nnoremap <silent> <Leader>S :call ToggleSpellCheck()<CR>
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
