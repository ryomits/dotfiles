let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('vim-scripts/ruby-matchit')
call dein#add('tpope/vim-endwise')
call dein#add('pangloss/vim-javascript')
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('jlanzarotta/bufexplorer')
call dein#add('vim-scripts/AnsiEsc.vim')
call dein#add('szw/vim-tags')
call dein#add('leafgarland/typescript-vim')
call dein#add('AlessandroYorba/Alduin')
call dein#add('nikvdp/ejs-syntax')
call dein#add('gosukiwi/vim-atom-dark')
call dein#add('jacoborus/tender.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('elzr/vim-json')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('jparise/vim-graphql')
call dein#add('pantharshit00/vim-prisma')
call dein#add('rust-lang/rust.vim')
call dein#add('mattn/vim-sonictemplate')
call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')
call dein#add('prabirshrestha/asyncomplete.vim')
call dein#add('prabirshrestha/asyncomplete-lsp.vim')
call dein#add('ulwlu/elly.vim')

call dein#end()

if dein#check_install()
  call dein#install()
endif
filetype plugin indent on

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

let g:asyncomplete_auto_popup = 0
nnoremap <C-]> g<C-]>

autocmd BufRead,BufNewFile *.ts  setlocal filetype=typescript
autocmd FileType typescript setlocal sw=4 sts=0 ts=4 noet
autocmd FileType typescript setlocal omnifunc=lsp#complete
autocmd FileType typescript nnoremap <buffer> <silent> <C-]> :LspDefinition<CR>
autocmd FileType typescript nnoremap <buffer> <silent> <C-w><C-]> :split \| :LspDefinition<CR>
autocmd FileType typescriptreact setlocal omnifunc=lsp#complete
autocmd FileType typescriptreact nnoremap <buffer> <silent> <C-]> :LspDefinition<CR>
autocmd FileType typescriptreact nnoremap <buffer> <silent> <C-w><C-]> :split \| :LspDefinition<CR>
autocmd FileType vim setlocal omnifunc=lsp#complete
autocmd FileType rust setlocal omnifunc=lsp#complete
autocmd FileType rust nnoremap <buffer> <silent> <C-]> :LspDefinition<CR>
autocmd FileType rust nnoremap <buffer> <silent> <C-w><C-]> :split \| :LspDefinition<CR>
autocmd FileType php setlocal omnifunc=lsp#complete
autocmd FileType php nnoremap <buffer> <silent> <C-]> :LspDefinition<CR>
autocmd FileType php nnoremap <buffer> <silent> <C-w><C-]> :split \| :LspDefinition<CR>
autocmd FileType sh setlocal omnifunc=lsp#complete
autocmd FileType sh nnoremap <buffer> <silent> <C-]> :LspDefinition<CR>
autocmd FileType sh nnoremap <buffer> <silent> <C-w><C-]> :split \| :LspDefinition<CR>
autocmd FileType sql setlocal sw=4 sts=0 ts=4 noet
autocmd BufNewFile,BufRead *.es6 setfiletype javascript
let g:lsp_diagnostics_float_cursor=1

syntax on
colorscheme elly

set noswapfile
let g:airline_theme='luna'
set laststatus=2
let g:airline_powerline_fonts=1
vmap <Space>co <S-i>// <ESC>

let g:syntastic_rust_checkers = ['clippy']

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
