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
nmap <silent> ,l :BufExplorer<CR>
let mapleader = "\<Space>"
syntax on

" Neobundle
let vundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
endif

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'vim-scripts/ruby-matchit'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'fatih/vim-go'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'koron/codic-vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'jlanzarotta/bufexplorer'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" ruby
autocmd FileType ruby setlocal sw=2 sts=0 ts=2 et

" javascript
autocmd BufNewFile,BufRead *.es6 setfiletype javascript

" go
autocmd FileType go setlocal sw=4 sts=4 ts=4 et
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage)
autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

colorscheme railscasts
