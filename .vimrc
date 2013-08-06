" vi compatiblity {{{
if !&compatible
  " disable vi compatible mode (much better!)
  set nocompatible
endif
" }}}

" Prepare .vim dir {{{
if has("vim_starting")
  let g:vimdir=$HOME . "/.vim"
  if ! isdirectory(g:vimdir)
    call system("mkdir " . g:vimdir)
  endif
endif
" }}}

" neobundle {{{

"" usage:
" :NeoBundleUpdate " update plugins below
" :NeoBundleInstall" install plugins below
" :NeoBundleClean  " remove plugins removed from below

" NeoBundle configuration ref:
" http://qiita.com/rbtnn/items/39d9ba817329886e626b

let s:neobundle_enable=0
if v:version > 700
  " set path
  if has("vim_starting")
    let s:bundledir=g:vimdir . "/bundle"
    let s:neobundledir=s:bundledir . "/neobundle.vim"
    let &runtimepath = &runtimepath . "," . s:neobundledir
    if ! isdirectory(s:neobundledir)
      echomsg "Neobundle is not installed, install now "
      echo "git clone git://github.com/Shougo/neobundle.vim "
            \ .  s:neobundledir
      call system("git clone git://github.com/Shougo/neobundle.vim "
            \ .  s:neobundledir)
    endif
    let s:neobundle_enable=1
  endif

  call neobundle#rc(s:bundledir)

  """"plugins"""""

  " Neobundle
  NeoBundleFetch "Shougo/neobundle.vim"

  " Asynchronous execution library: need for vimshell, Gmail, unite, etc...
  NeoBundle "Shougo/vimproc", "", "default"
  call neobundle#config("vimproc", {
        \ "build" : {
        \ "windows" : "make -f make_mingw32.mak",
        \ "cygwin" : "make -f make_cygwin.mak",
        \ "mac" : "make -f make_mac.mak",
        \ "unix" : "make -f make_unix.mak",
        \ },
        \ })

  " Use shell in vim
  "NeoBundle "Shougo/vimshell", "", "default"
  "call neobundle#config("vimshell", {
  "      \ "lazy" : 1,
  "      \ "autoload" : {
  "      \ "commands" : [{ "name" : "VimShell",
  "      \ "complete" : "customlist,vimshell#complete"},
  "      \ "VimShellExecute", "VimShellInteractive",
  "      \ "VimShellTerminal", "VimShellPop"],
  "      \ "mappings" : ["<Plug>(vimshell_switch)"]}})

  " Searches and display information->:help Unite
  " Unlike "fuzzyfinder" or "ku", it doesn't use the built-lin completion of vim
  NeoBundle "Shougo/unite.vim", "", "default"
  call neobundle#config("unite.vim",{
        \ "lazy" : 1,
        \ "autoload" : {
        \ "commands" : [{ "name" : "Unite",
        \ "complete" : "customlist,unite#complete_source"},
        \ "UniteWithCursorWord", "UniteWithInput"]}})

  " Echo
  "NeoBundle "Shougo/echodoc", '', "default"
  "call neobundle#config("echodoc", {
  "      \ "lazy" : 1,
  "      \ "autoload" : {
  "      \ "insert" : 1}})

  " Completion

  "NeoBundle "Shougo/neocomplcache-rsense", "", "default"
  "call neobundle#config("neocomplcache-rsense", {
  "      \ "lazy" : 1,
  "      \ "depends" : "Shougo/neocomplcache",
  "      \ "autoload" : { "filetypes" : "ruby" }})

  if has('lua') && (( v:version >= 703 && has('patch885')) || (v:version > 704))
    NeoBundleLazy "Shougo/neocomplete.vim", {
        \ "autoload": {"insert": 1}}
  else
    NeoBundleLazy "Shougo/neocomplcache", {
        \ "autoload" : {"commands" : "NeoComplCacheEnable"}}
  endif

  NeoBundleLazy "Shougo/neosnippet", {
      \ "autoload": {
      \   "insert": 1,
      \ }}

  NeoBundle "Shougo/neobundle-vim-scripts", "", "default"

  " Vim plugin to highlight matchit.vim
  " Make it too slow especially for files which have many brackets
  "NeoBundle "vimtaku/hl_matchit.vim"

  " Easy to use history of yanks (see below settings)
  " Strange behavior
  "NeoBundle "vim-scripts/YankRing.vim"

  " Use yanks in different processes (see below settings)
  "NeoBundle "yanktmp.vim"

  " File Edit History
  NeoBundle "savevers.vim"

  " gundo
  NeoBundleLazy "sjl/gundo.vim", {
      \ "autoload": {"commands": ["GundoToggle"]}}

  " Another undo, need vim7.3+patch005
  "NeoBundle "mbbill/undotree"

  " Toggle insert words
  "NeoBundle "kana/vim-smartchr"

  " smart input
  "NeoBundle "kana/vim-smartinput"

  " Easy to change surround
  NeoBundle "surround.vim"
  "NeoBundle "anyakichi/vim-surround"

  " visualize marks
  NeoBundle "zhisheng/visualmark.vim"
  "NeoBundle "Visual-Mark"

  " Align
  " http://www.drchip.org/astronaut/vim/align.html#Examples
  NeoBundle "Align"

  " Add markdown
  "NeoBundle "tpope/vim-markdown"
  NeoBundle "plasticboy/vim-markdown"
  "NeoBundle "kannokanno/previm"

  " Folding method for python, but makes completion too slow...?
  "NeoBundle "vim-scripts/python_fold"

  " Currently use only for python indent...
  NeoBundle "yuroyoro/vim-python"

  " Applescript
  NeoBundle "applescript.vim"

  " Cool Status Line
  "NeoBundle "Lokaltog/vim-pcompleteowerline"

  " Another status line
  NeoBundle "bling/vim-airline"

  " Visual indent guides
  NeoBundle "nathanaelkane/vim-indent-guides"

  " Sub mode
  NeoBundle "kana/vim-submode"

  " Operator
  NeoBundle "kana/vim-operator-user"

  " Replace with the text object
  NeoBundle "kana/vim-operator-replace"

  " Open browser
  NeoBundleLazy "tyru/open-browser.vim", { "autoload": {
        \ "mappings" : "<Plug>(openbrowser-smart-search)"}}

  " Open browser GitHub
  NeoBundleLazy "tyru/open-browser-github.vim", {
        \ "depends": ["tryu/open-browser.vim"],
        \ "autoload": {
        \ "commands" : ["OpenGithubFile","OpenGithubIssue"]}}

  " Easymotion
  "NeoBundle "Lokaltog/vim-easymotion"

  " Can use f instead of ;, after fx move
  " Can move even to other lines
  "NeoBundle "rhysd/clever-f.vim"

  " Jump to letters (two letters) after "s"
  "NeoBundle "goldfeld/vim-seek"

  " Python autocompletion
  NeoBundleLazy "davidhalter/jedi-vim", {
        \ "rev" : "dev",
        \ "autoload": {
        \ "filetypes": [ "python", "python3", "djangohtml"]}}

  " virtual env
  NeoBundle "jmcantrell/vim-virtualenv"

  " Gmail
  "NeoBundleLazy "yuratomo/gmail.vim",{
  "      \  "autoload" : {"commands": ["Gmail"]},
  "      \  "depends" : ["Shougo/vimproc"]}

  " SimpleNote
  "NeoBundleLazy "mattn/webapi-vim"
  "NeoBundleLazy "mattn/vimplenote-vim",{
  "      \  "autoload" : {"commands": ["VimpleNote"]}}
  "NeoBundleLazy "mrtazz/simplenote.vim",{
  "      \  "autoload" : {"commands": ["Simplenote"]}}

  " evernote: need markdown library...
  "NeoBundleLazy "kakkyz81/evervim",{
  "      \  "autoload" : {"commands": ["EvervimNotebookList", "EvervimListTags",
  "      \                             "EvervimSearchByQuery", "EvervimCreateNote",
  "      \                             "EvervimOpenBrowser", "EvervimSetup"]}}

  " Syntax
  "NeoBundle "scrooloose/syntastic", {
  "      \ "build": {
  "      \   "mac": ["pip install flake8", "npm -g install coffeelint"],
  "      \   "unix": ["pip install flake8", "npm -g install coffeelint"] }}

  " Count searching objects
  NeoBundle "osyo-manga/vim-anzu"

  " Git
  "NeoBundle "tpope/vim-fugitive"
  NeoBundle "gregsexton/gitv" " Gitv! -> D for diff

  " For git/svn status, log
  "NeoBundle "hrsh7th/vim-versions.git"

  " Gist
  NeoBundleLazy "mattn/gist-vim", {
        \ "depends": ["mattn/webapi-vim"],
        \ "autoload": {"commands": ["Gist"]}}

  " Quick run
  "NeoBundleLazy "thinca/vim-quickrun", { "autoload" : {
  "      \ "mappings" : [
  "      \ ["nxo", "<Plug>(quickrun)"]] }}

  " Singletop
  "NeoBundle "thinca/vim-singleton"

  " Splash
  "NeoBundle "thinca/vim-splash"

  " vim-ref
  NeoBundleLazy "thinca/vim-ref", {
        \  "autoload" : {"commands": ["Ref"]},
        \}

  " LanguageTool
  NeoBundle "vim-scripts/LanguageTool"

  " look - display lines beginning with a given string
  NeoBundle 'ujihisa/neco-look'

  " Excite Translate
  NeoBundleLazy "mattn/excitetranslate-vim", {
        \ "depends": "mattn/webapi-vim",
        \ "autoload" : { "commands": ["ExciteTranslate"]}
        \ }

  " Habatobi
  NeoBundleLazy "mattn/habatobi-vim",{
        \  "autoload" : {"commands": ["Habatobi"]}}

  " Make benchmark result of vimrc
  NeoBundleLazy "mattn/benchvimrc-vim",{
        \  "autoload" : {"commands": ["BenchVimrc"]}}

  " File Explorer
  NeoBundleLazy "kien/ctrlp.vim"
  "NeoBundle "scrooloose/nerdtree"
  "NeoBundle "trinity.vim"
  "NeoBundle "The-NERD-tree"
  "NeoBundle "Source-Explorer-srcexpl.vim"
  NeoBundle "wesleyche/SrcExpl"
  "NeoBundle "mru.vim"

  " For Tags
  "NeoBundle "taglist.vim"
  "NeoBundle "ctags.vim"
  NeoBundleLazy "majutsushi/tagbar", {
        \ "autload": {
        \   "commands": ["TagbarToggle"],
        \ }}

  " Color scheme
  "NeoBundle "ujihisa/unite-colorscheme"
  "NeoBundle "tomasr/molokai"
  "NeoBundle "nanotech/jellybeans.vim"
  "NeoBundle "altercation/vim-colors-solarized"
  "NeoBundle "vim-scripts/newspaper.vim"
  "NeoBundle "w0ng/vim-hybrid"


  " local plugins
  NeoBundleLocal ~/.vim/local/bundle
  """"plugins end"""""

  " Installation check.
  NeoBundleCheck
  " Installation check.
  "if neobundle#exists_not_installed_bundles()
  "  echomsg "Not installed bundles : " .
  "    \ string(neobundle#get_not_installed_bundle_names())
  ""echomsg "Please execute ":NeoBundleInstall" command."
  "  NeoBundleInstall
  ""finish
  "endif
endif

" enable plugin, indent again
filetype plugin indent on
" }}} neobundle

" Basic settings {{{

" set my auto group
augroup MyAutoGroup
  autocmd!
augroup END

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch

" mapleaader (<Leader>)
let mapleader = ","
" use \ as ,, instead
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
autocmd MyAutoGroup FileType *  setlocal textwidth=0 " overwrite ftplugin settings
if exists ("&colorcolumn")
  "set colorcolumn=80 " put line on 80
  "set colorcolumn=+1 " put line on textwidth+1
  " Change background for 81-
  execute "set colorcolumn=" . join(range(81, 999), ",")
endif
set wrap           " the longer line is wrapped
set expandtab      " do :retab -> tab->space

set nobackup       " do not keep a backup file, use versions instead

if ! empty($TMP) && isdirectory($TMP)
  let s:tmpdir=$TMP
elseif ! empty($TMPDIR) && isdirectory($TMPDIR)
  let s:tmpdir=$TMPDIR
elseif ! empty($TEMP) && isdirectory($TEMP)
  let s:tmpdir=$TEMP
else
  let s:tmpdir="./"
endif
let &directory=s:tmpdir
let &backupdir=s:tmpdir

if has("gui_running") && ( has("win32unix") || has ("win64unix") || has("win32") || has ("win64") )
  set viminfo+=n~/.vim/gviminfo
else
  set viminfo+=n~/.vim/viminfo
endif

set history=100    " Keep 100 lines of command line history

set incsearch      " Do incremental searching
set ignorecase     " Ignore case for search
set smartcase      " Noignorecase, if the pattern include Capital
set nowrapscan     " Stop search at the edge of the file
set infercase      " Ignore case for completion

set nrformats=hex  " Not use cotal, alpha for increment or decrement
set t_Co=256       " Enable 256 colors
set list           " Show tab, end, trail empty
set listchars=tab:>-,extends:<,trail:- " Set words for above
set ruler          " Show the cursor position all the time
set showcmd        " Display incomplete commands
set novisualbell   " No visual bell
"set cursorline     " Enable highlight on current line:
"                   " but make moving cursor slow for heavily highlighted file...
set nonumber       " Don't show line numbers
set autoindent
set scrolloff=999  " Show cursor at middle
                   " (scrolloff is number of lines which should be shown above
                   " and below cursor.
                   "  such large number force to stay a cursor at middle
set scroll=12      " Number of lines to scroll with C-U/C-D
"set spell          " Spell check highlight
set nospell        " No spell check
set mouse=         " Disable mouse
set ambiwidth=double  " For UTF-8, width for East Asian Characters
set cmdheight=1    " Command line height
set showmatch      " Show maching one for inserted bracket


" IME setting
if has("multi_byte_ime") || has("xim") || has("gui_macvim")
  set iminsert=0
  set imsearch=0
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

" Encode
"if has("windows")
"  scriptencoding cp932 " sjis
"  set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
"else " if has("unix") || has("mac")
"  set fileencodings=iso-2022-jp,euc-jp,sjis,ucs-bom,default,latin1,utf-8
"endif
"if has("gui_running") && !has("unix")
"  set encoding=utf-8
"endif
"set encoding=utf-8
set encoding=utf8
"set encoding=cp932
"set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin
"set fileencodings=iso-2022-jp,euc-jp,sjis,ucs-bom,default,latin1,utf-8
"autocmd MyAutoGroup FileType vbs :set fileencoding=sjis
"autocmd MyAutoGroup FileType vbs :set encoding=sjis

" Automatic ime off
" noimdisableactivate was thrown in the latest MacVim?
" noimdisable should be used instead.
" but it seems not necessary anyway (all IME related things are done in KeyRemap4MacBook.
"if has("mac")
"  set noimdisableactivate
"endif

" bash-like tab completion
set wildmode=list:longest
set wildmenu

" Folding
set foldmethod=marker
set foldmarker={{{,}}} "default
autocmd MyAutoGroup FileType py set foldmethod=syntax
autocmd MyAutoGroup FileType cpp,cxx,C set foldmethod=marker foldmarker={,}
set foldlevel=0
set foldnestmax=1

" When editing a file, always jump to the last known cursor position.
autocmd MyAutoGroup BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Set current directory as a directory of the file
"autocmd MyAutoGroup BufEnter *   execute ":lcd " . expand("%:p:h")

" Avoid automatic comment out for the next line after the comment lines
autocmd MyAutoGroup FileType * setlocal formatoptions-=ro

" INSERT (paste)
"set paste " use 'paste at normal mode' in below, instead

" Arrow to open new file while current file is not saved
set hidden

" Jump to the first open window
set switchbuf=useopen

" virtualedit (can move to non-editing places: e.x. right of $)
set virtualedit=all
" Avoid to paste/insert in non-editing place
if has("virtualedit") && &virtualedit =~# '\<all\>'
  nnoremap <expr> p (col('.') >= col('$') ? '$' : '') . 'p'
  nnoremap <expr> i (col('.') >= col('$') ? '$' : '') . 'i'
  nnoremap <expr> a (col('.') >= col('$') ? '$' : '') . 'a'
  nnoremap <expr> r (col('.') >= col('$') ? '$' : '') . 'r'
  nnoremap <expr> R (col('.') >= col('$') ? '$' : '') . 'R'
  nnoremap <expr> . (col('.') >= col('$') ? '$' : '') . '.'
  " autocmd is needed to overwrite YRShow's map,
  " and "_x to avoid register 1 letter
  autocmd MyAutoGroup FileType * nnoremap <expr> x (col('.') >= col('$') ? '$' : '') . '"_x'
endif

" Max columns for syntax search
" Such XML file has too much syntax which make vim drastically slow
set synmaxcol=500 "default 3000

" Disable highlight italic in Markdown
autocmd! FileType markdown hi! def link markdownItalic LineNr

" }}} Basic settings

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

" cursor move
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
nnoremap <C-k> k

" Window move
nnoremap <M-h> <C-w><<CR>
nnoremap <M-j> <C-w>+<CR>
nnoremap <M-k> <C-w>-<CR>
nnoremap <M-l> <C-w>><CR>
nnoremap <D-h> <C-w><<CR>
nnoremap <D-j> <C-w>+<CR>
nnoremap <D-k> <C-w>-<CR>
nnoremap <D-l> <C-w>><CR>

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
nnoremap Z ZZ
" don't enter Ex mode but quit w/o check by Q
nnoremap Q ZQ

" remove trail spaces
nnoremap <Leader><Space>  :%s/<Space>\+$//g<CR><C-o>

" Paste mode
nnoremap <silent> <Leader>p "+gP
nnoremap <silent> <Leader>P :set paste!<CR>:set paste?<CR>

" Open vimrc (is <C-u> necessary for command map?
"nnoremap <Leader><Leader> :<C-u>tabedit $MYVIMRC<CR>
nnoremap <Leader><Leader> :tabedit $MYVIMRC<CR>

" Source vimrc
nnoremap <Leader>. :source $MYVIMRC<CR>

" search: very magic mode
nnoremap / /\v
" to check patterns:
" :h pattern-overview

" Close help with q
autocmd MyAutoGroup FileType help,qf nnoremap <buffer> q <C-w>c

" Surround at Normal mode
nnoremap <Leader>{ bi{<Space><Esc>ea<Space>}<Esc>
nnoremap <Leader>} bi{<Esc>ea}<Esc>
nnoremap <Leader>[ bi[<Space><Esc>ea<Space>]<Esc>
nnoremap <Leader>] bi[<Esc>ea]<Esc>
nnoremap <Leader>( bi(<Space><Esc>ea<Space>)<Esc>
nnoremap <Leader>) bi(<Esc>ea)<Esc>
nnoremap <Leader>< bi<<Space><Esc>ea<Space>><Esc>
nnoremap <Leader>> bi<<Esc>ea><Esc>
nnoremap <Leader>" bi"<Esc>ea"<Esc>
nnoremap <Leader>' bi'<Esc>ea'<Esc>
nnoremap <Leader>` bi`<Esc>ea`<Esc>

" insert mode (inoremap)

" emacs (bash) like move in insert mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
inoremap <C-h> <Backspace>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
" insert file/directory name
" -> Use <C-o><Leader>f, instead
"inoremap <silent> <Leader>f <CR><Esc><BS>:r!echo %<CR>i<BS><Esc>Jxi
"inoremap <silent> <Leader>f <C-R>%
"inoremap <silent> <Leader>d <CR><Esc><BS>:r!echo %:p:h<CR>i<BS><Esc>Jxi

""""""" -> use smartinput
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
" -> use to surround
"vnoremap { "zdi{<C-R>z}<Esc>
"vnoremap [ "zdi[<C-R>z]<Esc>
"vnoremap ( "zdi(<C-R>z)<Esc>
"vnoremap " "zdi"<C-R>z"<Esc>
"vnoremap ' "zdi'<C-R>z'<Esc>

" remove trail spaces
vnoremap <Leader><Space>  :s/<Space>\+$//g<CR><C-o>

" Select word
"vnoremap w iw
"vnoremap W iW


""" command line mode (cnoremap)
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <C-b>

" Write as root
cnoremap w!! w !sudo tee > /dev/null %


" }}} map

" Colors {{{
"colorscheme molokai
colorscheme ron
"colorscheme blue

" for spell checks
hi SpellBad cterm=inverse ctermbg=0

"hi CursorLine cterm=none ctermfg=NONE ctermbg=NONE
" only underline for cursorline
"hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" Set all white characters on black background for current line
"hi CursorLine cterm=underline ctermfg=white ctermbg=black
"au MyAutoGroup InsertEnter * hi CursorLine cterm=underline,bold ctermfg=NONE ctermbg=NONE
"au MyAutoGroup InsertLeave * hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE

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

"" Colors for search
hi Search term=reverse ctermfg=Red ctermbg=11 guifg=Black


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
autocmd MyAutoGroup VimEnter,FilterWritePre * call SetDiffWrap()
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
if has("persistent_undo")
  let vimundodir=expand("~/.vim/undo")
  let &undodir = vimundodir
  if ! isdirectory(vimundodir)
    call system("mkdir " . vimundodir)
  endif
  set undofile
  set undoreload=1000
endif
set undolevels=1000
nnoremap u g-
nnoremap <C-r> g+
" }}} undo

" gundo {{{
if s:neobundle_enable && ! empty(neobundle#get("gundo.vim"))
  nnoremap U :GundoToggle<CR>
  let g:gundo_auto_preview = 0 " Don't show preview by moving history. Use r to see differences
  "let g:gundo_preview_bottom = 1 " Show preview at the bottom
endif
" }}} gundo

" Unite {{{
if s:neobundle_enable && ! empty(neobundle#get("unite.vim"))
  autocmd MyAutoGroup FileType unite call s:unite_my_settings()
  function! s:unite_my_settings()
    nmap <buffer><Esc> <Plug>(unite_exit)
    imap <buffer><Esc><Esc> <Plug>(unite_exit)
  endfunction
  " start with insert mode (can start narrow result in no time)
  let g:unite_enable_start_insert=1
  " window
  "let g:unite_enable_split_vertically=1
  let g:unite_split_rule="botright" " default topleft
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
  nnore <silent> [unite]l :Unite line<CR>
endif
" }}} Unite

" vim-smartchr {{{
if s:neobundle_enable && ! empty(neobundle#get("vim-smartchr"))
  inoremap <buffer><expr> = smartchr#one_of(' = ', ' == ', '=')
endif
" }}} vim-smartchr

" vim-smartinput {{{
if s:neobundle_enable && ! empty(neobundle#get("vim-smartinput"))
  "" Remove spaces at the end of line
  "call smartinput#define_rule({
  "\   'at': '\s\+\%#',
  "\   'char': '<CR>',
  "\   'input': '<C-o>:call setline('.', substitute(getline('.'), '\\s\\+$', '', ''))<CR><CR>',
  "\   })
endif
" }}} vim-smartinput

" surround.vim/vim-surround {{{
if s:neobundle_enable && (! empty(neobundle#get("surround.vim")) || ! empty(neobundle#get("vim-surround")))
  " Numbers for characters can be found by :ascii on each character
  let g:surround_96 = "`\r`" " use `

  if ! empty(neobundle#get("vim-surround"))
    let g:surround_old_mappings = 1
  endif

  vmap { S{
  vmap } S}
  vmap [ S[
  vmap ] S]
  vmap ( S(
  vmap ) S)
  vmap < S<
  vmap > S>
  vmap " S"
  vmap ' S'
  vmap ` S`
endif
" }}} surround.vim

" YankRing {{{
if s:neobundle_enable && ! empty(neobundle#get("YankRing.vim"))
  nnoremap <Leader>y :YRShow<CR>
  " avoid to store single letter to normal register
  let g:yankring_history_dir=g:vimdir
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
if s:neobundle_enable && ! empty(neobundle#get("yanktmp.vim"))
  let g:yanktmp_file = $HOME."/.vim/vimyanktmp"

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

let g:yankshare_file = expand("~/.vim/yankshare.txt")
if !exists("g:yankshare_file")
  let g:yankshare_file = "/tmp/yankshare.txt"
endif


function! YSStore() range
  call writefile([getreg("s")], g:yankshare_file, "b")
endfunction

function! YSLoad() range
  call setreg("s", readfile(g:yankshare_file, "b")[0])
endfunction

nnoremap <silent> [yshare]y  "syy:call YSStore()<CR>
nnoremap <silent> [yshare]yy "syy:call YSStore()<CR>
nnoremap <silent> [yshare]Y  "sY:call YSStore()<CR>
nnoremap <silent> [yshare]y$ "sy$:call YSStore()<CR>
nnoremap <silent> [yshare]y0 "sy0:call YSStore()<CR>
nnoremap <silent> [yshare]yw "syw:call YSStore()<CR>
nnoremap <silent> [yshare]cc "scc<ESC>:call YSStore()<CR>i
nnoremap <silent> [yshare]C  "sC<ESC>:call YSStore()<CR>i
nnoremap <silent> [yshare]c$ "sc$<ESC>:call YSStore()<CR>i
nnoremap <silent> [yshare]c0 "sc0<ESC>:call YSStore()<CR>i
nnoremap <silent> [yshare]cw "scw<ESC>:call YSStore()<CR>i
nnoremap <silent> [yshare]dd "sdd:call YSStore()<CR>
nnoremap <silent> [yshare]D  "sD:call YSStore()<CR>
nnoremap <silent> [yshare]d$ "sd$:call YSStore()<CR>
nnoremap <silent> [yshare]d0 "sd0:call YSStore()<CR>
nnoremap <silent> [yshare]dw "sdw:call YSStore()<CR>

vnoremap <silent> [yshare]y "sy:call YSStore()<CR>
vnoremap <silent> [yshare]c "sc<ESC>:call YSStore()<CR>i
vnoremap <silent> [yshare]d "sd:call YSStore()<CR>

nnoremap <silent> [yshare]p :call YSLoad()<CR>"sp
nnoremap <silent> [yshare]P :call YSLoad()<CR>"sP
nnoremap <silent> [yshare]gp :call YSLoad()<CR>"sgp
nnoremap <silent> [yshare]gP :call YSLoad()<CR>"sgP
" }}} yankshare

" savevers {{{
if s:neobundle_enable && ! empty(neobundle#get("savevers.vim"))
  set patchmode=.clean
  set backup
  let savevers_types = "*"
  let savevers_dirs = &backupdir
endif
" }}}

" status line {{{
set laststatus=2 " always show
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
" }}} status line

" neocomplcache {{{
if s:neobundle_enable && ! empty(neobundle#get("neocomplcache"))
  let g:neocomplcache_enable_at_startup = 1 " enable at start up
  let g:neocomplcache_smartcase = 1 " distinguish capital and
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_underbar_completion = 1
  let g:neocomplcache_min_syntax_length = 3
endif
" }}}

" neocomlete {{{
if s:neobundle_enable && ! empty(neobundle#get("neocomplete.vim"))
  let g:acp_enableAtStartup = 1 " Disable AutoComplPop
  let g:neocomplte#enable_at_startup = 1 " enable at start up
  let g:neocomplte#cache_smart_case = 1 " enable smartcase
  let g:neocomplete#sources#syntax#min_keyword_length = 3 " minimum syntax keyword length
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
if s:neobundle_enable && ! empty(neobundle#get("hl_matchit.vim"))
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
  imap <special> <expr> <Esc>[200~ XTermPasteBegin(""'
endif

" }}} paste

" vim-easymotion{{{
if s:neobundle_enable && ! empty(neobundle#get("vim-easymotion"))
  let g:EasyMotion_keys="hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB"
  "let g:EasyMotion_keys="ifjklasdweuocvbnm"
  let g:EasyMotion_do_mapping=0
  let g:EasyMotion_leader_key=","
  let g:EasyMotion_grouping=1
  hi EasyMotionTarget ctermbg=none ctermfg=red
  hi EasyMotionShade  ctermbg=none ctermfg=blue
endif
" }}} vim-easymotion

" jedi-vim{{{
if s:neobundle_enable && ! empty(neobundle#get("jedi-vim"))
  let g:jedi#auto_initialization = 1
  let g:jedi#auto_vim_configuration = 1
  let g:jedi#goto_command = "<Leader>g"
  let g:jedi#get_definition_command = "<Leader>d"
  let g:jedi#pydoc = "K"
  let g:jedi#autocompletion_command = "<C-Space>"
endif
" }}} jedi-vim

" SimpleNote{{{
if s:neobundle_enable && ! empty(neobundle#get("simplenote.vim"))
  " for simplenote.vim
  "let g:SimplenoteUsername = ""
  "let g:SimplenotePassword = """
  if filereadable(expand("$HOME/.Simplenote.vim"))
    source $HOME/.Simplenote.vim
  endif
endif

if s:neobundle_enable && ! empty(neobundle#get("vimplenote-vim"))
  " for vimplenote-vim
  "let g:VimpleNoteUsername = ""
  "let g:VimpleNotePassword = ""
  " move to $HOME/.VimpleNote
  if filereadable(expand("$HOME/.VimpleNote.vim"))
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
if s:neobundle_enable && ! empty(neobundle#get("gmail.vim"))
  let g:gmail_imap = "imap.gmail.com:993"
  let g:gmail_smtp = "smtp.gmail.com:465"
  " path for openssl
  let &path = $path."/usr/bin"
  if filereadable(expand("$HOME/.Gmail.vim"))
    source $HOME/.Gmail.vim
  endif
endif
" }}} Gmail

" vim-indent-guides{{{
if s:neobundle_enable && ! empty(neobundle#get("vim-indent-guides"))
  let g:indent_guides_enable_on_vim_startup = 1
  "let g:indent_guides_guide_size =  1
  let g:indent_guides_start_level = 1
  let g:indent_guides_auto_colors = 0

  "autocmd MyAutoGroup VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=lightgray
  "autocmd MyAutoGroup VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgray
  autocmd MyAutoGroup VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
  autocmd MyAutoGroup VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
endif
"}}} vim-indent-guides

" vim-submode{{{
if s:neobundle_enable && ! empty(neobundle#get("vim-submode"))
  call submode#enter_with("winsize", "n", "", "<C-w>>", "<C-w>>")
  call submode#enter_with("winsize", "n", "", "<C-w><", "<C-w><")
  call submode#enter_with("winsize", "n", "", "<C-w>+", "<C-w>+")
  call submode#enter_with("winsize", "n", "", "<C-w>-", "<C-w>-")
  call submode#enter_with("winsize", "n", "", "<C-w>e", "<C-w>><C-w><")
  call submode#enter_with("winsize", "n", "", "<C-w><C-e>", "<C-w>><C-w><")
  call submode#map("winsize", "n", "", ">", "<C-w>>")
  call submode#map("winsize", "n", "", "<", "<C-w><")
  call submode#map("winsize", "n", "", "+", "<C-w>-")
  call submode#map("winsize", "n", "", "-", "<C-w>+")
  call submode#map("winsize", "n", "", "l", "<C-w>>")
  call submode#map("winsize", "n", "", "h", "<C-w><")
  call submode#map("winsize", "n", "", "j", "<C-w>-")
  call submode#map("winsize", "n", "", "k", "<C-w>+")
  call submode#map("winsize", "n", "", "=", "<C-w>=")
endif
"}}} vim-submode

" vim-operator-replace{{{
if s:neobundle_enable && ! empty(neobundle#get("vim-operator-replace"))
  map R  <Plug>(operator-replace)
endif
"}}} vim-operator-replace

" open-browser{{{
if s:neobundle_enable && ! empty(neobundle#get("open-browser.vim"))
  let g:netrw_nogx = 1 " disable netrw's gx mapping.
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)
endif
"}}} open-browser

" LanguageTool{{{
if s:neobundle_enable && ! empty(neobundle#get("LanguageTool"))
  let g:languagetool_jar="$HOME/.languagetool/LanguageTool-2.1/languagetool-commandline.jar"
endif
"}}} LanguageTool

" ExciteTranslate{{{
if s:neobundle_enable && ! empty(neobundle#get("excitetranslate-vim"))
  xnoremap <Leader>x :ExciteTranslate<CR>
endif
"}}} LanguageTool

" vim-anzu{{{
if s:neobundle_enable && ! empty(neobundle#get("vim-anzu"))
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * <Plug>(anzu-star-with-echo)
  nmap # <Plug>(anzu-sharp-with-echo)
endif
"}}} vim-anzu

" syntastic{{{
if s:neobundle_enable && ! empty(neobundle#get("syntastic"))
  let g:syntastic_enable_signs=1
  let g:syntastic_auto_loc_list=2
endif
"}}} syntastic

" undotree{{{
if s:neobundle_enable && ! empty(neobundle#get("undotree"))
  nmap <Leader>U :UndotreeToggle<CR>
  let g:undotree_SetFocusWhenToggle = 1
  let g:undotree_SplitLocation = "topleft"
  let g:undotree_SplitWidth = 35
  let g:undotree_diffAutoOpen = 1
  let g:undotree_diffpanelHeight = 25
  let g:undotree_RelativeTimestamp = 1
  let g:undotree_TreeNodeShape = "*"
  let g:undotree_HighlightChangedText = 1
  let g:undotree_HighlightSyntax = "UnderLined"
endif
" }}}

" applescript{{{
if s:neobundle_enable && ! empty(neobundle#get("applescript.vim"))
  autocmd MyAutoGroup bufnewfile,bufread *.scpt,*.applescript :setl filetype=applescript
"autocmd MyAutoGroup FileType applescript :inoremap <buffer> <S-CR>  ￢<CR>
endif
"}}} applescript

" vim-airline{{{
if s:neobundle_enable && ! empty(neobundle#get("vim-airline"))
  "let g:airline_theme="dark"
endif
"}}} applescript

" splash{{{
if s:neobundle_enable && ! empty(neobundle#get("vim-splash"))
  let g:splash#path = $HOME . "/.vimrc"
endif
"}}} splash

" vim-ref {{{
if s:neobundle_enable && ! empty(neobundle#get("vim-ref"))
  " Set webdict sources
  let g:ref_source_webdict_sites = {
  \   "je": {
  \     "url": "http://dictionary.infoseek.ne.jp/jeword/%s",
  \   },
  \   "ej": {
  \     "url": "http://dictionary.infoseek.ne.jp/ejword/%s",
  \   },
  \   "wiki": {
  \     "url": "http://ja.wikipedia.org/wiki/%s",
  \   },
  \ }

  " Set default
  let g:ref_source_webdict_sites.default = "ej"

  " Filter
  function! g:ref_source_webdict_sites.je.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
  endfunction
  function! g:ref_source_webdict_sites.ej.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
  endfunction
  function! g:ref_source_webdict_sites.wiki.filter(output)
    return join(split(a:output, "\n")[17 :], "\n")
  endfunction

  " vim-ref prefix
  nnoremap [ref] <Nop>
  vnoremap [ref] <Nop>
  nmap <Leader>r [ref]
  vmap <Leader>r [ref]
  nnoremap [ref]j :Ref webdict je<Space>
  nnoremap [ref]e :Ref webdict ej<Space>
  nnoremap [ref]w :Ref webdict wiki<Space>
  nnoremap [ref]m :Ref man<Space>
  vnoremap [ref]j :<C-u>Ref webdict je <C-R><C-w><CR>
  vnoremap [ref]e :<C-u>Ref webdict ej <C-R><C-w><CR>
  vnoremap [ref]w :<C-u>Ref webdict wiki <C-R><C-w><CR>
endif
"}}}

" SrcExpl  {{{
if s:neobundle_enable && ! empty(neobundle#get("SrcExpl"))
 let g:SrcExpl_RefreshTime = 1
 let g:SrcExpl_UpdateTags = 0
 nnoremap <Leader>e :SrcExplToggle<CR>
endif
"}}}

" taglist{{{
if s:neobundle_enable && ! empty(neobundle#get("taglist.vim"))
  set tags=tags
  "let Tlist_Ctags_Cmd = "/usr/bin/ctags"
  let Tlist_Show_One_File = 1
  let Tlist_Use_Right_Window = 1
  let Tlist_Exit_OnlyWindow = 1
  nnoremap <silent> <leader>l :TlistToggle<CR>
endif
"}}} taglist

" tagbar{{{
if s:neobundle_enable && ! empty(neobundle#get("tagbar"))
  nnoremap <silent> <leader>t :TagbarToggle<CR>
endif
"}}} taglist

" tag {{{
if has("path_extra")
  set tags+=tags;
endif
"}}} tag

" cscope {{{
if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set csverb
  set cscopequickfix=s-,c-,d-,i-,t-,e-
endif
" }}} cscope

" gist-vim {{{
if s:neobundle_enable && ! empty(neobundle#get("gist-vim"))
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 1
  " Disable default Gist command
  cnoremap <silent> Gist<CR> <CR>
endif
"}}} gist-vim

" ctrlp {{{
if s:neobundle_enable && ! empty(neobundle#get("ctrlp.vim"))
  "let g:ctrlp_map = "<c-p>"
endif
"}}} ctrlp

"" open .vimrc when starting w/o argument {{{
"autocmd VimEnter * nested if @% == "" && s:GetBufByte() == 0 | edit $MYVIMRC | endif
"function! s:GetBufByte()
"    let byte = line2byte(line("$") + 1)
"    if byte == -1
"        return 0
"    else
"        return byte - 1
"    endif
"endfunction
"" }}}

" local settings {{{
if filereadable(expand("~/.vimrc.local"))
  execute "source" expand("~/.vimrc.local")
endif
" }}}

" neobundle on_source {{{
if !has("vim_starting")
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook("on_source")
endif
" }}}

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
"" # mapping
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
"" # vimdiff (vim -d)
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
"" * Diff to original when it was opened
""   :DiffOrig
"" * Stop diff
""   :diffoff
"" * Update diff
""   :diffupdate
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

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
" vim: foldlevel=0
