set nocompatible
set backspace=indent,eol,start
set history=100
set ignorecase
set smartcase
set title
set showcmd
set laststatus=2
set showmatch
set matchtime=1
set termencoding=utf8
set encoding=utf8
set fenc=utf8
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=
set wrap
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=0
set hlsearch
set nu
inoremap <silent> jj <ESC>
colorscheme railscasts
syntax on

" Neobundle
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'vim-scripts/ruby-matchit'
NeoBundle 'tpope/vim-endwise'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" coffeescript
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
autocmd BufWritePost *.coffee silent make!
autocmd QuickFixCmdPost * nested cwindow | redraw!
nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-W>h

" ruby
autocmd FileType ruby setlocal sw=2 sts=0 ts=2 et
