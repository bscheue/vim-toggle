" vim-toggle-windows - toggle Vim's windows
"
" Maintainer: bscheue <bscheuer@andrew.cmu.edu>
" Website:  https://github.com/bscheue/vim-toggle-windows
"
" Use this command to get help on vim-toggle-windows:
"
"     :help vim-toggle-windows


if exists("g:loaded_toggle") || &compatible
   finish
endif
let g:loaded_toggle = 1

let s:save_cpo = &cpo
set cpo&vim


augroup Preview
  autocmd!
  autocmd WinLeave * if &previewwindow
        \ | call toggle#SavePreviewWindow()
        \ | elseif &filetype ==# "help"
        \ | call toggle#SaveHelpWindow()
        \ | endif
augroup end


command! ToggleHelpWindow :call toggle#ToggleHelpWindow()
command! ToggleLocWindow :call toggle#ToggleLocWindow()
command! TogglePreviewWindow :call toggle#TogglePreviewWindow()
command! ToggleQfWindow :call toggle#ToggleQfWindow()


nnoremap <silent> <Plug>ToggleHelpWindow :<c-u>call toggle#ToggleHelpWindow()<CR>
nnoremap <silent> <Plug>ToggleLocWindow :<c-u>call toggle#ToggleLocWindow()<CR>
nnoremap <silent> <Plug>TogglePreviewWindow :<c-u>call toggle#TogglePreviewWindow()<CR>
nnoremap <silent> <Plug>ToggleQfWindow :<c-u>call toggle#ToggleQfWindow()<CR>


let &cpo = s:save_cpo
