call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'preservim/nerdtree'
Plug 'liuchengxu/space-vim-theme'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"Custom Config
set encoding=utf-8
set fileencoding=utf-8
set number
set mouse=a
syntax on
set splitright
set splitbelow
set backupcopy=yes
set signcolumn=yes
set relativenumber

" Enable true color
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"used for autocomplete when adding dash
set iskeyword+=\-

set rtp+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256

"colorscheme
set background=dark
colorscheme space_vim_theme

"airline-theme
let g:airline_theme='base16_spacemacs'
let g:airline_powerline_fonts = 1

"scrooloose/nerdtree
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd BufWinEnter * NERDTreeMirror

"fzf
nmap <c-p> :FZF<CR>

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

