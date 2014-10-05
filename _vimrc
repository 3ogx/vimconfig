"======================================================================
"
" Author: beiwei <3ogx.com@gmail.com>
" Version: 0.1
" Date: 2014-09-28
" WebSite: http://3ogx.github.io
" LastModify: 2014-09-28
"
"======================================================================
" 设置 history 长度
set history =700

set guifont=Liberation\ Mono\ 11
" set guifont=Liberation_Mono:h8:w4:b:cDEFAULT

" 检测文件类型
filetype on

" 针对不同文件类型采用不同的缩进格式
filetype indent on

" 允许插件
filetype plugin on

" 启动自动补全
filetype plugin indent on 

" 关闭文件备份
set nobackup
set noswapfile

" 文件修改后自动载入
set autoread

" 启动时不显示帮助索
set shortmess=atI

" 去掉警告声音
set novisualbell
" 去掉错误声音
set noerrorbells

" 显示行号
" set number

" 取消换行
set nowrap

" 文件编码设置 
set encoding=utf-8
" set fileencoding=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,latin1
set helplang=cn
" set ffs = unix,doc,mac

set showmode
set showcmd
set ruler

" 命令行高度
set cmdheight=2

set smartcase
set smarttab

" 一个tab等于4个空格
set shiftwidth=4
set tabstop=4

" 高亮显示搜索结果
set hlsearch
set incsearch
set ignorecase

syntax on

" 配色方案
" colorscheme desert
" colorscheme molokai
set background=dark
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

"
set completeopt=longest,menu

set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

let mapleader = ','
let g:mapleader = ','
 
nmap <silent> <leader>w :w!<CR>
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>te :tabedit <C-R>=expand("%:p:h")<CR>/
nmap <leader>tn :tabnew<CR>
nmap <leader>to :tabonly<CR>
nmap <leader>tc :tabclose<CR>
nmap <leader>tm :tabmove
nmap <leader>tl :tabnext<CR>
nmap <leader>th :tabprevious<CR>
nmap <leader>q :q<CR>
nmap <leader>cd :cd %:p:h<CR>:pwd<CR>

" 强迫自己使用hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

map <c-a> <Home>
map <c-e> <End>

" Buffer 关闭
map <leader>bd :Bclose<CR>
map <leader>ba :1,1000 bd!<CR>
map <leader>ee :e! ~/.vimrc<CR>

noremap H 0
noremap L $

" 离开插入模式后关闭自动浏览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" .vimrc修改后自动加载
autocmd! bufwritepost .vimrc source %

" 自动执行
if has("autocmd")

	" 当插入模式设置行号
	autocmd InsertEnter * :set number
	" autocmd InsertLeave * :set relativenumber
	" 读取文件后设置行号
	autocmd BufRead * :set number
	" 文件类型为 yaml 时设置 tab 格式
	autocmd filetype yaml setlocal ts=2 sts=2 sw=2 expandtab
	autocmd filetype javascript setlocal ts=4 sts=4 sw=4 noexpandtab

	autocmd BufNewfile,BufRead *.rss setfiletype xml

endif

"================================================================================
" Define function
"================================================================================
" 检查当前文件是否被改变
function! HasPaste()
	if &paste
		return 'PASTE MODE '
	en
	return ' '
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"================================================================================
" Bundle Setup Start
"================================================================================
" set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///usr/share/nginx/www/vim/bundle/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
Plugin 'user/L9', {'name': 'newL9'}
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

call vundle#rc()

Bundle 'Solarized'
"let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"

Bundle 'molokai'
" let g:molokai_original=1

Plugin 'TabBar'

Bundle 'nerdtree-master'
map <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let g:netrw_home='~/bak'
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

" 更高效的移动 ,, + w/fx
" Bundle 'Lokaltog/vim-easymotion'

" Bundle 'vim-scripts/matchit.zip'


"标签导航
Bundle 'Tagbar'
Bundle 'tagbar-master'
nmap <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

"标签导航 要装ctags
Bundle 'taglist.vim'
set tags=tags;/
let Tlist_Ctags_Cmd="/usr/bin/ctags"
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Close_On_Select = 0
let Tlist_Compact_Format = 0
let Tlist_Display_Prototype = 0
let Tlist_Display_Tag_Scope = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Inc_Winwidth = 0
let Tlist_Max_Submenu_Items = 1
let Tlist_Max_Tag_Length = 30
let Tlist_Process_File_Always = 0
let Tlist_Show_Menu = 0
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "order"
let Tlist_Use_Horiz_Window = 0
let Tlist_Use_Right_Window = 0
let Tlist_WinWidth = 25

"for file search ctrlp, 文件搜索
Bundle 'ctrlp.vim'
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
    \ }
"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

"################### 显示增强 ###################"

"状态栏增强展示
Bundle 'Lokaltog/vim-powerline'
"if want to use fancy,need to add font patch -> git clone git://gist.github.com/1630581.git ~/.fonts/ttf-dejavu-powerline
"let g:Powerline_symbols = 'fancy'
let g:Powerline_symbols = 'unicode'


"括号显示增强
Bundle 'rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle = 0

"代码排版缩进标识
Bundle 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:indentLine_char = '¦'

"快速 加减注释
Bundle 'scrooloose/nerdcommenter'

" 快速加入修改环绕字符
Bundle 'tpope/vim-surround'
Bundle 'surround.vim'
"for repeat -> enhance surround.vim, . to repeat command
Bundle 'tpope/vim-repeat'

"自动补全单引号，双引号等
Bundle 'Raimondi/delimitMate'
" for python docstring ",优化输入
au FileType python let b:delimitMate_nesting_quotes = ['"']

"for code alignment
Bundle 'godlygeek/tabular'
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

"for visual selection
Bundle 'terryma/vim-expand-region'
map = <Plug>(expand_region_expand)
map - <Plug>(expand_region_shrink)

"for mutil cursor
Bundle 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'


"################# 语法检查 ###############

"迄今为止用到的最好的自动VIM自动补全插件
Bundle 'ucompleteme'
"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']

"################### 其他 ###################"
" task list
" Bundle 'TaskMotions'
Bundle 'TaskList.vim'
Bundle 'vim-task-org'
map <leader>td <Plug>TaskList

" util
Bundle 'UltiSnips'
let g:UltiSnipsUsePythonVersion = 2

" html 标签
Bundle 'sparkup'

" 文件修改记录
Bundle 'Gundo'
nnoremap <F5> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1

Bundle 'bad-whitespace'

" 个人知识管理
Bundle 'vimwiki'

"================================================================================
" Bundle Setup End
"================================================================================


colorscheme solarized
