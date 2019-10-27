let s:save_cpo = &cpo
set cpo&vim

function! s:CheckQfWindowOpen()
  for winnr in range(1, winnr('$'))
    if getwinvar(winnr, '&syntax') == 'qf'
      return 1
    endif
  endfor
  return 0
endfunction


function! toggle#ToggleQfWindow()
  if s:CheckQfWindowOpen()
    cclose
  elseif len(getqflist()) != 0
    copen
  else
    echohl ErrorMsg | echo "qf list is empty" | echohl None
  endif
endfunction


function! toggle#ToggleLocWindow()
  if get(getloclist(0, {'winid':0}), 'winid', 0)
    lclose
  elseif len(getloclist(win_getid())) != 0
    lopen
  else
    echohl ErrorMsg | echo "no location list for current window" | echohl None
  endif
endfunction


function! s:CheckPreviewWindowOpen()
  for winnr in range(1, winnr('$'))
    if getwinvar(winnr, '&previewwindow')
      return 1
    endif
  endfor
  return 0
endfunction


function! toggle#SavePreviewWindow()
  let t:previewFile = @%
  let t:previewWin = winsaveview()
  let t:previewTags = gettagstack()
endfunction


function! s:RestorePreviewWindow()
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


function! toggle#TogglePreviewWindow()
  if s:CheckPreviewWindowOpen()
    pclose
  else
    call s:RestorePreviewWindow()
  endif
endfunction


let &cpo = s:save_cpo
