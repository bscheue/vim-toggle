" vim-toggle-windows - toggle Vim's windows
"
" Maintainer: bscheue <bscheue@andrew.cmu.edu>
" Website:  https://github.com/bscheue/vim-toggle-windows
"
" Use this command to get help on vim-toggle-windows:
"
"     :help vim-toggle-windows
"
" To index vim-toggle's documentation:
"
"     :helptags ~/.vim/doc
"

if exists("g:loaded_toggle") || &compatible
   finish
endif
let g:loaded_toggle = 1

let s:save_cpo = &cpo
set cpo&vim


augroup Preview
  autocmd!
  autocmd WinLeave * if &previewwindow | call toggle#SavePreviewWindow() | endif
augroup end


nnoremap <silent> <Plug>ToggleQfWindow :<c-u>call toggle#ToggleQfWindow()<CR>
nnoremap <silent> <Plug>ToggleLocWindow :<c-u>call toggle#ToggleLocWindow()<CR>
nnoremap <silent> <Plug>TogglePreviewWindow :<c-u>call toggle#TogglePreviewWindow()<CR>


let &cpo = s:save_cpo
