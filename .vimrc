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
call dein#add('tpope/vim-endwise')
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('jlanzarotta/bufexplorer')
call dein#add('vim-scripts/AnsiEsc.vim')
call dein#add('leafgarland/typescript-vim')
call dein#add('AlessandroYorba/Alduin')
call dein#add('jacoborus/tender.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('elzr/vim-json')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('rust-lang/rust.vim')
call dein#add('mattn/vim-sonictemplate')
call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')
call dein#add('prabirshrestha/async.vim')
call dein#add('prabirshrestha/asyncomplete.vim')
call dein#add('prabirshrestha/asyncomplete-lsp.vim')
call dein#add('mattn/vim-sqlfmt')
call dein#add('mattn/vim-goimports')

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
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,sjis
set fenc=utf8
set wrap
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=0
set hlsearch
set nu
set incsearch
set hlsearch
set autoread
set noswapfile
inoremap <silent> jj <ESC>
nmap <silent> ,l :BufExplorer<CR>
vmap <Space>co <S-i>// <ESC>
let mapleader = "\<Space>"
let g:airline_theme='luna'
let g:airline_powerline_fonts=1
let g:syntastic_rust_checkers = ['clippy']
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:asyncomplete_auto_popup = 0
nnoremap <C-]> g<C-]>
nnoremap ,u :e ++enc=utf-8<CR>
nnoremap ,s :e ++enc=cp932<CR>
nnoremap ,e :e ++enc=euc-jp<CR>
nnoremap ,j :e ++enc=iso-2022-jp<CR>

autocmd FileType typescript setlocal sw=2 sts=0 ts=2 noet
autocmd FileType sql setlocal sw=4 sts=0 ts=4 noet
autocmd FileType go setlocal sw=4 sts=0 ts=4 noet
autocmd FileType typescript,typescriptreact,vim,rust,php,sh,go setlocal omnifunc=lsp#complete
autocmd FileType typescript,typescriptreact,vim,rust,php,sh,go nnoremap <buffer> <silent> <C-]> :LspDefinition<CR>
autocmd FileType typescript,typescriptreact,vim,rust,php,sh,go nnoremap <buffer> <silent> <C-w><C-]> :split \| :LspDefinition<CR>
let g:lsp_diagnostics_float_cursor=1
let g:lsp_text_edit_enabled = 1
let g:sonictemplate_vim_template_dir = expand('~/.vim/sonictemplate')
syntax on
colorscheme Alduin
