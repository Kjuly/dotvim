"
" Maintainer:	Kaijie Yu <kj#kjuly.com>
" Last change:	2011 Dec 25
"
"     *nix and OS/2: ~/.vimrc
"  MS-DOS and Win32: $VIM\_vimrc
"	    for OpenVMS: sys$login:.vimrc
"

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nobackup	" do not keep a backup file, use versions instead
set history=50	" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch	" do incremental searching

" Vim编码设置
set enc=utf-8
" set fenc=utf-8
set fenc=gb18030 " 为兼容Windows下的gbk(cp936)编码来开发项目
set fencs=ucs-bom,utf-8,gb18030,gbk

set nocp " 关闭严格的vi兼容能力
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent

""<Tab> setting
set tabstop=2       " Number of spaces that will be inserted when the tab key is pressed
set shiftwidth=2    " Number of space characters inserted for indentation
set softtabstop=2   " Use <Backspace>/<Delete> to delete a spaced indent as if it was a tab
set expandtab       " Replace tab to spaces
                    " 1. Enter a real tab character use |Ctrl-V <Tab>| key sequence.
                    " 2. To change all the existing tab characters to match the current tab settings,
                    " use |:retab| in vim
" Only Python use 4 spaces as a tab
autocmd FileType python set tabstop=4|set shiftwidth=4|set softtabstop=4

set nu " 显示行号
set fdm=indent "设置折叠

" set autochdir " 自动切换工作目录，以当前打开的文件所在目录为准

" 定义查找路径
set path=.,,~/KJuly/c/**,~/KJuly/acm/**,~/KJuly/java/**

run macros/gdb_mappings.vim
set previewheight=12
" set asm=0

" 设置Session选项, sesdir为保存相对路径，而curdir保存绝对路径
set sessionoptions-=curdir
set sessionoptions+=sesdir

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Open the current editing file with MacVim | normal mode
nnoremap <Leader>m :!open -a MacVim %<cr>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


set exrc   " 允许加载项目自身的.vimrc文件
set secure " 避免不安全命令的执行
""""""""""""""""""""""""""""""""""""""
" Tag list ( ctags ) plugin configure
""""""""""""""""""""""""""""""""""""""
let Tlist_Auto_Open=0
let Tlist_Ctags_Cmd='/opt/local/bin/ctags' " Ctags路径
let Tlist_Exit_OnlyWindow=1
let Tlist_Enable_Fold_Column=0
let Tlist_Show_One_File=0 " 只显示当前文件下的标签
let Tlist_File_Fold_Auto_Close=1 " 当显示多个文件标签时，可将其它文件的折叠
let Tlist_Sort_Type="name" " 标签按照名称排列
let Tlist_WinWidth=35
let Tlist_Use_Right_Window=0 " 右侧显示

"map <silent> <F9> :TlistToggle<cr>
nnoremap <Leader>t :TlistToggle<cr>
nnoremap <Leader>n :NERDTree<cr>

"""""""""""""""""""""""""""""""""""""
" BufExplorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSortBy='mru' " most recently used
let g:bufExplorerSplitRight=0 " split left
let g:bufExplorerSplitBelow=1
let g:bufExplorerSplitVertical=1
let g:bufExplorerSplitVertSize=30
let g:bufExplorerUseCurrentWindow=1 " open in new window
autocmd BufWinEnter \[Buf\ List\] setl nonumber

""""""""""""""""""""""""""""""""""""
" OmniCppComplete
let OmniCpp_DisplayMode = 1 " 显示私有和公有成员
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1

" set tags+=/home/kjuly/ogre/OgreMain/tags
" set tags+=/home/kjuly/ogre/OgreMain/tags
" set tags+=/home/kjuly/ogre/Samples/tags
" set tags+=/usr/include/OGRE/tags
" map <silent> <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"map <silent> <F12> :!ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ .<CR>
" map <silent> <F12> :!ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

set tags+=~/.vim/tags/cpp
" set tags+=~/.vim/tags/python

""并非上述插件，但
" 全相关
set completeopt=longest,menu " 只在下拉菜单中显示匹配项目

""LessCSS highlight for .less file
au BufNewFile,BufRead *.less set filetype=less

""Object-C
let filetype_m='objc'

""LaTeX-Suite
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Customize setting for LaTeX-Suite
let g:Tex_DefaultTargetFormat='pdf' " \ll: compile to pdf format
