execute pathogen#infect()
filetype plugin indent on

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
