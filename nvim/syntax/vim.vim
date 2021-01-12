" ==============================================================================
" Filename:     vim.vim
" Description:  Mappings and settings for vim files
" Author:       Adam Tillou
" ==============================================================================

setlocal foldmethod=marker
setlocal foldlevel=0

inoremap <M-f><M-u><M-n> function! <CR>endfunction<Up>
inoremap <M-i><M-f> if <CR>endif<Up>
inoremap <M-f><M-o><M-r> for <CR>endfor<Up>
inoremap <M-w><M-i> while <CR>endwhile<Up>

hi def link vimLet Keyword
