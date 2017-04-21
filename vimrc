set nocompatible

call plug#begin('~/vimfiles/plugged')
Plug 'honza/vim-snippets'
Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'https://github.com/itchyny/calendar.vim.git'
call plug#end()

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

let g:vimwiki_folding = 'list'

let mapleader="\<Space>"                          " leader key

ino jj <esc>
cno jj <c-c>
colorscheme distinguished                               " color scheme

set number                                        " show line number
set cursorline                                    " highlight the cursor line

set autoindent                                    " enable auto indent
syntax on                                         " enable the syntax color
set shiftwidth=4                                  " set the tab width
set tabstop=4

set incsearch                                     " search as characters are entered
set hlsearch                                      " highlight matches

set backspace=2 " make backspace work like most other apps

set noruler
set laststatus=2

set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" remove the highlight when the search is done
nnoremap <silent> <leader>/ :nohlsearch<CR>
nnoremap // q/p<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <leader>ez :tabnew ~/.zshrc<CR>
nnoremap <leader>eb :tabnew ~/.bshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" save & quit , force save & quit
nnoremap <leader>z :wq<CR>
nnoremap <leader>Z :wq!<CR>

" save & force save
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w !sudo tee %<CR>

" quit & force quit
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

" back to flag
nnoremap <leader>m `

" avoid the :q window to open (not useful IMO)
nnoremap q: :q

" navigate between tabs
nnoremap <leader>tf :tabfirst<CR>
nnoremap <leader>tgf 1gt
nnoremap <leader>tgl 1gtgT
nnoremap <silent> <leader>tl :tablast<CR>
nnoremap <silent> <leader>tmf :tabm 0<CR>
nnoremap <silent> <leader>tml :tabm<CR>
nnoremap <silent> <leader>tn :tabn<CR>
nnoremap <leader>to :tabnew<space>
nnoremap <silent> <leader>tp :tabp<CR>
nnoremap <silent> <leader>tq :tabclose<CR>

" remove ex mode on Q and put the read macro (instead of @)
nnoremap Q @

set foldmethod=syntax

nnoremap gf :wincmd gf<CR>

nnoremap <silent> zj :call NextClosedFold('j')<cr>
nnoremap <silent> zk :call NextClosedFold('k')<cr>

function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

au BufRead,BufNewFile *  setfiletype txt 
