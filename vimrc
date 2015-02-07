" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Common Settings
set encoding=utf-8
set fileencodings=utf-8,gbk
set term=screen-256color
set wildignorecase
set iskeyword+=-
set mouse-=a
set selection=inclusive
set selectmode=mouse,key
set iskeyword+=-

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" Bundles
if filereadable(expand("~/.vim/bundles"))
    source ~/.vim/bundles
endif

" Ignore configs
if filereadable(expand("~/.vim/ignores"))
    source ~/.vim/ignores
endif

call neobundle#end()

" Required:
filetype plugin indent on
syntax on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Env
let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
    let os='osx'
elseif os == 'Linux'
    let os='linux'
endif

" UI
set nu
set nobackup
set noswapfile
set cursorline
set hlsearch
set incsearch
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set lines=40                " 40 lines of text instead of 24,
    color molokai
    set guifont=monaco\ for\ Powerline:h14
else
    set t_Co=256
    let NERDTreeDirArrows=0
    color wombat256mod
endif

func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf
set ch=1
set stl=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PWD]\ %r%{GetPWD()}%h\ %=\ [Line]%l/%L\ %=\[%P]
set ls=2 
set wildmenu 

" Formatting
set nowrap                      " wrap long lines
set autoindent                  " indent at the same level of the previous line
set shiftwidth=4                " use indents of 4 spaces
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set softtabstop=4               " let backspace delete indents
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Auto Save
if has("autocmd")
    autocmd! bufwritepost .vimrc source $MYVIMRC
endif

" fold
set foldenable
set foldmethod=indent
set foldlevel=99

" Undo
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
if v:version >= 730
	set undofile            " keep a persistent backup file
	set undodir=/tmp/vimundo/
endif"

" Key Mapping
let mapleader = ','
let g:mapleader = ','

" Ack
let g:ackprg = 'ag --nogroup --nocolor --column --ignore-dir fixture --ignore-dir fixtures --ignore-dir idetest --ignore-dir jstest --ignore "data.json"'
noremap <Leader>a :Ack 

" JQuery
au BufRead,BufNewFile *.js set syntax=jquery


" Youcompleteme
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_seed_identifiers_with_syntax=1
let g:jedi#goto_assignments_command='<leader>jg'
let g:jedi#goto_definitions_command='<leader>jd'
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
if !empty(glob("~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
endif
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
endif

" Jedi
autocmd FileType python setlocal completeopt-=preview
" work with ycm
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"

" Ultisnips
let g:UltiSnipsExpandTrigger="<leader>s"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Emmet
let g:user_emmet_expandabbr_key = ',e'
let g:use_emmet_complete_tag = 1

" Airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline_theme             = 'badwolf'
let g:airline_left_sep          = ''
let g:airline_left_alt_sep      = ''
let g:airline_right_sep         = ''
let g:airline_right_alt_sep     = ''
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'

" Json
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

" Syntasitic
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting=0
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_javascript_checkers = ['jshint']
let g:pyflakes_use_quickfix = 0

" Ctrl-P
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" vim-go {
let g:go_bin_path = "~/.vim/tools/go/".os
let g:go_disable_autoinstall = 1
" type info
au FileType go nmap <Leader>i <Plug>(go-info)
" godoc
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
" go-run go-build go-test
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
" godef
au FileType go nmap <leader>g <Plug>(go-def)
au FileType go nmap <Leader>ds <Plug>(go-def-split)


" Custom Func
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    " .sh
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# -*- coding: utf-8 -*-")
    endif

    normal G
    normal o
    normal o
endfunc
