execute pathogen#infect()

au vimenter * NERDTreeToggle
nmap <F3> :NERDTreeToggle<CR>

au filetype go au bufwritepre <buffer> Fmt
au bufwritepost *.go silent! !ctags -R &

nmap <F4> :TagbarToggle<CR>

let g:SuperTabDefaultCompletionType = "context"

au filetype go set makeprg=go\ build\ ./...
nmap <F5> :make<CR>:copen<CR>

function! s:GoVet()
    cexpr system("go vet " . shellescape(expand('%')))
    copen
endfunction
command! GoVet :call s:GoVet()

function! s:GoLint()
    cexpr system("golint " . shellescape(expand('%')))
    copen
endfunction
command! GoLint :call s:GoLint()

set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=0

set ts=4 " Set tabs to 2 spaces
set nu " Default to line numbers on
set incsearch   " Set incremental search on

" Execute 'cmd' while redirecting output.
" Delete all lines that do not match regex 'filter' (if not empty).
" Delete any blank lines.
" Delete '<whitespace><number>:<whitespace>' from start of each line.
" Display result in a scratch buffer.
function! s:Filter_lines(cmd, filter)
  let save_more = &more
  set nomore
  redir => lines
  silent execute a:cmd
  redir END
  let &more = save_more
  new
  setlocal buftype=nofile bufhidden=hide noswapfile
  put =lines
  g/^\s*$/d
  %s/^\s*\d\+:\s*//e
  if !empty(a:filter)
    execute 'v/' . a:filter . '/d'
  endif
  0
endfunction
command! -nargs=? Scriptnames call s:Filter_lines('scriptnames', <q-args>)
