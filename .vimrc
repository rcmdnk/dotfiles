" disable vi compatible mode (much better!)
set nocompatible

" neobundle {{{

"" usage:
" :NeoBundleUpdate " update plugins below
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

" File Explorer
"NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'scrooloose/nerdtree'

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

" easy to use history of yanks (see below settings)
"NeoBundle 'vim-scripts/YankRing.vim'

" use yanks in different processes (see below settings)
"NeoBundle 'yanktmp.vim'

" check undo: there seems trouble on python setting...
"NeoBundle 'Gundo'

" gundo (dfferent from Gundo?)
NeoBundle 'sjl/gundo.vim'

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
"NeoBundle 'tpope/vim-markdown'
NeoBundle 'plasticboy/vim-markdown'

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

" open browser
NeoBundle 'tyru/open-browser.vim'

" easymotion
"NeoBundle 'Lokaltog/vim-easymotion'

" can use f instead of ;, after fx move
" can move even to other lines
"NeoBundle 'rhysd/clever-f.vim'

" jump to letters (two letters) after 's'
"NeoBundle 'goldfeld/vim-seek'

" python complete (don't work?)
"NeoBundle 'davidhalter/jedi'

" LanguageTool
NeoBundle 'vim-scripts/LanguageTool'

" Gmail
"NeoBundleLazy 'yuratomo/gmail.vim',{
"      \  'autoload' : {'commands': ['Gmail']},
"      \  'depends' : ['Shougo/vimproc']
"      \}

" SimpleNote
"NeoBundle 'mattn/webapi-vim'
"NeoBundleLazy 'mattn/vimplenote-vim',{
"      \  'autoload' : {'commands': ['VimpleNote']},
"      \}
"NeoBundleLazy 'mrtazz/simplenote.vim',{
"      \  'autoload' : {'commands': ['Simplenote']},
"      \}

" evernote: need markdown library...
"NeoBundleLazy 'kakkyz81/evervim',{
"      \  'autoload' : {'commands': ['EvervimNotebookList', 'EvervimListTags',
"      \                             'EvervimSearchByQuery', 'EvervimCreateNote',
"      \                             'EvervimOpenBrowser', 'EvervimSetup']},
"      \}

" make benchmark result of vimrc
"NeoBundleLazy 'mattn/benchvimrc-vim',{
"      \  'autoload' : {'commands': ['BenchVimrc']},
"      \}

" Syntax
"NeoBundle 'scrooloose/syntastic'

" Count searching objects
NeoBundle 'osyo-manga/vim-anzu'

" Git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'

" Singletop
"NeoBundle 'thinca/vim-singleton'

" splash
"NeoBundle 'thinca/vim-splash'

" Habatobi 
NeoBundleLazy 'mattn/habatobi-vim',{
      \  'autoload' : {'commands': ['Habatobi']},
      \}


" color scheme
"NeoBundle 'ujihisa/unite-colorscheme'
"NeoBundle 'tomasr/molokai'
"NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'vim-scripts/newspaper.vim'
"NeoBundle 'w0ng/vim-hybrid'

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

""" mapleaader (<Leader>)
let mapleader = ","
" use \ as ,
noremap \ ,

" allow backspacing over everything in insert mode
" indent: spaces of the top of the line
" eol   : break
" start : character before the starting point of the insert mode
set backspace=indent,eol,start

set modeline       " enable to use settings written in the file
                   " use with comment lines: e.g.)
                   " # vim set foldmethod=marker:
                   " # vim set foldmarker={{{,}}}:
set modelines=3    " number of lines to be read (form top and bottom) for
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
set viminfo+=n~/.viminfo

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
autocmd myaugroup FileType py set foldmethod=syntax
autocmd myaugroup FileType cpp,cxx,C set foldmethod=marker foldmarker={,}
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
  nnoremap <expr> . (col('.') >= col('$') ? '$' : '') . '.'
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

hi CursorLine cterm=none ctermfg=NONE ctermbg=NONE
" only underline for cursorline
"hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" Set all white characters on black background for current line
"hi CursorLine cterm=underline ctermfg=white ctermbg=black
"au myaugroup InsertEnter * hi CursorLine cterm=underline,bold ctermfg=NONE ctermbg=NONE
"au myaugroup InsertLeave * hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE

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
  set undoreload=1000
endif
set undolevels=1000
" }}} undo

" Unite {{{
if ! empty(neobundle#get("unite.vim"))

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

" Unite prefix
nnoremap [unite] <Nop>
nmap <Leader>u [unite]

" show buffer
nnoremap <silent> [unite]b :Unite buffer<CR>
" show files/directories with full path
" -buffer-name-files enable to use wild card
"nnoremap <silent> <Leader>uf :UniteWithBufferDir -buffer-name=files file<CR>
" WithBufferDir for file search freezes when try to delete even current
" directory names in insert mode...
nnoremap <silent> [unite]f :Unite -buffer-name=files file<CR>
" show register
nnoremap <silent> [unite]r :Unite -buffer-name=register register<CR>
" show opened file history including current buffers
nnoremap <silent> [unite]m :UniteWithBufferDir -buffer-name=files buffer file_mru<CR>
" show lines of current file
nnoremap <silent> [unite]l :Unite line<CR>

endif
" }}} Unite

" vim-smartchr {{{
if ! empty(neobundle#get("vim-smartchr"))
inoremap <buffer><expr> = smartchr#one_of(' = ', ' == ', '=')
endif
" }}} vim-smartchr

" YankRing {{{
if ! empty(neobundle#get("YankRing.vim"))

nnoremap <Leader>y :YRShow<CR>
" avoid to store single letter to normal register
let g:yankring_history_dir=$HOME.'/.vim/'
"let g:yankring_n_keys = 'Y D' " Y D x X
"let g:yankring_enabled=0 " 1
let g:yankring_max_history=50 " 100
let g:yankring_max_display=50 " 500
"let g:yankring_ignore_duplicate=0 " 1
let g:yankring_dot_repeat_yank=1
let g:yankring_clipboard_monitor=0 " 1
let g:yankring_min_element_length=2 " 1, :skip all single letter copy
"let g:yankring_persist=0 " 1
"let g:yankring_share_between_instances=0 " 1
"let g:yankring_window_use_separate=0 " 1
"let g:yankring_window_use_horiz=0
"let g:yankring_window_auto_close=0 " 1
let g:yankring_window_width=50 " 30
"let g:yankring_window_use_right=0 " 1
"let g:yankring_window_increment=15 " 1
let g:yankring_manage_numbered_reg = 1 " 0
"let g:yankring_paste_check_default_register = 0 "1

" for warning :The yankring can only persist if the viminfo setting has a !
"set viminfo+=!

endif
" }}} YankRing

" yanktmp {{{
if ! empty(neobundle#get("yanktmp.vim"))

let g:yanktmp_file = $HOME.'/.vim/vimyanktmp'

" yanktmp prefix
noremap [yanktmp] <Nop>
map s [yanktmp]

" show buffer
noremap <silent> [yanktmp]y :call YanktmpYank()<CR>
noremap <silent> [yanktmp]p :call YanktmpPaste_p()<CR>
noremap <silent> [yanktmp]P :call YanktmpPaste_P()<CR>

endif
" }}} yanktmp

" yank share with wviminfo/rviminfo {{{
"
" yankshare prefix
noremap [yshare] <Nop>
map s [yshare]
let g:yankshare_file = ''

nnoremap <silent> [yshare]y  "syy:wv!<CR>
nnoremap <silent> [yshare]yy "syy:wv!<CR>
nnoremap <silent> [yshare]Y  "sY:wv!<CR>
nnoremap <silent> [yshare]y$ "sy$:wv!<CR>
nnoremap <silent> [yshare]y0 "sy0:wv!<CR>
nnoremap <silent> [yshare]yw "syw:wv!<CR>
nnoremap <silent> [yshare]cc "scc<ESC>:wv!<CR>i
nnoremap <silent> [yshare]C  "sC<ESC>:wv!<CR>i
nnoremap <silent> [yshare]c$ "sc$<ESC>:wv!<CR>i
nnoremap <silent> [yshare]c0 "sc0<ESC>:wv!<CR>i
nnoremap <silent> [yshare]cw "scw<ESC>:wv!<CR>i
nnoremap <silent> [yshare]dd "sdd:wv!<CR>
nnoremap <silent> [yshare]D  "sD:wv!<CR>
nnoremap <silent> [yshare]d$ "sd$:wv!<CR>
nnoremap <silent> [yshare]d0 "sd0:wv!<CR>
nnoremap <silent> [yshare]dw "sdw:wv!<CR>

vnoremap <silent> [yshare]y "sy:wv!<CR>
vnoremap <silent> [yshare]c "sc<ESC>:wv!<CR>i
vnoremap <silent> [yshare]d "sd:wv!<CR>

nnoremap <silent> [yshare]p :rv!<CR>"sp
nnoremap <silent> [yshare]P :rv!<CR>"sP
nnoremap <silent> [yshare]gp :rv!<CR>"sgp
nnoremap <silent> [yshare]gP :rv!<CR>"sgP
" }}} yankshare

" status line {{{
set laststatus=2 " always show
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
" }}} status line

" neocomplcache {{{
if ! empty(neobundle#get("neocomplcache"))

let g:neocomplcache_enable_at_startup = 1 " enable at start up
let g:neocomplcache_smartcase = 1 " distinguish capital and
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3

endif
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
if ! empty(neobundle#get("hl_matchit.vim"))

let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft_regexp = 'html\|vim\|ruby\|sh'

endif
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
if ! empty(neobundle#get("vim-easymotion"))

let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
"let g:EasyMotion_keys='ifjklasdweuocvbnm'
let g:EasyMotion_do_mapping=0
let g:EasyMotion_leader_key=","
let g:EasyMotion_grouping=1
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

endif
" }}} vim-easymotion

" jedi-vim{{{
if ! empty(neobundle#get("jedi"))

let g:jedi#auto_initialization = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_command = "<leader>g"
let g:jedi#get_definition_command = "<leader>d"
let g:jedi#pydoc = "K"
let g:jedi#autocompletion_command = "<C-Space>"

endif
" }}} jedi-vim

" SimpleNote{{{
if ! empty(neobundle#get("simplenote.vim"))

" for simplenote.vim
"let g:SimplenoteUsername = ''
"let g:SimplenotePassword = ''
if filereadable(expand('$HOME/.Simplenote.vim'))
  source $HOME/.Simplenote.vim
endif

endif

if ! empty(neobundle#get("vimplenote-vim"))

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

endif

" }}} Simplenote

" Gmail{{{
if ! empty(neobundle#get("gmail.vim"))

let g:gmail_imap = 'imap.gmail.com:993'
let g:gmail_smtp = 'smtp.gmail.com:465'
" path for openssl
let &path = $path.'/usr/bin'
if filereadable(expand('$HOME/.Gmail.vim'))
  source $HOME/.Gmail.vim
endif

endif
" }}} Gmail

" vim-indent-guides{{{
if ! empty(neobundle#get("vim-indent-guides"))

let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size =  1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0

"autocmd myaugroup VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=lightgray
"autocmd myaugroup VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray
autocmd myaugroup VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd myaugroup VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

endif
"}}} vim-indent-guides

" vim-submode{{{
if ! empty(neobundle#get("vim-submode"))

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

endif
"}}} vim-submode

" open-browser{{{
if ! empty(neobundle#get("open-browser.vim"))

let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

endif
"}}} open-browser

" LanguageTool{{{
if ! empty(neobundle#get("LanguageTool"))
let g:languagetool_jar='$HOME/.languagetool/LanguageTool-2.1/languagetool-commandline.jar'
endif
"}}} LanguageTool

" vim-anzu{{{
if ! empty(neobundle#get("vim-anzu"))
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
endif
"}}} vim-anzu

" syntastic{{{
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
"}}} syntastic

" undotree{{{
if ! empty(neobundle#get("undotree"))

nmap <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitLocation = 'topleft'
let g:undotree_SplitWidth = 35
let g:undotree_diffAutoOpen = 1
let g:undotree_diffpanelHeight = 25
let g:undotree_RelativeTimestamp = 1
let g:undotree_TreeNodeShape = '*'
let g:undotree_HighlightChangedText = 1
let g:undotree_HighlightSyntax = "UnderLined"

endif
" }}}

" applescript{{{
if ! empty(neobundle#get("applescript.vim"))
autocmd myaugroup bufnewfile,bufread *.scpt,*.applescript :setl filetype=applescript
"autocmd myaugroup FileType applescript :inoremap <buffer> <S-CR>  ￢<CR>
endif
"}}} applescript

" splash{{{
if ! empty(neobundle#get("vim-splash"))
let g:splash#path = $HOME . '/.vimrc'
endif
"}}} splash

" open .vimrc when starting w/o argument {{{
autocmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | edit $MYVIMRC | endif
function! s:GetBufByte()
    let byte = line2byte(line('$') + 1)
    if byte == -1
        return 0
    else
        return byte - 1
    endif
endfunction
" }}}

" map (for other than each plugin){{{
" remapping, tips

" n   Normal mode map. Defined using ':nmap' and ':nnoremap'.
" i   Insert mode map. Defined using ':imap' and ':inoremap'.
" v   Visual and select mode map. Defined using ':vmap' and ':vnoremap'.
" x   Visual mode map. Defined using ':xmap' and ':xnoremap'.
" s   Select mode map. Defined using ':smap' and ':snoremap'.
" c   Command-line mode map. Defined using ':cmap' and ':cnoremap'.
" o   Operator pending mode map. Defined using ':omap' and ':onoremap'.
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
" Others can be mapped separately.



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

" Swap colon <-> semicolon
noremap ; :
noremap : ;

" tag jump (avoid crash with screen's key bind, C-' default: Non?)
nnoremap <C-'> <C-t>
" spell check toggle
nnoremap <silent> <Leader>s :set spell!<CR>
" stop highlight for search
"nnoremap <C-/> :noh<CR> " can't use C-/ ?
"nnoremap <Esc> :noh<CR> " this makes something wrong
                         " at start when using vim w/o screen...
"nnoremap <silent> <Esc><Esc> :noh<CR> " Esc mapping may be used others,
                                       " better to use others...
nnoremap <silent> <Leader>/ :noh<CR>
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
nnoremap <silent> <Leader>f "%P
nnoremap <silent> <Leader>d i<CR><Esc><BS>:r!echo %:p:h<CR>i<BS><Esc>Jx
nnoremap <silent> "+ "+P
nnoremap <silent> "* "*P

" save/quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>1 :q!<CR>

" remove trail spaces
nnoremap <Leader><Space>  :%s/<Space>\+$//g<CR><C-o>

" search: very magic mode
nnoremap / /\v
" to check patterns:
" :h pattern-overview 


" insert mode (inoremap)

" emacs (bash) like move in insert mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
inoremap <C-h> <Backspace>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" insert file/directory name
"inoremap <silent> <Leader>f <CR><Esc><BS>:r!echo %<CR>i<BS><Esc>Jxi
"inoremap <silent> <Leader>f <C-R>%
"inoremap <silent> <Leader>d <CR><Esc><BS>:r!echo %:p:h<CR>i<BS><Esc>Jxi

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
""
"" # undo/redo
"" * show tree
""   :undol[ist]
"" * Go to older/newer
""   g-/g+
"" * Go to older/newer with arguments
""   earlier/later
" }}} tips
