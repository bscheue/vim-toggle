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
" TODO:
" - switch functions to use <SID>

if exists("g:loaded_toggle") || &compatible
   finish
endif
let g:loaded_toggle = 1

let s:save_cpo = &cpo
set cpo&vim


function! CheckQfWindowOpen()
  for winnr in range(1, winnr('$'))
    if getwinvar(winnr, '&syntax') == 'qf'
      return 1
    endif
  endfor
  return 0
endfunction


function! ToggleQfWindow()
  if CheckQfWindowOpen()
    cclose
  elseif len(getqflist()) != 0
    copen
  else
    echohl ErrorMsg | echo "qf list is empty" | echohl None
  endif
endfunction


function! ToggleLocWindow()
  if get(getloclist(0, {'winid':0}), 'winid', 0)
    lclose
  elseif len(getloclist(win_getid())) != 0
    lopen
  else
    echohl ErrorMsg | echo "no location list for current window" | echohl None
  endif
endfunction


function! CheckPreviewWindowOpen()
  for winnr in range(1, winnr('$'))
    if getwinvar(winnr, '&previewwindow')
      return 1
    endif
  endfor
  return 0
endfunction


function! SavePreviewWindow()
  let t:previewFile = @%
  let t:previewWin = winsaveview()
  let t:previewTags = gettagstack()
endfunction


augroup Preview
  autocmd!
  autocmd WinLeave * if &previewwindow | call SavePreviewWindow() | endif
augroup end


function! RestorePreviewWindow()
  if exists("t:previewFile")
    " need to save the variables local to the function
    " since pedit will overwrite them
    let l:previewFile = t:previewFile
    let l:previewWin = t:previewWin
    let l:previewTags = t:previewTags
    exec "pedit " . l:previewFile
    wincmd P
    call winrestview(l:previewWin)
    call settagstack(win_getid(), l:previewTags)
    wincmd p
  else
    echohl ErrorMsg | echo "preview window has not been opened" | echohl None
  endif
endfunction


function TogglePreviewWindow()
  if CheckPreviewWindowOpen()
    pclose
  else
    call RestorePreviewWindow()
  endif
endfunction


nnoremap <silent> <Plug>ToggleQfWindow :<c-u>call ToggleQfWindow()<CR>
nnoremap <silent> <Plug>ToggleLocWindow :<c-u>call ToggleLocWindow()<CR>
nnoremap <silent> <Plug>TogglePreviewWindow :<c-u>call TogglePreviewWindow()<CR>


let &cpo = s:save_cpo
