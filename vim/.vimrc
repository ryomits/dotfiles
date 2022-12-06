let g:mapleader = "\<Space>" " Leaderキーをスペースに設定

" Disable unnecessary default plugins
let g:loaded_spellfile_plugin   = 1
let g:loaded_tutor_mode_plugin  = 1
let g:loaded_gzip               = 1
let g:loaded_tar                = 1
let g:loaded_tarPlugin          = 1
let g:loaded_zip                = 1
let g:loaded_zipPlugin          = 1
let g:loaded_rrhelper           = 1
let g:loaded_2html_plugin       = 1
let g:loaded_vimball            = 1
let g:loaded_vimballPlugin      = 1
let g:loaded_getscript          = 1
let g:loaded_getscriptPlugin    = 1
let g:loaded_logipat            = 1
let g:loaded_matchparen         = 1
let g:loaded_man                = 1
let g:loaded_netrw              = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_netrwSettings      = 1
let g:loaded_netrwFileHandlers  = 1
let g:loaded_logiPat            = 1
let g:did_instaetl_default_menus = 1
let g:skip_loading_mswin        = 1
let g:did_install_syntax_menu   = 1
let g:plug_shallow = 0

"
" プラグイン設定 {{{
" {{{ dein.vim settings
let s:dein_dir = expand('~/.cache/dein/vim')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('kana/vim-operator-replace')
  call dein#add('kana/vim-operator-user')
  call dein#add('kana/vim-textobj-user')

  call dein#add('cocopon/iceberg.vim')

  " for development
  call dein#add('neoclide/coc.nvim', {'rev': 'release'})
  call dein#add('Shougo/dein.vim')
  call dein#add('andymass/vim-matchup')
  call dein#add('cohama/lexima.vim')
  call dein#add('vim-test/vim-test')
  call dein#add('junegunn/fzf', {'merged': 0})
  call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})
  "call dein#add('kshenoy/vim-signature')
  call dein#add('lambdalisue/fern.vim', {'branch': 'main'})
  call dein#add('lambdalisue/fern-hijack.vim')
  call dein#add('lambdalisue/fern-git-status.vim')
  call dein#add('lambdalisue/gina.vim')
  call dein#add('lambdalisue/guise.vim')
  call dein#add('mattn/emmet-vim', {'merged': 0})
  call dein#add('mattn/vim-sonictemplate')
  call dein#add('simeji/winresizer')
  call dein#add('vim-denops/denops.vim')
  call dein#add('skanehira/command.vim')
  call dein#add('skanehira/denops-silicon.vim')
  call dein#add('skanehira/denops-docker.vim')
  call dein#add('skanehira/qfopen.vim')
  call dein#add('thinca/vim-quickrun')
  call dein#add('skanehira/quickrun-neoterm.vim')
  call dein#add('tyru/open-browser-github.vim')
  call dein#add('tyru/open-browser.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Shougo/ddc.vim')
  call dein#add('matsui54/denops-popup-preview.vim')
  call dein#add('tani/ddc-fuzzy')
  call dein#add('mattn/vim-goimports')
  call dein#add('skanehira/denops-ripgrep.vim')
  call dein#add('previm/previm')
  call dein#add('lambdalisue/compl-local-filename.vim')
  call dein#add('thinca/vim-prettyprint')
  call dein#add('lambdalisue/file-protocol.vim')
  call dein#add('skanehira/winselector.vim')
  call dein#add('jlanzarotta/bufexplorer')

  " for documentation
  " call dein#add('glidenote/memolist.vim')
  " call dein#add('godlygeek/tabular')
  " call dein#add('gyim/vim-boxdraw', {'merged': 0})
  " call dein#add('mattn/vim-maketable')
  " call dein#add('shinespark/vim-list2tree', {'merged': 0})
  " call dein#add('skanehira/gyazo.vim')
  " call dein#add('skanehira/denops-translate.vim')
  " call dein#add('vim-jp/vimdoc-ja')

  " for develop vim/neovim plugin
  " call dein#add('LeafCage/vimhelpgenerator')
  " call dein#add('lambdalisue/vital-Whisky', {'merged': 0})
  " call dein#add('tweekmonster/helpful.vim')
  " call dein#add('vim-jp/vital.vim', {'merged': 0})
  " call dein#add('thinca/vim-themis')
  " call dein#add('tyru/capture.vim')

  " other
  " call dein#add('itchyny/lightline.vim')
  " call dein#add('lambdalisue/fern-renderer-nerdfont.vim')
  " call dein#add('lambdalisue/nerdfont.vim')
  " call dein#add('skanehira/denops-twihi.vim')

  " end settings
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

function! DeinClean() abort
  let s:removed_plugins = dein#check_clean()
  if len(s:removed_plugins) > 0
    echom s:removed_plugins
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
  endif
endfunction

command! CleanPlugins call DeinClean()
" }}}

" {{{ translate.vim
"let g:translate_endpoint = 'https://api-free.deepl.com/v2/translate'
nmap gr <Plug>(Translate)
vmap gr <Plug>(Translate)
" }}}

" {{{ fern.vim
let g:fern#renderer = "nerdfont"
let g:fern#window_selector_use_popup = 1
function! s:fern_init() abort
  nnoremap <buffer> <silent> q :q<CR>
  map <buffer> <silent> <C-x> <Plug>(fern-action-open:split)
  map <buffer> <silent> <C-v> <Plug>(fern-action-open:vsplit)
endfunction

let g:fern#default_hidden = 0
let g:fern#default_exclude = '.git$'

augroup fern-settings
  au!
  au FileType fern call s:fern_init()
augroup END

nnoremap <silent> <Leader>f :Fern . -drawer<CR>
command! Ex :Fern %:h
" }}}

" fzf settings {{{
let g:fzf_layout = { 'down': '50%' }
nnoremap <C-P> :Files<CR>
" }}}

" coc.nvim {{{
command! LspRename :call CocActionAsync('rename')
command! LspReferences :call CocActionAsync('jumpReferences')
command! LspFormat :call CocActionAsync('format')
command! LspImport :call CocActionAsync('runCommand', 'editor.action.organizeImport')
command! GoTagAdd :CocCommand go.tags.add.prompt
command! GoTagRemove :CocCommand go.tags.remove.prompt

augroup rust_coc_maps
  au!
  au FileType rust nnoremap <buffer> <silent> <C-g>o :CocCommand rust-analyzer.openDocs<CR>
augroup END

" [
"   {"text": "(e)dit", "value": "edit"}
"   {"text": "(n)ew", "value": "new"}
" ]
" NOTE: text must contains '()' to detect input and its must be 1 character
function! ChoseAction(actions) abort
  call gh#_message(join(map(copy(a:actions), { _, v -> v.text }), ", ") .. ": ")
  let result = getcharstr()
  let result = filter(a:actions, { _, v -> v.text =~# printf(".*\(%s\).*", result)})
  echo '' | redraw
  return len(result) ? result[0].value : ""
endfunction

function! CocJumpAction() abort
  let actions = [
        \ {"text": "(s)plit", "value": "split"},
        \ {"text": "(v)slit", "value": "vsplit"},
        \ {"text": "(t)ab", "value": "tabedit"},
        \ ]
  return ChoseAction(actions)
endfunction

" GoTo code navigation.
" use tagstack
set tagfunc=CocTagFunc

" define autocmd to detect filetype
" because cannot detect filetype when using tagfunc
augroup coc-ft-detect
  au!
  au BufEnter deno:/* filetype detect
augroup END

nnoremap <silent> <C-]> :<C-u>call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> <Leader>gi :<C-u>call CocActionAsync('jumpImplementation', 'split')<CR>
nnoremap <silent> <Leader>gr :<C-u>call CocActionAsync('jumpReferences', 'split')<CR>

nnoremap <silent> <Leader>i :LspImport<CR>

" scroll popup window
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

map <silent> ga <plug>(coc-codelens-action)

" use manual completion
inoremap <silent><expr> <C-x><C-o> coc#refresh()

" NOTE: leximaが初回insert時に<CR>を上書きするため、ここで一度init() を呼び出す
call lexima#init()

" NOTE: coc#pum#visible 以外を <CR>
" にマッピングした場合、起動時にメッセージが出るため、ダミーのマッピングを用意
inoremap <silent><expr> <CR> coc#pum#visible() ? <nop> : <nop>

function! s:coc_pum_lexima_enter() abort
  let key = lexima#expand('<CR>', 'i')
  call coc#on_enter()
  return "\<C-g>u" . key
endfunction

" NOTE: leximaを使っている場合、<CR>がマッピングされるため
" coc用のマッピングを上書きする
augroup coc-pum-enter
  au!
  au InsertEnter * inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : <SID>coc_pum_lexima_enter()
augroup END

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

let g:coc_global_extensions = [
      \ 'coc-yaml',
      \ 'coc-vimlsp',
      \ 'coc-vetur',
      \ 'coc-prettier',
      \ 'coc-toml',
      \ 'coc-tsserver',
      \ 'coc-sql',
      \ 'coc-sh',
      \ 'coc-rust-analyzer',
      \ 'coc-json',
      \ 'coc-deno',
      \ 'coc-eslint',
      \ 'coc-go',
      \ 'coc-diagnostic',
      \ 'coc-phpls',
      \ ]

call coc#config('diagnostic.messageDelay', 0)
call coc#config('notification.statusLineProgress', 0)
call coc#config('diagnostic-languageserver.filetypes', {
      \ 'sh': 'shellcheck',
      \ })
call coc#config('coc.preferences.formatOnType', 'true')
call coc#config('coc.preferences.useQuickfixForLocations', 'true')
call coc#config('suggest.noselect', 'true')
call coc#config('codeLens.enable', v:true)
" disable auto completion
"call coc#config('suggest.autoTrigger', 'none')
call coc#config('coc.preferences', {
      \ 'formatOnSaveFiletypes': [
        \ 'go',
        \ 'css',
        \ 'javascript',
        \ 'javascriptreact',
        \ 'typescript',
        \ 'typescriptreact',
        \ 'html',
        \ 'scss',
        \ 'sass',
        \ 'json',
        \ 'rust',
        \ 'sql',
        \ 'sh',
        \]})

call coc#config('languageserver', {
      \ 'efm': {
        \ 'command': 'efm-langserver',
        \ 'args': [],
        \ 'trace.server': 'verbose',
        \ 'filetypes': ['markdown']
        \ },
      \ 'golangci-lint-languageserver': {
        \ 'command': 'golangci-lint-langserver',
        \ 'filetypes': ['go'],
        \ 'initializationOptions': {
        \   'command': ['golangci-lint', 'run', '--out-format', 'json']
        \ }}
      \})

" gopls configuration
call coc#config('go.goplsPath', 'gopls')
call coc#config('go.goplsOptions', {
      \ 'completeUnimported': v:true,
      \ 'allExperiments': v:true,
      \ 'codelenses': { 
        \ 'test': v:true,
        \ 'run_vulncheck_exp': v:true,
        \ 'tidy': v:true,
      \ },
      \ 'hints': {
        \ 'assignVariableTypes': v:true,
        \ 'compositeLiteralFields': v:true,
        \ 'constantValues': v:true,
        \ 'functionTypeParameters': v:true,
        \ 'parameterNames': v:true,
        \ 'rangeVariableTypes': v:true,
        \ }
      \ })

" rust-analyzer configuration
call coc#config('rust-analyzer.diagnostics.experimental.enable', v:true)
nnoremap ]f <Cmd>LspFormat<CR>
nnoremap ma <Plug>(coc-codeaction-cursor)
" }}}

" sonictemplate.vim {{{
let g:sonictemplate_vim_template_dir = ["~/.vim/template"]
imap <silent> <C-l> <plug>(sonictemplate-postfix)
" }}}
"
" {{{ lexima.vim
set backspace=indent,eol,start
" }}}

" colorscheme {{{
colorscheme iceberg
function s:initColorscheme() abort
  hi clear VertSplit
  hi VertSplit ctermfg=232 guifg=#202023
endfunction

augroup iceberg
  au!
  au ColorScheme * call <SID>initColorscheme()
augroup END

set background=dark
" visual modeのhighlight変更
hi Visual ctermfg=159 ctermbg=23 guifg=#b3c3cc guibg=#384851
" }}}

" options {{{
syntax enable
filetype plugin indent on
set nocompatible
set history=200
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
set belloff=all
set backspace=2
set incsearch
set hlsearch
set synmaxcol=256
set cursorline
set autowrite
set noswapfile
set nu
" }}}

" 拡張子ごとのインデント設定 {{{
set tabstop=2 shiftwidth=2 softtabstop=2

augroup fileTypeIndent
  au!
  au FileType go setlocal tabstop=4 shiftwidth=4
  au FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab foldmethod=marker
  au FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType javascript,javascriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType typescript,typescriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType vue  setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType sh setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au FileType zsh setlocal tabstop=2 shiftwidth=2 expandtab
  au FileType rust setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  au FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
augroup END
" }}}

" bufexploere {{{
nmap <silent> ,l :BufExplorer<CR>
" }}}

" }}}
