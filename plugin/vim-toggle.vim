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
  else
    copen
  endif
endfunction


function! ToggleLocWindow()
  if get(getloclist(0, {'winid':0}), 'winid', 0)
    lclose
  else
    lopen
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


nnoremap <silent> yoc :<c-u>call ToggleQfWindow()<CR>
nnoremap <silent> yol :<c-u>call ToggleLocWindow()<CR>
nnoremap <silent> yot :<c-u>call TogglePreviewWindow()<CR>
