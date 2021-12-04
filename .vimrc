""" Indentation Settings
set autoindent
set expandtab
set shiftwidth=4
set smarttab
set tabstop=4

""" Search Settings
set hlsearch
set ignorecase
set incsearch
set smartcase

""" Performance Optimizations
set complete-=i
set lazyredraw

""" Rendering Settings
set display+=lastline
set encoding=utf-8
set linebreak
set scrolloff=1
syntax enable
set wrap
set cursorline

""" UI Settings
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
set wildmenu
set ruler
set tabpagemax=50
set number relativenumber
set noerrorbells
set visualbell
set mouse=a
set title
set showcmd
set showmode
set showmatch
set background=dark
set term=screen-256color
colorscheme sonokai

""" MISC
set autoread
set backspace=indent,eol,start
set confirm
set hidden
set history=1000
set nomodeline
set spell
set noswapfile
set nocompatible
filetype on
filetype plugin on
filetype indent on
filetype on

""" Mappings
let mapleader = "<space>"

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on
" save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Apply macros with Q
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Fast saving
nmap <leader>w :w!<cr>

" Search visually selected text
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Helper Function
function! HasPaste()
        if &paste
            return 'PASTE MODE  '
        endif
        return ''
endfunction
