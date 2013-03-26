" disable vi compatible mode (much better!)
set nocompatible

"" Feature check {{{
"if has("all_builtin_terms")
"  echomsg 'all_builtin_terms'
"endif
"if has("amiga")
"  echomsg 'amiga'
"endif
"if has("arabic")
"  echomsg 'arabic'
"endif
"if has("arp")
"  echomsg 'arp'
"endif
"if has("autocmd")
"  echomsg 'autocmd'
"endif
"if has("balloon_eval")
"  echomsg 'balloon_eval'
"endif
"if has("balloon_multiline")
"  echomsg 'balloon_multiline'
"endif
"if has("beos")
"  echomsg 'beos'
"endif
"if has("browse")
"  echomsg 'browse'
"endif
"if has("builtin_terms")
"  echomsg 'builtin_terms'
"endif
"if has("byte_offset")
"  echomsg 'byte_offset'
"endif
"if has("cindent")
"  echomsg 'cindent'
"endif
"if has("clientserver")
"  echomsg 'clientserver'
"endif
"if has("clipboard")
"  echomsg 'clipboard'
"endif
"if has("cmdline_compl")
"  echomsg 'cmdline_compl'
"endif
"if has("cmdline_hist")
"  echomsg 'cmdline_hist'
"endif
"if has("cmdline_info")
"  echomsg 'cmdline_info'
"endif
"if has("comments")
"  echomsg 'comments'
"endif
"if has("cryptv")
"  echomsg 'cryptv'
"endif
"if has("cscope")
"  echomsg 'cscope'
"endif
"if has("compatible")
"  echomsg 'compatible'
"endif
"if has("debug")
"  echomsg 'debug'
"endif
"if has("dialog_con")
"  echomsg 'dialog_con'
"endif
"if has("dialog_gui")
"  echomsg 'dialog_gui'
"endif
"if has("diff")
"  echomsg 'diff'
"endif
"if has("digraphs")
"  echomsg 'digraphs'
"endif
"if has("dnd")
"  echomsg 'dnd'
"endif
"if has("dos32")
"  echomsg 'dos32'
"endif
"if has("dos16")
"  echomsg 'dos16'
"endif
"if has("ebcdic")
"  echomsg 'ebcdic'
"endif
"if has("emacs_tags")
"  echomsg 'emacs_tags'
"endif
"if has("eval")
"  echomsg 'eval'
"endif
"if has("ex_extra")
"  echomsg 'ex_extra'
"endif
"if has("extra_search")
"  echomsg 'extra_search'
"endif
"if has("farsi")
"  echomsg 'farsi'
"endif
"if has("file_in_path")
"  echomsg 'file_in_path'
"endif
"if has("filterpipe")
"  echomsg 'filterpipe'
"endif
"if has("find_in_path")
"  echomsg 'find_in_path'
"endif
"if has("float")
"  echomsg 'float'
"endif
"if has("fname_case")
"  echomsg 'fname_case'
"endif
"if has("folding")
"  echomsg 'folding'
"endif
"if has("footer")
"  echomsg 'footer'
"endif
"if has("fork")
"  echomsg 'fork'
"endif
"if has("gettext")
"  echomsg 'gettext'
"endif
"if has("gui")
"  echomsg 'gui'
"endif
"if has("gui_athena")
"  echomsg 'gui_athena'
"endif
"if has("gui_gtk")
"  echomsg 'gui_gtk'
"endif
"if has("gui_gtk2")
"  echomsg 'gui_gtk2'
"endif
"if has("gui_gnome")
"  echomsg 'gui_gnome'
"endif
"if has("gui_mac")
"  echomsg 'gui_mac'
"endif
"if has("gui_motif")
"  echomsg 'gui_motif'
"endif
"if has("gui_photon")
"  echomsg 'gui_photon'
"endif
"if has("gui_win32")
"  echomsg 'gui_win32'
"endif
"if has("gui_win32s")
"  echomsg 'gui_win32s'
"endif
"if has("gui_running")
"  echomsg 'gui_running'
"endif
"if has("hangul_input")
"  echomsg 'hangul_input'
"endif
"if has("iconv")
"  echomsg 'iconv'
"endif
"if has("insert_expand")
"  echomsg 'insert_expand'
"endif
"if has("jumplist")
"  echomsg 'jumplist'
"endif
"if has("keymap")
"  echomsg 'keymap'
"endif
"if has("langmap")
"  echomsg 'langmap'
"endif
"if has("libcall")
"  echomsg 'libcall'
"endif
"if has("linebreak")
"  echomsg 'linebreak'
"endif
"if has("lispindent")
"  echomsg 'lispindent'
"endif
"if has("listcmds")
"  echomsg 'listcmds'
"endif
"if has("localmap")
"  echomsg 'localmap'
"endif
"if has("lua")
"  echomsg 'lua'
"endif
"if has("mac")
"  echomsg 'mac'
"endif
"if has("macunix")
"  echomsg 'macunix'
"endif
"if has("menu")
"  echomsg 'menu'
"endif
"if has("mksession")
"  echomsg 'mksession'
"endif
"if has("modify_fname")
"  echomsg 'modify_fname'
"endif
"if has("mouse")
"  echomsg 'mouse'
"endif
"if has("mouseshape")
"  echomsg 'mouseshape'
"endif
"if has("mouse_dec")
"  echomsg 'mouse_dec'
"endif
"if has("mouse_gpm")
"  echomsg 'mouse_gpm'
"endif
"if has("mouse_netterm")
"  echomsg 'mouse_netterm'
"endif
"if has("mouse_pterm")
"  echomsg 'mouse_pterm'
"endif
"if has("mouse_sysmouse")
"  echomsg 'mouse_sysmouse'
"endif
"if has("mouse_xterm")
"  echomsg 'mouse_xterm'
"endif
"if has("multi_byte")
"  echomsg 'multi_byte'
"endif
"if has("multi_byte_encoding")
"  echomsg 'multi_byte_encoding'
"endif
"if has("multi_byte_ime")
"  echomsg 'multi_byte_ime'
"endif
"if has("multi_lang")
"  echomsg 'multi_lang'
"endif
"if has("mzscheme")
"  echomsg 'mzscheme'
"endif
"if has("netbeans_intg")
"  echomsg 'netbeans_intg'
"endif
"if has("netbeans_enabled")
"  echomsg 'netbeans_enabled'
"endif
"if has("ole")
"  echomsg 'ole'
"endif
"if has("os2")
"  echomsg 'os2'
"endif
"if has("osfiletype")
"  echomsg 'osfiletype'
"endif
"if has("path_extra")
"  echomsg 'path_extra'
"endif
"if has("perl")
"  echomsg 'perl'
"endif
"if has("persistent_undo")
"  echomsg 'persistent_undo'
"endif
"if has("postscript")
"  echomsg 'postscript'
"endif
"if has("printer")
"  echomsg 'printer'
"endif
"if has("profile")
"  echomsg 'profile'
"endif
"if has("python")
"  echomsg 'python'
"endif
"if has("qnx")
"  echomsg 'qnx'
"endif
"if has("quickfix")
"  echomsg 'quickfix'
"endif
"if has("reltime")
"  echomsg 'reltime'
"endif
"if has("rightleft")
"  echomsg 'rightleft'
"endif
"if has("ruby")
"  echomsg 'ruby'
"endif
"if has("scrollbind")
"  echomsg 'scrollbind'
"endif
"if has("showcmd")
"  echomsg 'showcmd'
"endif
"if has("signs")
"  echomsg 'signs'
"endif
"if has("smartindent")
"  echomsg 'smartindent'
"endif
"if has("sniff")
"  echomsg 'sniff'
"endif
"if has("startuptime")
"  echomsg 'startuptime'
"endif
"if has("statusline")
"  echomsg 'statusline'
"endif
"if has("sun_workshop")
"  echomsg 'sun_workshop'
"endif
"if has("spell")
"  echomsg 'spell'
"endif
"if has("syntax")
"  echomsg 'syntax'
"endif
"if has("syntax_items")
"  echomsg 'syntax_items'
"endif
"if has("system")
"  echomsg 'system'
"endif
"if has("tag_binary")
"  echomsg 'tag_binary'
"endif
"if has("tag_old_static")
"  echomsg 'tag_old_static'
"endif
"if has("tag_any_white")
"  echomsg 'tag_any_white'
"endif
"if has("tcl")
"  echomsg 'tcl'
"endif
"if has("terminfo")
"  echomsg 'terminfo'
"endif
"if has("termresponse")
"  echomsg 'termresponse'
"endif
"if has("textobjects")
"  echomsg 'textobjects'
"endif
"if has("tgetent")
"  echomsg 'tgetent'
"endif
"if has("title")
"  echomsg 'title'
"endif
"if has("toolbar")
"  echomsg 'toolbar'
"endif
"if has("unix")
"  echomsg 'unix'
"endif
"if has("user_commands")
"  echomsg 'user_commands'
"endif
"if has("viminfo")
"  echomsg 'viminfo'
"endif
"if has("vim_starting")
"  echomsg 'vim_starting'
"endif
"if has("vertsplit")
"  echomsg 'vertsplit'
"endif
"if has("virtualedit")
"  echomsg 'virtualedit'
"endif
"if has("visual")
"  echomsg 'visual'
"endif
"if has("visualextra")
"  echomsg 'visualextra'
"endif
"if has("vms")
"  echomsg 'vms'
"endif
"if has("vreplace")
"  echomsg 'vreplace'
"endif
"if has("wildignore")
"  echomsg 'wildignore'
"endif
"if has("wildmenu")
"  echomsg 'wildmenu'
"endif
"if has("windows")
"  echomsg 'windows'
"endif
"if has("winaltkeys")
"  echomsg 'winaltkeys'
"endif
"if has("win16")
"  echomsg 'win16'
"endif
"if has("win32")
"  echomsg 'win32'
"endif
"if has("win64")
"  echomsg 'win64'
"endif
"if has("win32unix")
"  echomsg 'win32unix'
"endif
"if has("win95")
"  echomsg 'win95'
"endif
"if has("writebackup")
"  echomsg 'writebackup'
"endif
"if has("xfontset")
"  echomsg 'xfontset'
"endif
"if has("xim")
"  echomsg 'xim'
"endif
"if has("xsmp")
"  echomsg 'xsmp'
"endif
"if has("xsmp_interact")
"  echomsg 'xsmp_interact'
"endif
"if has("xterm_clipboard")
"  echomsg 'xterm_clipboard'
"endif
"if has("xterm_save")
"  echomsg 'xterm_save'
"endif
"if has("x11")
"  echomsg 'x11'
"endif
"" }}}

" neobundle {{{

"" usage:
" :NeoBundle       " update plugins below
" :NeoBundleInstall" install plugins below
" :NeoBundleClean  " remove plugins removed from below

filetype off " required for neobundle
"" set path
if has('vim_starting')
  let bundledir=expand('~/.vim/bundle')
  let neobundledir=bundledir . '/neobundle.vim'
  let &runtimepath = &runtimepath . ',' . neobundledir
  if ! isdirectory(neobundledir)
    echomsg 'Neobundle is not installed, install now '
    call system('git clone git://github.com/Shougo/neobundle.vim '
          \ .  neobundledir)
  endif
  call neobundle#rc(bundledir)
endif

""""plugins"""""
" neobundle
NeoBundle 'Shougo/neobundle.vim'

"" asynchronous execution library: need for vimshell, Gmail, unite, etc...?
NeoBundleLazy 'Shougo/vimproc', {
      \  'build' : {
      \    'windows' : 'make -f make_mingw32.mak',
      \    'cygwin' : 'make -f make_cygwin.mak',
      \    'mac' : 'make -f make_mac.mak',
      \    'unix' : 'make -f make_unix.mak',
      \  },
      \}


" use shell in vim
NeoBundleLazy 'Shougo/vimshell',{
      \  'autoload' : {'commands': ['VimShell']},
      \  'depends' : ['Shougo/vimproc']
      \}

" searches and display information->:help Unite
" unlike 'fuzzyfinder' or 'ku', it doesn't use the built-lin completion of vim
NeoBundleLazy 'Shougo/unite.vim',{
      \  'autoload' : {'commands': ['Unite','UniteWithBufferDir']}
      \}

" completion
"NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'Shougo/neosnippet'

" for git/svn status, log
"NeoBundle 'hrsh7th/vim-versions.git'

" quick run
"NeoBundle 'thinca/vim-quickrun'

" Vim plugin to highlight matchit.vim
NeoBundle 'vimtaku/hl_matchit.vim'

" easy to change surround
NeoBundle 'surround.vim'

" easy to use history of yanks (see below seeting)
"NeoBundle 'vim-scripts/YankRing.vim'

" use yanks in different processes (see below setting)
NeoBundle 'yanktmp.vim'

" check undo: there seems trouble on python setting...
"NeoBundle 'Gundo'

" another undo, need vim7.3+patch005
"NeoBundle 'mbbill/undotree'

" toggle insert words
"NeoBundle 'kana/vim-smartchr'

" visualize marks
NeoBundle 'zhisheng/visualmark.vim'
"NeoBundle 'Visual-Mark'

" Align
" http://www.drchip.org/astronaut/vim/align.html#Examples
NeoBundle 'Align'


" add markdown
NeoBundle 'tpope/vim-markdown'

" folding method for python, but makes completion too slow...?
"NeoBundle 'vim-scripts/python_fold'

" currently use only for python indent...
NeoBundle 'yuroyoro/vim-python'

" applescript
NeoBundle 'applescript.vim'

" Cool Status Line
"NeoBundle 'Lokaltog/vim-powerline'

" visual indent guides
NeoBundle 'nathanaelkane/vim-indent-guides'

" sub mode
NeoBundle 'kana/vim-submode'

" easymotion
"NeoBundle 'Lokaltog/vim-easymotion'

" can use f instead of ;, after fx move
" can move even to other lines
"NeoBundle 'rhysd/clever-f.vim'

" jump to letters (two letters) after 's'
"NeoBundle 'goldfeld/vim-seek'

" python complete (don't work?)
"NeoBundle 'davidhalter/jedi'

" Gmail
NeoBundleLazy 'yuratomo/gmail.vim',{
      \  'autoload' : {'commands': ['Gmail']},
      \  'depends' : ['Shougo/vimproc']
      \}

" SimpleNote
NeoBundle 'mattn/webapi-vim'
NeoBundleLazy 'mattn/vimplenote-vim',{
      \  'autoload' : {'commands': ['VimpleNote']},
      \}
NeoBundleLazy 'mrtazz/simplenote.vim',{
      \  'autoload' : {'commands': ['Simplenote']},
      \}

" evernote: need markdown library...
NeoBundleLazy 'kakkyz81/evervim',{
      \  'autoload' : {'commands': ['EvervimNotebookList', 'EvervimListTags',
      \                             'EvervimSearchByQuery', 'EvervimCreateNote',
      \                             'EvervimOpenBrowser', 'EvervimSetup']},
      \}

" make benchmark result of vimrc
NeoBundleLazy 'mattn/benchvimrc-vim',{
      \  'autoload' : {'commands': ['BenchVimrc']},
      \}

" color scheme
"NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tomasr/molokai'
"NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'vim-scripts/newspaper.vim'
NeoBundle 'w0ng/vim-hybrid'

""""plugins"""""

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
    \ string(neobundle#get_not_installed_bundle_names())
  "echomsg 'Please execute ":NeoBundleInstall" command.'
  NeoBundleInstall
  "finish
endif

" enable plugin, indent again
filetype plugin indent on
" }}} neobundle

" basic settings {{{

" set my auto group
augroup myaugroup
  autocmd!
augroup END

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch

" allow backspacing over everything in insert mode
" indent: spaces of the top of the line
" eol   : break
" start : character before the starting point of the insert mode
set backspace=indent,eol,start

set modeline       " enable to use settings written in the file
                   " use with comment lines: e.g.)
                   " # vim set foldmethod=marker:
                   " # vim set foldmarker={{{,}}}:
set modelines=5    " number of lines to be read (form top and bottom) for
                   " modeline
set tabstop=4      " width of <Tab> in view
set shiftwidth=2   " width for indent
set softtabstop=0  " if not 0, insert space instead of <Tab>
"set textwidth=0    " longer line than textwidth will be broken (0: disable)
autocmd myaugroup FileType *  setlocal textwidth=0 " overwrite ftplugin settings
set colorcolumn=80 " put line on 80
"set colorcolumn=+1 " put line on textwidth+1
set wrap           " the longer line is wrapped
set expandtab      " do :retab -> tab->space

set nobackup       " do not keep a backup file, use versions instead

if has("win32unix") || has ("win64unix") || has("win32") || has ("win64")
  set directory=$TMP/ " for windows
elseif has("unix") || has("mac")
  set directory=$TMPDIR/ " directory for swap file for unix/mac
endif
"set viminfo+=n~/.vim/viminfo.txt

set history=100    " keep 100 lines of command line history

"set incsearch      " do incremental searching
"set ignorecase     " ignore case for search
set smartcase      " noignorecase, if the pattern include Capital
set nowrapscan     " stop search at the edge of the file

set nrformats=hex  " not use cotal, alpha for increment or decrement
set t_Co=256       " enable 256 colors
set list           " show tab, end, trail empty
set listchars=tab:>-,extends:<,trail:- " set words for above
set ruler          " show the cursor position all the time
set showcmd        " display incomplete commands
set novisualbell   " no visual bell
set cursorline     " enable highlight on current line:
                   " but make moving cursor slow for heavily highlighted file...
set nonumber       " don't show line numbers
set autoindent
set scrolloff=999  " show cursor at middle 
                   " (scrolloff is number of lines which should be shown above
                   " and below cursor.
                   "  such large number force to stay a cursor at middle

set spell          " spell check highlight

" ime setting
if has('multi_byte_ime') || has('xim')
  set iminsert=0
  set imsearch=0
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

" encode
"if has("windows")
"  scriptencoding cp932 " sjis
"  set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
"else " if has("unix") || has("mac")
"  set fileencodings=iso-2022-jp,euc-jp,sjis,ucs-bom,default,latin1,utf-8
"endif
"if has('gui_running') && !has('unix')
"  set encoding=utf-8
"endif
"set encoding=utf-8
"set encoding=cp932
"set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin
"set fileencodings=iso-2022-jp,euc-jp,sjis,ucs-bom,default,latin1,utf-8
"autocmd myaugroup FileType vbs :set fileencoding=sjis
"autocmd myaugroup FileType vbs :set encoding=sjis

" automatic ime off
if has("mac")
  set noimdisableactivate
endif

" bash-like tab completion
set wildmode=list:longest
set wildmenu

" folding
set foldmethod=marker
"set foldmarker={{{,}}} "default
autocmd myaugroup FileType cxx,C,py set foldmethod=syntax
set foldlevel=0
set foldnestmax=1

" When editing a file, always jump to the last known cursor position.
autocmd myaugroup BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" set current directory as a directory of the file
"autocmd myaugroup BufEnter *   execute ":lcd " . expand("%:p:h")

" avoid automatic comment out for the next line after the comment lines
autocmd myaugroup FileType * setlocal formatoptions-=ro

" INSERT (paste)
"set paste " use 'paste at normal mode' in below, instead

" arrow to open new file while current file is not saved
set hidden

" virtualedit (can move to non-editing places: e.x. right of $)
set virtualedit=all
" avoid to paste/insert in non-editing place
if has('virtualedit') && &virtualedit =~# '\<all\>'
  nnoremap <expr> p (col('.') >= col('$') ? '$' : '') . 'p'
  nnoremap <expr> i (col('.') >= col('$') ? '$' : '') . 'i'
  nnoremap <expr> a (col('.') >= col('$') ? '$' : '') . 'a'
  nnoremap <expr> r (col('.') >= col('$') ? '$' : '') . 'r'
  nnoremap <expr> R (col('.') >= col('$') ? '$' : '') . 'R'
  " autocmd is needed to overwrite YRShow's map,
  " and "_x to avoid register 1 letter
  autocmd myaugroup FileType * nnoremap <expr> x (col('.') >= col('$') ? '$' : '') . '"_x'
endif

" max columns for syntax search 
" Such XML file has too much syntax which make vim drastically slow
set synmaxcol=500 "default 3000

" Disable highlight italic in Markdown
autocmd! FileType markdown hi! def link markdownItalic LineNr

" }}} basic settings

" colors {{{
"colorscheme molokai
colorscheme ron
"colorscheme blue

" for spell checks
hi SpellBad cterm=inverse ctermbg=0

" only underline for cursorline
hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" Set all white characters on black background for current line
"hi CursorLine cterm=underline ctermfg=white ctermbg=black
au myaugroup InsertEnter * hi CursorLine cterm=underline,bold ctermfg=NONE ctermbg=NONE
au myaugroup InsertLeave * hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE

" colors for completion
hi Pmenu ctermbg=255 ctermfg=0 guifg=#000000 guibg=#999999
hi PmenuSel ctermbg=blue ctermfg=black
hi PmenuSbar ctermbg=0 ctermfg=9
hi PmenuSbar ctermbg=255 ctermfg=0 guifg=#000000 guibg=#FFFFFF

" column
hi ColorColumn ctermbg=234

"" colors for diff mode
hi DiffAdd ctermbg=17 guibg=slateblue
hi DiffChange ctermbg=22 guibg=darkgreen
hi DiffText cterm=bold ctermbg=52 gui=bold guibg=olivedrab
hi DiffDelete term=bold ctermfg=12 ctermbg=6 gui=bold guifg=Blue guibg=coral


" }}} colorscheme

" diff mode {{{
if &diff
  "set wrap " not work...
  set nospell
endif
function! SetDiffWrap()
  if &diff
    set wrap
    wincmd w
    set wrap
    wincmd w
  endif
endfunction
autocmd myaugroup VimEnter,FilterWritePre * call SetDiffWrap()
" }}} diff mode

" DiffOrig {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
" }}} DiffOrig

" undo {{{
if has('persistent_undo')
  let vimundodir=expand('~/.vim/undo')
  let &undodir = vimundodir
  if ! isdirectory(vimundodir)
    call system('mkdir ' . vimundodir)
  endif
  set undofile
  set undoreload=10000
endif
set undolevels=1000
" }}} undo

" Unite {{{
autocmd myaugroup FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  nmap <buffer><Esc> <Plug>(unite_exit)
  imap <buffer><Esc><Esc> <Plug>(unite_exit)
endfunction
" start with insert mode (can start narrow result in no time)
let g:unite_enable_start_insert=1
" window
"let g:unite_enable_split_vertically=1
let g:unite_split_rule='botright' " default topleft
let g:unite_winheight=10          " default 20
let g:unite_winwidth=60           " default 90
" show buffer
nnoremap <silent> ,ub :Unite buffer<CR>
" show files/directories with full path
" -buffer-name-files enable to use wild card
"nnoremap <silent> ,uf :UniteWithBufferDir -buffer-name=files file<CR>
" WithBufferDir for file search freezes when try to delete even current
" directory names in insert mode...
nnoremap <silent> ,uf :Unite -buffer-name=files file<CR>
" show register
nnoremap <silent> ,ur :Unite -buffer-name=register register<CR>
" show opened file history including current buffers
nnoremap <silent> ,um :UniteWithBufferDir -buffer-name=files buffer file_mru<CR>
" show lines of current file
nnoremap <silent> ,ul :Unite line<CR>
" }}} Unite

" Align {{{
noremap ,a= :Align =<CR>
noremap ,a" :Align "<CR>
noremap ,a# :Align #<CR>
" }}} Align

" vim-smartchr {{{
"inoremap <buffer><expr> = smartchr#one_of(' = ', ' == ', '=')
" }}} vim-smartchr

"" YankRing {{{
"
"nnoremap ,y :YRShow<CR>
"" avoid to store single letter to normal register
"let g:yankring_history_dir=$HOME.'/.vim/'
""let g:yankring_n_keys = 'Y D' " Y D x X
""let g:yankring_enabled=0 " 1
"let g:yankring_max_history=50 " 100
"let g:yankring_max_display=50 " 500
""let g:yankring_ignore_duplicate=0 " 1
"let g:yankring_dot_repeat_yank=1
"let g:yankring_clipboard_monitor=0 " 1
"let g:yankring_min_element_length=2 " 1, :skip all single letter copy
""let g:yankring_persist=0 " 1
""let g:yankring_share_between_instances=0 " 1
""let g:yankring_window_use_separate=0 " 1
""let g:yankring_window_use_horiz=0
""let g:yankring_window_auto_close=0 " 1
"let g:yankring_window_width=50 " 30
""let g:yankring_window_use_right=0 " 1
""let g:yankring_window_increment=15 " 1
"let g:yankring_manage_numbered_reg = 1 " 0
""let g:yankring_paste_check_default_register = 0 "1
"
"" for warning :The yankring can only persist if the viminfo setting has a !
""set viminfo+=!
"
"" }}} YankRing

" yanktmp {{{
let g:yanktmp_file = $HOME.'/.vim/vimyanktmp'
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>
" }}} yanktmp

" status line {{{
set laststatus=2 " always show
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
" }}} status line

" neocomplcache {{{
"let g:neocomplcache_enable_at_startup = 1 " enable at start up
"let g:neocomplcache_smartcase = 1 " distinguish capital and 
"let g:neocomplcache_enable_camel_case_completion = 1 
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_min_syntax_length = 3
" }}}

" matchpair, matchit {{{
"set matchpairs = (:),{:},[:]
set matchpairs+=<:>
source $VIMRUNTIME/macros/matchit.vim
" matchpairs is necessary...?
"let b:match_words = &matchpairs . ',<:>,<div.*>:</div>,if:fi'
let b:match_words = &matchpairs . ',<:>,<div.*>:</div>'
let b:match_ignorecase = 1
" }}} matchpair, matchit

" for hl_matchit {{{
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft_regexp = 'html\|vim\|ruby\|sh'
"" }}} hl_matchit

" paste at normal mode{{{

" if not well work... (though it seems working)
" need more understanding of vim/screen pasting...
" can use :a! for temporally paste mode
" or :set paste ,....., :set nopaste
" or set noautoindent, ...., : set autoindent

" it seems working in Mac, but not in Windows (putty+XWin)

if &term =~ "screen" || &term =~ "xterm"
  if &term =~ "screen"
    let &t_SI = &t_SI . "\eP\e[?2004h\e\\"
    let &t_EI = "\eP\e[?2004l\e\\" . &t_EI
    let &pastetoggle = "\e[201~"
  else
    let &t_SI .= &t_SI . "\e[?2004h"
    let &t_EI .= "\e[?2004l" . &t_EI
    let &pastetoggle = "\e[201~"
  endif
  function! XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction
  imap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" }}} paste

" vim-easymotion{{{
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
"let g:EasyMotion_keys='ifjklasdweuocvbnm'
let g:EasyMotion_do_mapping=0
let g:EasyMotion_leader_key=","
let g:EasyMotion_grouping=1
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue
" }}} vim-easymotion

" jedi-vim{{{
"let g:jedi#auto_initialization = 0
"let g:jedi#auto_vim_configuration = 0
"let g:jedi#goto_command = "<leader>g"
"let g:jedi#get_definition_command = "<leader>d"
"let g:jedi#pydoc = "K"
"let g:jedi#autocompletion_command = "<C-Space>"
" }}} jedi-vim

" SimpleNote{{{
" for simplenote.vim
"let g:SimplenoteUsername = ''
"let g:SimplenotePassword = ''
if filereadable(expand('$HOME/.Simplenote.vim'))
  source $HOME/.Simplenote.vim
endif

" for vimplenote-vim
"let g:VimpleNoteUsername = ''
"let g:VimpleNotePassword = ''
" move to $HOME/.VimpleNote
if filereadable(expand('$HOME/.VimpleNote.vim'))
  " in vimplenote/autoload/vimplenote.vim:get_email(),
  " email must be input even if VimpleNoteUsername was defined,
  " because it checks self.token, it is always 0 here...
  source $HOME/.VimpleNote.vim
endif

function! Sn()
  VimpleNote -l
  wincmd w
  wincmd q
endfunction

" }}} Simplenote

" Gmail{{{
let g:gmail_imap = 'imap.gmail.com:993'
let g:gmail_smtp = 'smtp.gmail.com:465'
" path for openssl
let &path = $path.'/usr/bin'
if filereadable(expand('$HOME/.Gmail.vim'))
  source $HOME/.Gmail.vim
endif
" }}} Gmail

" vim-indent-guides{{{
let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size =  1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0

"autocmd myaugroup VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=lightgray
"autocmd myaugroup VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray
autocmd myaugroup VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd myaugroup VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
"}}} vim-indent-guides

" vim-submode{{{
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>e', '<C-w>><C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w><C-e>', '<C-w>><C-w><')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')
call submode#map('winsize', 'n', '', 'l', '<C-w>>')
call submode#map('winsize', 'n', '', 'h', '<C-w><')
call submode#map('winsize', 'n', '', 'j', '<C-w>-')
call submode#map('winsize', 'n', '', 'k', '<C-w>+')
call submode#map('winsize', 'n', '', '=', '<C-w>=')
"}}} vim-submode

" applescript{{{
autocmd myaugroup bufnewfile,bufread *.scpt,*.applescript :setl filetype=applescript
"autocmd myaugroup FileType applescript :inoremap <buffer> <S-CR>  ￢<CR>
"}}} applescript

" map (for other than each plugin){{{
" remapping, tips

" n  Normal mode map. Defined using ':nmap' and ':nnoremap'.
" i  Insert mode map. Defined using ':imap' and ':inoremap'.
" v  Visual and select mode map. Defined using ':vmap' and ':vnoremap'.
" x  Visual mode map. Defined using ':xmap' and ':xnoremap'.
" s  Select mode map. Defined using ':smap' and ':snoremap'.
" c  Command-line mode map. Defined using ':cmap' and ':cnoremap'.
" o  Operator pending mode map. Defined using ':omap' and ':onoremap'.
"
" map and noremap:  normal + visual
" nmap! and nnoremap!: other than normal mode
"
" Note that if the 'paste' option is set, then insert mode maps are disabled.

" <C-h> == <BS>
" <C-i> == <Tab>
" <C=l> == <FF> (formfeed)
" <C-j> == <NL> (next line)
" <C=m> == <CR> (return)
" *** should not use <C-i> and <C-m> for mappings!
" If you set mappings for <C-i> and <C-m>,
" the mapping will also be enabled for <Tab> and <CR>, respectively.
" Others seems no having such functionality...?



" Don't use Ex mode, use Q for formatting
"map Q gq

""" normal mode (noremap)

" enter command line mode
"nnoremap ; :

"" cursor move
" Left (C-h default: <BS> ~ h)
"nnoremap <C-h> h
" Right (C-j default: <NL> ~ j)
"nnoremap <C-j> j
" Up (C-k default: Non)
nnoremap <C-k> k
" Down (C-l default: Clear and redraw the screen)
nnoremap <C-l> l
" Go to Head (C-a default: Increment)
nnoremap <C-a> 0
" Go to End (C-e default: Scroll down)
nnoremap <C-e> <C-$>
" Substitute for C-a (C-q default: C-V alternative for gui mode)
"nnoremap <C-q> <C-a> " not work...
" Substitute for C-a (C-z default: suspend, same as :stop)
"nnoremap <C-z> <C-a>
" Substitute for C-a (C-s default: non?)
nnoremap <C-s> <C-a>

" tag jump (avoid crash with screen's key bind, C-' default: Non?)
nnoremap <C-'> <C-t>
" spell check toggle
nnoremap <silent> ,s :set spell!<CR>
" stop highlight for search
"nnoremap <C-/> :noh<CR> " can't use C-/ ?
"nnoremap <Esc> :noh<CR> " this makes something wrong
                         " at start when using vim w/o screen...
"nnoremap <silent> <Esc><Esc> :noh<CR> " Esc mapping may be used others,
                                       " better to use others...
nnoremap <silent> ,n :noh<CR>
" direct indent
" this makes trouble at visual mode (indent twice for current line)
"nnoremap > >>
"nnoremap < <<
" alignment at normalmode
nnoremap = v=
" don't register single letter by x
"nnoremap x "_x " set in virtualedit

" window
"nnoremap <C-w><C-c> <C-w><C-c> "not work, because <C-c> cancels the command

" insert file name
"nnoremap <silent> ,f i<CR><Esc><BS>:r!echo %<CR>i<BS><Esc>Jx
nnoremap <silent> ,f "%P
nnoremap <silent> ,d i<CR><Esc><BS>:r!echo %:p:h<CR>i<BS><Esc>Jx
nnoremap <silent> "+ "+P
nnoremap <silent> "* "*P

" save/quit
nnoremap ,w :w<CR>
nnoremap ,q :q<CR>
nnoremap ,wq :wq<CR>
nnoremap ,1 :q!<CR>

" insert mode (inoremap)

" emacs (bash) like move in insert mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
inoremap <C-h> <Backspace>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" insert file/directory name
"inoremap <silent> ,f <CR><Esc><BS>:r!echo %<CR>i<BS><Esc>Jxi
inoremap <silent> ,f <C-R>%
inoremap <silent> ,d <CR><Esc><BS>:r!echo %:p:h<CR>i<BS><Esc>Jxi


" < can't be used for mapping?
" (maybe < has special means in vim scripts and need special treatment)
"inoremap <> <><Left>
"inoremap '' ''<Left>
"inoremap "" ""<Left>
"inoremap () ()<Left>
"inoremap [] []<Left>
"inoremap {} {}<Left>

"inoremap < <><Left>
""inoremap ' ''<Left>
""inoremap " ""<Left>
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap { {}<Left>
"
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

""" visual mode (vnoremap)

"  is not necessary?
vnoremap { "zdi{<C-R>z}<Esc>
vnoremap [ "zdi[<C-R>z]<Esc>
vnoremap ( "zdi(<C-R>z)<Esc>
vnoremap " "zdi"<C-R>z"<Esc>
vnoremap ' "zdi'<C-R>z'<Esc>

""" command line mode (cnoremap)
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <C-b>

" }}} map

" tips {{{
"" # startup tips
"" * start w/o vimrc
""     vim -u NONE
"" * start w/o viminfo
""     vim -i NONE
"" * start w/o X connection
""     vim -X
"" * write startup timing to startup.log
""     vim --startuptime startup.log
""
"" # check configurations
"" * default commands (mappings)
""     :help index.txt
"" * my mappings
""     :nmap " show mappings for normal mode
"" *show mappings for normal mode with name of file
""  in which the mapping is defined
""     :verbose nmap
"" * for boolean parameters, use '?'
""     :verbose wrap?
""
"' # mapping
"" * leader: default <leader> = \
"" but leader can be changed by
""     let mapleader = ","
"" * special arguments:<silent>,<buffer>, etc...
""     :no a <silent> echo 'hoge'<CR>
"" it doesn't show cmmands/results in command line (so above does nothing)
""     :no a <buffer>... effective in the current buffer only
"" 
""
"" # Command line
"" * shell command
""     :! echo current file is %
"" % will be replaced by name of current file
""
"" * Insert command result
""     :r ! echo % " insert current file name
""     :r ! echo %:p " full path of file
""     :r ! echo %:h " insert current directory (relative)
""     :r ! echo %:p:h " insert current directory (absolute)
""     :r ! echo expand(%:p:h) " expand such '~'
""     :r !ls "files/directories in current directory
""
""
""
"" # Completion
""     i_C-X_C-F -> file name completion
""     i_C-X_C-K -> dictionary completion
""     i_C-V_tab -> insert tab
""     i_C-R_%   -> insert current file name
""        other C-R usages
""        '"'     the unnamed register, containing the text of
""                the last delete or yank
""        '%'     the current file name
""        '#'     the alternate file name
""        '*'     the clipboard contents (X11: primary selection)
""        '+'     the clipboard contents
""        '/'     the last search pattern
""        ':'     the last command-line
""        '-'     the last small (less than a line) delete
""        '.'     the last inserted text
""                                        *c_CTRL-R_=*
""        '='     the expression register: you are prompted to
""                enter an expression (see |expression|)
""                (doesn't work at the expression prompt; some
""                things such as changing the buffer or current
""
"" # vimdiff
"" * Open files
""     vimdiff file1 file2 [file3 [file4]]
"" * Open vimdiff during editing with vim
""     :vertical diffsplit filename
""     vimdiff file1 file2 [file3 [file4]]
"" * Go to Next Diff
""     [c
"" * Go to Previous Diff
""     ]c
"" * Copy current buffer's structure to another structure
""     do
"" * Copy another's buffer's structure to current structure
""     dp
""
"" # Register
"" * Show words in register
""     :reg
"" * Others
""   *Unnamed (") register is used for all copy/delete
""   *0 register is only used for copy
""   *"0p makes it possible to paste what you copied
""    even after you deleted something
""   ** register is used for clipboard
""   */ is used for word used for searching
""   *"ayy registers current line to register a
""   *"ap copies a register in normal mode
""   *<C-R>" : copy unnamed register in insert mode
""   *<C-R>a : copy a register in insert mode
""
"" # buffer
"" * show buffers
""     :ls
"" * go to next buffer, previous buffer
""     :bn , :bp
"" * go to buffer N
""     :b N or N<C-^>
""
"" # spell check
"" * suggest correct words
""     z=
"" * next missspelled word
""     ]s
"" * previous missspelled word
""     [s
"" * add word under the cursor to good word list file
""     zg
"" * add word under the cursor to good internal-wordlis
""     zG
"" * mark word under the cursor as bad, remove word from good word list file
""     zw
"" * mark word under the cursor as bad, remove word from good internal-wordlist
""     zW
""
"" * undo zg/G/w/W
""    zug/zuG/zuw/zuW
" }}} tips
