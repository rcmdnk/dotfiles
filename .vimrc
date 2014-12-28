" vimrc
"
" Managed at: https://github.com/rcmdnk/dotfiles/blob/master/.vimrc
" Todo/Obsolete settings are in https://github.com/rcmdnk/dotfiles/blob/master/.vimrc.not_used

" Flags {{{
let s:use_neobundle=1
" }}}

" vi compatibility {{{
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

let s:neobundle_enabled=0
if s:use_neobundle && v:version >= 703
  " set path
  if has("vim_starting")
    let g:bundledir=g:vimdir . "/bundle"
    let g:neobundledir=g:bundledir . "/neobundle.vim"
    let &runtimepath = &runtimepath . "," . g:neobundledir
    let g:neobundleReadMe=expand(g:neobundledir . "/README.md")
    if !filereadable(g:neobundleReadMe)
      echo "Neobundle is not installed, install now "
      echo "git clone git://github.com/Shougo/neobundle.vim "
            \ .  g:neobundledir
      call system("git clone git://github.com/Shougo/neobundle.vim "
            \ .  g:neobundledir)
    endif
    let g:neobundle#types#git#default_protocol = 'git'
    let s:neobundle_enabled=1
  endif

  call neobundle#begin(g:bundledir)

  """"plugins"""""

  " Neobundle
  NeoBundleFetch "Shougo/neobundle.vim"

  " Make template of NeoBundle
  NeoBundleLazy "LeafCage/nebula.vim",{
        \"autoload":{
        \"commands":[
        \"NebulaPutLazy", "NebulaPutFromClipboard",
        \"NebulaYankOptions", "NebulaPutConfig"]}}

  " Asynchronous execution library: need for vimshell, Gmail, unite, etc...
  NeoBundle "Shougo/vimproc", {
        \"build" : {
        \"windows" : "make -f make_mingw32.mak",
        \"cygwin" : "make -f make_cygwin.mak",
        \"mac" : "make -f make_mac.mak",
        \"unix" : "make -f make_unix.mak"}}

  " Quick Run
  NeoBundle "thinca/vim-quickrun"

  " Quick Fix Status
  NeoBundle "dannyob/quickfixstatus"

  """ Unlike "fuzzyfinder" or "ku", it doesn't use the built-in completion of vim {{{
  """ Searches and display information->:help Unite
  NeoBundleLazy "Shougo/unite.vim" , {
        \ "autoload" : { "commands" : [ "Unite" ] }}

  " Source for unite: mark
  NeoBundle "tacroe/unite-mark"

  " Source for unite: outline
  NeoBundle "h1mesuke/unite-outline"

  " Source for unite: help
  NeoBundle "tsukkee/unite-help"

  " Source for unite: history/command, history/search
  NeoBundle "thinca/vim-unite-history"

  " Source for unite: fold
  NeoBundle "osyo-manga/unite-fold"

  " Source for unite: locate
  NeoBundle "ujihisa/unite-locate"

  " Source for unite: colorscheme
  NeoBundle "ujihisa/unite-colorscheme"

  " Source for unite: mru
  NeoBundle "Shougo/neomru.vim"

  " Source for unite: outline
  NeoBundle "h1mesuke/unite-outline"
  "}}}

  " Completion
  "let g:completion = "Shougo/neocomplcache.vim"
  if has('lua') && (( v:version == 703 && has('patch885')) || (v:version >= 704))
    let g:completion = "Shougo/neocomplete.vim"
    NeoBundleLazy g:completion, {
          \ "autoload": {"insert": 1 }}

    " look - display lines beginning with a given string, using with neocomplete/neocomplcache
    NeoBundleLazy "ujihisa/neco-look", {"depends": [g:completion]}
    "NeoBundleLazy "mitsuse/kompl", {"depends": [g:completion]}
  endif

  NeoBundle "Shougo/neobundle-vim-scripts"

  " textobj {{{
  NeoBundle "kana/vim-textobj-user"

  "" entire: ae, ie
  NeoBundle "kana/vim-textobj-entire"

  " line: al, il
  NeoBundle "kana/vim-textobj-line"

  "" indent: al, il
  "NeoBundle "kana/vim-textobj-indent"

  "" function: af, if
  "NeoBundle "kana/vim-textobj-function"

  "" syntax: ay, iy
  "NeoBundle "kana/vim-textobj-syntax"

  "" jabraces: ajb, ijb
  "NeoBundle "kana/vim-textobj-jabraces"

  "" last pattern: a/, i/
  "NeoBundle "kana/vim-textobj-lastpat"

  "" fold: az, iz
  "NeoBundle "kana/vim-textobj-fold"

  "" diff(1): adf, idf
  "NeoBundle "kana/vim-textobj-diff"

  "" datetime: ada, ida
  "NeoBundle "kana/vim-textobj-datetime"

  "" underscore: a_, i_
  "NeoBundle "kana/vim-textobj-underscore"

  "" django_template: adb, idb
  "NeoBundle "kana/vim-textobj-django-template"

  "" between: af, if
  "NeoBundle "thinca/vim-textobj-between"

  "" comment: ac, ic
  "NeoBundle "thinca/vim-textobj-comment"

  "" JavaScript Function: af, if
  "NeoBundle "thinca/vim-textobj-function-javascript"

  "" Perl Function: af, if
  "NeoBundle "thinca/vim-textobj-function-perl"

  "" last paste: ap, ip
  "NeoBundle "gilligan/textobj-lastpaste"

  "" mbboundary: am, im
  "NeoBundle "deton/textobj-mbboundary.vim"

  "" xml attribute: axa, ixa
  "NeoBundle "akiyan/vim-textobj-xml-attribute"

  "" php: aP, iP
  "NeoBundle "akiyan/vim-textobj-php"

  "" space: aS, iS
  "NeoBundle "saihoooooooo/vim-textobj-space"

  "" URL: au, iu
  "NeoBundle "mattn/vim-textobj-url"

  "" snake_case: a,w, i,w
  "NeoBundle "h1mesuke/textobj-wiw"

  "" lastinserted: au, iu
  "NeoBundle "rhysd/vim-textobj-lastinserted"

  "" continuous line: av, iv
  "NeoBundle "rhysd/vim-textobj-continuous-line"

  "" ruby: arr, brr
  "NeoBundle "rhysd/vim-textobj-ruby"

  "" xbrackets: axb, ixb
  "NeoBundle "https://bitbucket.org/anyakichi/vim-textobj-xbrackets"

  "" motionmotion: am, im
  "NeoBundle "hchbaw/textobj-motionmotion.vim"

  "" enclosedsyntax: aq, iq
  "NeoBundle "deris/vim-textobj-enclosedsyntax"

  "" headwordofline: ah, ih
  "NeoBundle "deris/vim-textobj-headwordofline"

  "" LaTeX: ae, ie
  "NeoBundle "rbonvall/vim-textobj-latex"

  "" parameter: a, i,
  "NeoBundle "sgur/vim-textobj-parameter"

  "" cell: ac, ic
  "NeoBundle "mattn/vim-textobj-cell"

  "" context: icx
  "NeoBundle "osyo-manga/vim-textobj-context"

  "" multiblock: asb, isb
  "NeoBundle "osyo-manga/vim-textobj-multiblock"

  "" indblock: ao, io
  "NeoBundle "glts/vim-textobj-indblock"

  "" dash: a-, i-
  "NeoBundle "RyanMcG/vim-textobj-dash"

  "" Python af, if
  "NeoBundle "bps/vim-textobj-python"

  "" #ifdef: a#, i#
  "NeoBundle "anyakichi/vim-textobj-ifdef"

  "" HTML: ahf, ihf
  "NeoBundle "mjbrownie/html-textobjects"

  "" keyvalue: dak, dik,  dav, div
  "NeoBundle "vimtaku/vim-textobj-keyvalue"

  " wildfire
  NeoBundle "gcmt/wildfire.vim"
  "}}}

  " operator {{{
  NeoBundle "kana/vim-operator-user"
  NeoBundle "kana/vim-operator-replace"
  NeoBundle 'emonkak/vim-operator-sort'
  NeoBundle 'tyru/operator-reverse.vim'
  "NeoBundle "rhysd/vim-operator-surround"
  "}}}

  " Support repeat for surround, speedating, easymotion, etc...
  NeoBundle "tpope/vim-repeat"

  " Easy to change surround
  NeoBundle "tpope/vim-surround"

  " Auto bracket closing
  "NeoBundle "cohama/lexima.vim"

  " Echo
  NeoBundleLazy "Shougo/echodoc", {
        \ "autoload": { "insert": 1 }}

  " gundo
  NeoBundleLazy "sjl/gundo.vim", {
        \ "autoload": {"commands": ["GundoToggle"]}}

  " Align
  NeoBundle "h1mesuke/vim-alignta"

  " c++ syntax with c++11 support
  NeoBundle "vim-jp/cpp-vim"

  " c++ completion
  NeoBundle "osyo-manga/vim-marching"

  " c++ formatting
  NeoBundle "rhysd/vim-clang-format"

  " CSS3 (Sass)
  NeoBundle "hail2u/vim-css3-syntax.git"

  " Markdown syntax
  NeoBundle "junegunn/vader.vim"
  NeoBundle "godlygeek/tabular"
  NeoBundle "joker1007/vim-markdown-quote-syntax"
  NeoBundle "rcmdnk/vim-markdown"
  "NeoBundle "plasticboy/vim-markdown"

  " Markdown preview
  if ( has("win32unix") || has ("win64unix") ||
        \has("mac") || has ("gui_macvim"))
    NeoBundleLazy "kannokanno/previm", {
          \"autoload": {"commands" : ["PrevimOpen"]}}
  else
    NeoBundleLazy "kannokanno/previm", {
          \ "depends": ["tryu/open-browser.vim"],
          \"autoload": {"commands" : ["PrevimOpen"]}}
  endif

  " Folding method for python, but makes completion too slow...?
  "NeoBundle "vim-scripts/python_fold"

  " Python syntax
  NeoBundle "mitsuhiko/vim-python-combined"

  "" Jedi for python
  "NeoBundleLazy "davidhalter/jedi-vim", {
  "    \ "autoload": { "filetypes": [ "python", "python3", "djangohtml"] }}

  " Java
  NeoBundle "koron/java-helper-vim"

  " Applescript
  NeoBundle "applescript.vim"

  " Powershell
  NeoBundle "PProvost/vim-ps1"

  " Another status line
  NeoBundle "itchyny/lightline.vim"

  " Visual indent guides: make moving slow?
  NeoBundle "nathanaelkane/vim-indent-guides"

  " Sub mode
  NeoBundleLazy "kana/vim-submode", {
        \ "autoload": { "commands": ["submode"]}}

  " Open browser
  NeoBundleLazy "tyru/open-browser.vim", { "autoload": {
        \ "mappings" : "<Plug>(openbrowser-smart-search)"}}

  " Open browser GitHub
  NeoBundleLazy "tyru/open-browser-github.vim", {
        \ "depends": ["tryu/open-browser.vim"],
        \ "autoload": { "commands" : ["OpenGithubFile","OpenGithubIssue"] }}

  " Easymotion
  NeoBundleLazy "Lokaltog/vim-easymotion"

  " virtual env
  NeoBundle "jmcantrell/vim-virtualenv"

  " Syntax checking
  "NeoBundle "scrooloose/syntastic"

  " Syntax checking
  NeoBundle "osyo-manga/vim-watchdogs", {
      \ "depends": ["Shougo/vimproc", "thinca/vim-quickrun", "dannyob/quickfixstatus",
                   \"osyo-manga/shabadou.vim", "cohama/vim-hier"]}

  " Mark syntax error lines by watchdogs
  NeoBundle "KazuakiM/vim-qfsigns"

  " Syntax for vim
  NeoBundle "dbakker/vim-lint"

  " Change current directory to root, for git/svn, etc...
  NeoBundle "airblade/vim-rooter"

  " Count searching objects
  NeoBundle "osyo-manga/vim-anzu"

  " Improved incremental searching
  NeoBundle "haya14busa/incsearch.vim"

  " Git
  NeoBundle "tpope/vim-fugitive" " necessary ('depends' in gitv is not enough. Maybe it uses autoload...?)
  NeoBundleLazy "gregsexton/gitv", {
        \ "depends": ["tpope/vim-fugitive"],
        \ "autoload": { "commands": ["Gitv"]}}

  " Show added/deleted/modified lines for several version control system
  NeoBundle "mhinz/vim-signify"

  " For git/svn status, log
  NeoBundleLazy "hrsh7th/vim-versions.git", {
        \ "autoload": { "commands": ["UniteVersions"]}}

  " Version control (especially for VCSVimDiff (<Leader>cv)
  NeoBundle 'vcscommand.vim'

  " Gist
  NeoBundleLazy "mattn/gist-vim", {
        \ "depends": ["mattn/webapi-vim"],
        \ "autoload": {"commands": ["Gist"] }}

  " Date increment
  NeoBundle "tpope/vim-speeddating"

  " Table
  NeoBundle "dhruvasagar/vim-table-mode"

  " vim-ref
  NeoBundleLazy "thinca/vim-ref", {
        \  "autoload" : {"commands": ["Ref"] }}

  " LanguageTool
  NeoBundleLazy "vim-scripts/LanguageTool", {
        \  "autoload" : {"commands": ["LanguageToolCheck"] }}

  " Grammer check with LanguageTool
  "NeoBundle "rhysd/vim-grammarous"


  " Excite Translate
  NeoBundleLazy "mattn/excitetranslate-vim", {
        \ "depends": "mattn/webapi-vim",
        \ "autoload" : { "commands": ["ExciteTranslate"] }}

  " Google Translate
  NeoBundleLazy "daisuzu/translategoogle.vim", {
        \ "autoload" : { "commands": ["TranslateGoogle", "TranslateGoogleCmd"] }}

  " Habatobi
  NeoBundleLazy "mattn/habatobi-vim",{
        \ "autoload" : {"commands": ["Habatobi"] }}

  " flappyvird
  NeoBundleLazy "mattn/flappyvird-vim",{
        \ "autoload" : {"commands": ["FlappyVird"] }}

  " puyopuyo
  NeoBundleLazy "rbtnn/puyo.vim",{
        \ "autoload" : {"commands": ["Puyo"] }}

  " Make benchmark result of vimrc
  NeoBundleLazy "mattn/benchvimrc-vim",{
        \ "autoload" : {"commands": ["BenchVimrc"] }}

  " The NERD Tree: File Explorer
  NeoBundleLazy "scrooloose/nerdtree", {
        \ "autoload" : { "commands": ["NERDTreeToggle"] }}

  " Source Explorer
  NeoBundleLazy "wesleyche/SrcExpl", {
        \ "autoload" : { "commands": ["SrcExplToggle"] }}

  " For Tags
  NeoBundleLazy "majutsushi/tagbar", {
        \ "autoload": { "commands": ["TagbarToggle"] }}

  " Make help
  NeoBundleLazy "LeafCage/vimhelpgenerator",{
        \ "autoload" : {"commands": ["VimHelpGenerator"] }}

  " yank
  NeoBundle "LeafCage/yankround.vim"

  " over
  NeoBundle "osyo-manga/vim-over"

  " vim-multiple-cursors, like Sublime Text's multiple selection
  NeoBundle "terryma/vim-multiple-cursors"

  " switch
  "NeoBundle "AndrewRadev/switch.vim"

  " linediff
  NeoBundle "AndrewRadev/linediff.vim"

  " expand region
  NeoBundle "terryma/vim-expand-region"

  " Windows StartMenu
  if ( has("win32unix") || has ("win64unix") || has("win32") || has ("win64"))
    NeoBundleLazy "mattn/startmenu-vim", {
          \ "autoload" : { "commands": ["StartMenu"] }}
    NeoBundleLazy "mattn/excelview-vim", {
          \ "depends": "mattn/webapi-vim",
          \ "autoload" : { "commands": ["ExcelView"] }}
  endif

  " Highlight on the fly
  NeoBundle "t9md/vim-quickhl"

  " Calendar/Tasks
  NeoBundleLazy "itchyny/calendar.vim", {
        \ "autoload" : {"commands": ["Calendar"] }}

  " Especially for CSV editing
  NeoBundleLazy "rbtnn/rabbit-ui.vim",{
        \ "autoload" : {"commands": ["EditCSV"] }}

  " Character base diff
  "NeoBundle "vim-scripts/diffchar.vim"

  " Rogue
  NeoBundleLazy "katono/rogue.vim", {
        \ "autoload" : {"commands": ["Rogue"] }}

  " no more :set passte!
  "NeoBundle "ConradIrwin/vim-bracketed-paste"

  """""""""""""""""""""""""""""""""

  " local plugins
  NeoBundleLocal ~/.vim/local/bundle
  """"plugins end"""""

  " End of NeoBundle
  call neobundle#end()

  " Installation check.
  NeoBundleCheck
endif
" }}} neobundle

" Basic settings {{{

" Reset my auto group
augroup MyAutoGroup
  autocmd!
augroup END

" Enable plugin, indent again
filetype plugin indent on

" Switch syntax highlighting on, when the terminal has colors
syntax on

" Switch on highlighting the last used search pattern.
set hlsearch

" allow backspacing over everything in insert mode
" indent: spaces of the top of the line
" eol   : break
" start : character before the starting point of the insert mode
set backspace=indent,eol,start

set modeline       " enable to use settings written in the file
" use with comment lines: e.g.)
" # vim setlocal foldmethod=marker:
" # vim setlocal foldmarker={{{,}}}:
set modelines=3    " number of lines to be read (form top and bottom) for
" modeline
set tabstop=2      " width of <Tab> in view
set shiftwidth=2   " width for indent
set softtabstop=0  " disable softtabstop function
set autoindent     " autoindent
set cinoptions=g0  " g0: no indent for private/public/protected

"set textwidth=0    " a longer line than textwidth will be broken (0: disable)
autocmd MyAutoGroup FileType *  setlocal textwidth=0 " overwrite ftplugin settings
if exists ("&colorcolumn")
  set colorcolumn=81 " put line on 81
  "set colorcolumn=+1 " put line on textwidth+1
  " Change background for 81-end of the line
  "execute "set colorcolumn=" . join(range(81, 999), ",")
endif
set wrap           " longer line is wrapped
set display=lastline " Show all even if there is many characters in one line.
"set linebreak      " wrap at 'breakat'
set nolinebreak
"set breakat=\ ^I!@*-+;:,./?()[]{}<>'"`     " break point for linebreak
set breakat=
"set showbreak=+\   " set showbreak
set showbreak=
if (v:version == 704 && has("patch338")) || v:version >= 705
  set nobreakindent
  "set breakindent    " indent even for wrapped lines
  "" breakindent option (autocmd is necessary when new file is opened in Vim)
  "" necessary even for default(min:20,shift:0)
  "autocmd MyAutoGroup BufEnter * set breakindentopt=min:20,shift:0
endif

set expandtab      " do :retab -> tab->space

set swapfile       " use swap file
set nobackup       " do not keep a backup file
set nowritebackup  " do not create backup file

let &backupskip="/private/tmp/*," . &backupskip

let s:defdir=&directory
let s:defbackup=&backupdir
if ! empty($TMP) && isdirectory($TMP)
  let s:tmpdir=$TMP
elseif ! empty($TMPDIR) && isdirectory($TMPDIR)
  let s:tmpdir=$TMPDIR
elseif ! empty($TEMP) && isdirectory($TEMP)
  let s:tmpdir=$TEMP
else
  let s:tmpdir="./"
endif
let &directory=s:tmpdir . "," . s:defdir " directory for swap file
let &backupdir=s:tmpdir . "," . s:defdir " directory for backup file

if has("win32") || has ("win64")
  set viminfo+=n~/.vim/viminfo_win
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
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:% " Set words for above
set ruler          " Show the cursor position all the time
set showcmd        " Display incomplete commands
set novisualbell   " No visual bell
"set cursorline     " Enable highlight on current line:
                   " but make moving cursor slow for heavily highlighted file...
"set scrolloff=999  " Show cursor at middle
" (scrolloff is number of lines which should be shown above and below cursor.
"  such large number force to stay a cursor at middle.)
set scrolloff=10  " Show cursor around the middle
set scroll=0       " Number of lines to scroll with C-U/C-D (0 for half window)
set mouse=         " Disable mouse
set ambiwidth=double  " For UTF-8, width for East Asian Characters. It doesn't work at specific terminals?(iTerm, putty, etc..?)
set cmdheight=1    " Command line height
set showmatch      " Show maching one for inserted bracket
set matchtime=1    " 0.1*matchtime sec for showing matching pattern (default:5)
set pumheight=20   " length of popup menu for completion

set spell          " Spell check highlight
"set nospell        " No spell check

if (v:version == 704 && has("patch88")) || v:version >= 705
  set spelllang+=cjk " Ignore double-width characters
endif

" IME setting
if has("multi_byte_ime") || has("xim") || has("gui_macvim")
  set iminsert=0
  set imsearch=0
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

" Encode
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin

" bash-like tab completion
set wildmode=list:longest
set wildmenu

" Folding
setlocal foldmethod=marker
setlocal foldmarker={{{,}}} "default
autocmd MyAutoGroup FileType py setlocal foldmethod=syntax
autocmd MyAutoGroup FileType cpp,cxx,C setlocal foldmethod=marker foldmarker={,}
set foldnestmax=1
set foldlevel=100 "open at first

autocmd MyAutoGroup InsertEnter * if &l:foldmethod ==# 'expr'
      \ | let b:foldinfo = [&l:foldmethod, &l:foldexpr]
      \ | setlocal foldmethod=manual foldexpr=0
      \ | endif
autocmd MyAutoGroup InsertLeave * if exists('b:foldinfo')
      \ | let [&l:foldmethod, &l:foldexpr] = b:foldinfo
      \ | endif

" When editing a file, always jump to the last known cursor position.
autocmd MyAutoGroup BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Avoid automatic comment out for the next line after the comment lines
autocmd MyAutoGroup FileType * setlocal formatoptions-=ro

" Arrow to open new file while current file is not saved
set hidden

" Jump to the first opened window
set switchbuf=useopen

" virtualedit (can move to non-editing places: e.x. right of $)
set virtualedit=all

" Set nopaste when it comes back to Normal mode
autocmd MyAutoGroup InsertLeave * setlocal nopaste

" Avoid to paste/insert in non-editing place
if has("virtualedit") && &virtualedit =~# '\<all\>'
  " p should be fixed, with yankround -> it maps p
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

" VimShowHlGroup: Show highlight group name under a cursor
command! VimShowHlGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
" VimShowHlItem: Show highlight item name under a cursor
command! VimShowHlItem echo synIDattr(synID(line("."), col("."), 1), "name")

function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

" Max columns for syntax search
" Such XML file has too much syntax which make vim drastically slow
set synmaxcol=1000 "default 3000

" Load Man command even for other file types than man.
runtime ftplugin/man.vim

" }}} Basic settings

" map (for other than each plugin){{{
"remapping, tips

" n Normal mode
" i Insert/Replace modes
" v Visual and Select modes (=x+s)
" x Visual mode
" s Select mode
" c Command line mode
" o Operator pending mode
"
"    commands:                                   modes:
"                                      Normal  Visual+Select  Operator-pending
":map   :noremap   :unmap   :mapclear    yes        yes        yes
":nmap  :nnoremap  :nunmap  :nmapclear   yes         -          -
":vmap  :vnoremap  :vunmap  :vmapclear    -         yes         -
":omap  :onoremap  :ounmap  :omapclear    -          -         yes
"
"    commands:                                   modes:
"                                      Visual    Select
":vmap  :vnoremap  :vunmap  :vmapclear   yes      yes
":xmap  :xnoremap  :xunmap  :xmapclear   yes       -
":smap  :snoremap  :sunmap  :smapclear    -       yes
"
"    commands:                                   modes:
"                                       Insert  Command-line  Lang-Arg
":map!  :noremap!  :unmap!  :mapclear!   yes       yes           -
":imap  :inoremap  :iunmap  :imapclear   yes        -            -
":cmap  :cnoremap  :cunmap  :cmapclear    -        yes           -
":lmap  :lnoremap  :lunmap  :lmapclear   yes*      yes*         yes*

" nm = nmap
" vm = vmap
" ...
" For smap, sm != smap (sm = smagic)
"
" no = noremap
" nn = nnoremap
" vn = vnoremap
" xn = xnoremap
" snor = snorremap
" ono = snorremap
" no! = noremap!
" ino = inoremap
" ln = lnoremap
" cno = cnoremap
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

""" Normal + Visual modes

" mapleader (<Leader>) (default is \)
let mapleader = ","
" use \, as , instead
noremap <Subleader> <Nop>
map \ <Subleader>
noremap <Subleader>, ,

" fix meta-keys
map <ESC>p <M-p>
map <ESC>n <M-n>

" Swap colon <-> semicolon
noremap ; :
noremap : ;

" Require <Leader> before gu*/gU* (Change to lowr/upper case)
noremap gu <Nop>
noremap gU <Nop>
noremap <Leader>gu gu
noremap <Leader>gU gU

""" Normal mode

" cursor move
" Left (C-h default: <BS> ~ h)
"nnoremap <C-h> h
" Right (C-j default: <NL> ~ j)
"nnoremap <C-j> j
" Up (C-k default: Non)
nnoremap <C-k> k
" Down (C-l default: Clear and redraw the screen)
nnoremap <C-l> l
" Go to Head (C-a default: Increment)-><C-a> can't be used with vim-speeddating
"nnoremap <C-a> 0
nnoremap <M-h> 0
nnoremap <D-h> 0
nnoremap <Space>h 0
nnoremap H 0
" Go to End (C-e default: Scroll down)
"nnoremap <C-e> $
nnoremap <M-l> $
nnoremap <D-l> $
nnoremap <Space>l $
nnoremap L $
" Go to top
nnoremap <M-k> gg
nnoremap <D-k> gg
nnoremap <Space>k gg
" Go to bottom
nnoremap <M-j> G
nnoremap <D-j> G
nnoremap <Space>j G
" Substitute for C-a (C-q default: C-V alternative for gui mode)
"nnoremap <C-q> <C-a> " not work...
" Substitute for C-a (C-z default: suspend, same as :stop)
"nnoremap <C-z> <C-a>
" Substitute for C-a (C-s default: non?)
"nnoremap <C-s> <C-a>

" tag jump (avoid crash with screen's key bind, C-' default: Non?)
nnoremap <C-'> <C-t>

" spell check toggle
nnoremap <silent> <Leader>s :setlocal spell!<CR>

" stop highlight for search
nnoremap <silent> <Leader>/ :noh<CR>

" alignment at normal mode
"nnoremap = v=

" insert file name
"nnoremap <silent> ,f i<CR><Esc><BS>:r!echo %<CR>i<BS><Esc>Jx

" save/quit
"nnoremap <Leader>w :w<CR>
"nnoremap <Leader>q :q<CR>
"nnoremap <Leader>wq :wq<CR>
"nnoremap <Leader>1 :q!<CR>
"nnoremap W :w<CR>
"nnoremap ! :q!<CR>
"nnoremap Z ZZ
nnoremap <A-w> :w<CR>
nnoremap <A-q> :q!<CR>
nnoremap <A-z> :ZZ<CR>
" don't enter Ex mode: map to quit
nnoremap Q :q<CR>
" Use Z as ZZ
nnoremap Z ZZ

" Close/Close & Save buffer
nnoremap <Leader>q :bdelete<CR>
nnoremap <Leader>w :w<CR>:bdelete<CR>

" remove trail spaces, align
if v:version >= 703
  function! s:indent_all()
    normal! mxgg=G'x
    delmarks x
  endfunction
  command! IndentAll call s:indent_all()

  function! s:delete_space()
    normal! mxG$
    let flags = "w"
    while search(" $", flags) > 0
      s/ \+$//g
      let flags = "W"
    endwhile
    'x
    delmarks x
  endfunction
  command! DeleteSpace call s:delete_space()

  function! s:align_code()
    retab
    IndentAll
    DeleteSpace
  endfunction
  command! AlignCode call s:align_code()

  function! s:align_all_buf()
    for i in  range(1, bufnr("$"))
      if buflisted(i)
        execute "buffer" i
        call AlignCode()
        update
        bdelete
      endif
    endfor
    quit
  endfunction
  command! AlignAllBuf call s:align_all_buf()

  "nnoremap <Leader><Space> :ret<CR>:IndentAll<CR>:DeleteSpace<CR>

  " remove trail spaces for all
  nnoremap <Leader><Space> :DeleteSpace<CR>

  " remove trail spaces at selected region
  xnoremap <Leader><Space> :s/<Space>\+$//g<CR>

endif

" Fix Y
nnoremap Y y$

" Paste, Paste mode
nnoremap <silent> <Leader>p "+gP
nnoremap <silent> <Leader>P :setlocal paste!<CR>:setlocal paste?<CR>
inoremap <silent> <C-]> <C-o>:setlocal paste!<CR>

" *, #, stay at current word->mapped for anzu
if ! s:neobundle_enabled || empty(neobundle#get("vim-anzu"))
  " swap * and g*, and add <C-o> to stay on current word.
  nnoremap g* *<C-o>
  nnoremap * g*<C-o>
  nnoremap # #<C-o>
endif

" Open vimrc
nnoremap <Leader><Leader> :tabedit $MYVIMRC<CR>

" Source vimrc
nnoremap <Leader>. :source $MYVIMRC<CR>

" search: very magic mode
nnoremap / /\v
" to check patterns:
" :h pattern-overview

" Close immediately by q, set non-modifiable settings
autocmd MyAutoGroup FileType help,qf,man,ref nnoremap <buffer> q :q!<CR>
autocmd MyAutoGroup FileType help,qf,man,ref setlocal nospell ts=8 nolist ro nomod noma

""" insert mode

" emacs (bash) like move in insert mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-k> <Leader><C-o>D

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

""" visual mode

" Select word
xnoremap w iw
xnoremap W iW

" Go to the last character, instead of the last + 1
xnoremap $ $h
xnoremap L $h
xnoremap v $h

""" command line mode
" Cursor move
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <C-b>

" Write as root
cnoremap w!! w !sudo tee > /dev/null %

" }}} map

" Colors {{{

" need for two-byte space?
"scriptencoding utf-8
"scriptencoding cp932
augroup MyColors
  autocmd!
  " for spell checks
  "autocmd ColorScheme * hi SpellBad cterm=inverse ctermbg=0
  autocmd ColorScheme * hi SpellBad cterm=underline ctermbg=0
  autocmd ColorScheme * hi SpellCap cterm=underline ctermbg=0
  autocmd ColorScheme * hi SpellLocal cterm=underline ctermbg=0
  autocmd ColorScheme * hi SpellRare cterm=underline ctermbg=0

  " Set all white characters on black background for current line
  if &cursorline
    autocmd ColorScheme * hi CursorLine cterm=underline
    autocmd InsertEnter * hi CursorLine cterm=bold
    autocmd InsertLeave * hi CursorLine cterm=underline

    " SpecialKey, needed for cursorline
    autocmd ColorScheme * hi link MySpecialKey SpecialKey
    autocmd VimEnter,WinEnter * let w:m_sp = matchadd("MySpecialKey", '\(\t\| \+$\)')
  endif

  " colors for completion
  autocmd ColorScheme * hi Pmenu ctermbg=255 ctermfg=0 guifg=#000000 guibg=#999999
  autocmd ColorScheme * hi PmenuSel ctermbg=blue ctermfg=black
  autocmd ColorScheme * hi PmenuSbar ctermbg=0 ctermfg=9
  autocmd ColorScheme * hi PmenuSbar ctermbg=255 ctermfg=0 guifg=#000000 guibg=#FFFFFF

  " colors for diff mode
  autocmd ColorScheme * hi DiffAdd ctermbg=17 guibg=slateblue
  autocmd ColorScheme * hi DiffChange ctermbg=22 guibg=darkgreen
  autocmd ColorScheme * hi DiffText cterm=bold ctermbg=52 gui=bold guibg=olivedrab
  autocmd ColorScheme * hi DiffDelete term=bold ctermfg=12 ctermbg=6 gui=bold guifg=Blue guibg=coral

  " Colors for search
  autocmd ColorScheme * hi Search term=reverse ctermfg=Red ctermbg=11 guifg=Black

  " Colors for SpecialKey
  autocmd Colorscheme * hi SpecialKey term=bold ctermfg=9

  " column
  autocmd ColorScheme * hi ColorColumn ctermbg=017

  " html
  autocmd ColorScheme * hi link htmlItalic LineNr
  autocmd ColorScheme * hi link htmlBold WarningMsg
  autocmd ColorScheme * hi link htmlBoldItalic ErrorMsg

  " two-byte space
  autocmd ColorScheme * hi link TwoByteSpace Error
  autocmd VimEnter,WinEnter * let w:m_tbs = matchadd("TwoByteSpace", '　')
augroup END

colorscheme ron
" }}} colorscheme

" diff mode {{{
function! SetDiffMode()
  if &diff
    "set wrap " not work...
    set nospell
    " force to warp at diff mode
    set wrap
    wincmd w
    set wrap
    wincmd w
  endif
endfunction
autocmd MyAutoGroup VimEnter,FilterWritePre * call SetDiffMode()

set diffopt=filler,vertical
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
"nnoremap u g-
"nnoremap <C-r> g+
" }}} undo

" gundo {{{
if s:neobundle_enabled && ! empty(neobundle#get("gundo.vim"))
  nnoremap U :GundoToggle<CR>
  let g:gundo_width = 30
  let g:gundo_preview_height = 15
  let g:gundo_auto_preview = 0 " Don't show preview by moving history. Use r to see differences
  let g:gundo_preview_bottom = 1 " Show preview at the bottom
endif
" }}} gundo

" Unite {{{
if s:neobundle_enabled && ! empty(neobundle#get("unite.vim"))
  autocmd MyAutoGroup FileType unite call s:unite_my_settings()
  function! s:unite_my_settings()
    nmap <buffer><Esc> <Plug>(unite_exit)
    imap <buffer> jj      <Plug>(unite_insert_leave)
    "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

    imap <buffer><expr> j unite#smart_map('j', '')
    imap <buffer> <TAB>   <Plug>(unite_select_next_line)
    imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
    imap <buffer> '     <Plug>(unite_quick_match_default_action)
    nmap <buffer> '     <Plug>(unite_quick_match_default_action)
    imap <buffer><expr> x
          \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
    nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
    nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
    nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
    imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
    nnoremap <silent><buffer><expr> l
          \ unite#smart_map('l', unite#do_action('default'))

    let unite = unite#get_current_unite()
    if unite.buffer_name =~# '^search'
      nnoremap <silent><buffer><expr> r     unite#do_action('replace')
    else
      nnoremap <silent><buffer><expr> r     unite#do_action('rename')
    endif

    nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
    nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
          \ empty(unite#mappings#get_current_filters()) ?
          \ ['sorter_reverse'] : [])

    " Runs "split" action by <C-s>.
    imap <silent><buffer><expr> <C-s>     unite#do_action('split')
  endfunction
  " start with insert mode (can start narrow result in no time)
  let g:unite_enable_start_insert=1
  " window
  "let g:unite_enable_split_vertically=1
  let g:unite_split_rule="botright" " default topleft
  let g:unite_winheight=10          " default 20
  let g:unite_winwidth=60           " default 90
  let g:unite_data_directory=g:vimdir . ".cache/unite"

  " Unite prefix
  nnoremap [unite] <Nop>
  nmap <Leader>u [unite]

  " show buffer
  nnoremap <silent> [unite]b :Unite buffer<CR>
  " show files/directories with full path
  nnoremap <silent> [unite]f :Unite -buffer-name=files file<CR>
  " show frecursive file search
  "nnoremap <silent> [unite]f :<C-u>Unite file_rec/async:!<CR>
  " show register
  nnoremap <silent> [unite]r :Unite -buffer-name=register register<CR>
  " show opened file history including current buffers
  "nnoremap <silent> [unite]m :UniteWithBufferDir -buffer-name=files buffer file_mru<CR>
  nnoremap <silent> [unite]m :Unite file_mru<CR>
  " show lines of current file
  nnoremap <silent> [unite]l :Unite line<CR>
  " search (like ack.vim/ag.vim)
  nnoremap <silent> [unite]/ :Unite grep:.<CR>
  " Yank (like yankring/yankstack)
  "let g:unite_source_history_yank_enable = 1
  "nnoremap <silent> [unite]y :Unite history/yank<CR>
  nnoremap <silent> [unite]y :Unite yankround<CR>

  " sources outside of unite
  nnoremap <silent> [unite]M :Unite mark<CR>
  nnoremap <silent> [unite]c :Unite history/command<CR>
  nnoremap <silent> [unite]s :Unite history/search<CR>
  nnoremap <silent> [unite]F :Unite fold<CR>
  nnoremap <silent> [unite]L :Unite locate<CR>
  nnoremap <silent> [unite]C :Unite colorscheme<CR>
endif
" }}} Unite

" wildfire {{{
if s:neobundle_enabled && ! empty(neobundle#get("wildfire.vim"))
  " This selects the next closest text object.
  let g:wildfire_fuel_map = "<ENTER>"

  " This selects the previous closest text object.
  let g:wildfire_water_map = "<BS>"
endif
"}}}

" operator {{{
nnoremap [oper] <Nop>
nm <Leader>o [oper]
if s:neobundle_enabled && ! empty(neobundle#get("vim-operator-sort"))
  map [oper]s <Plug>(operator-sort)
endif
if s:neobundle_enabled && ! empty(neobundle#get("operator-reverse.vim"))
  map [oper]r  <Plug>(operator-reverse-text)
endif
"}}}

" vim-surround {{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-surround"))
  let g:surround_{char2nr("a")} = "**\r**"
  nmap <Leader>{ ysiw{
  nmap <Leader>} ysiw}
  nmap <Leader>[ ysiw[
  nmap <Leader>] ysiw]
  nmap <Leader>( ysiw(
  nmap <Leader>) ysiw)
  nmap <Leader>< ysiw<
  nmap <Leader>> ysiw>
  nmap <Leader>" ysiw"
  nmap <Leader>' ysiw'
  nmap <Leader>` ysiw`
  nmap <Leader>* ysiw*
  nmap <Leader><Leader>* ysiw*wysiw*
  nmap <Leader>a ysiwa
  xmap { S{
  xmap } S}
  xmap [ S[
  xmap ] S]
  xmap ( S(
  xmap ) S)
  xmap < S<
  xmap > S>
  xmap " S"
  xmap ' S'
  xmap ` S`
  xmap * S*
  xmap <Leader>* S*gvS*
  xmap <Leader>a Sa
endif
" }}} vim-surround.vim

" vim-marching {{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-marching"))
  let g:marching_enable_neocomplete = 1
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
endif
" }}} vim-marching

" vim-clang-format {{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-clang-format"))
  let g:clang_format#style_options = {
              \ "AccessModifierOffset" : -4,
              \ "AllowShortIfStatementsOnASingleLine" : "true",
              \ "AlwaysBreakTemplateDeclarations" : "true",
              \ "Standard" : "C++11"}
  " map to <Leader>cf in C++ code
  autocmd MyAutoGroup FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
  autocmd MyAutoGroup FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
  " if you install vim-operator-user
  autocmd MyAutoGroup FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
endif
" }}} vim-clang-format

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

xnoremap <silent> [yshare]y "sy:call YSStore()<CR>
xnoremap <silent> [yshare]c "sc<ESC>:call YSStore()<CR>i
xnoremap <silent> [yshare]d "sd:call YSStore()<CR>

nnoremap <silent> [yshare]p :call YSLoad()<CR>"sp
nnoremap <silent> [yshare]P :call YSLoad()<CR>"sP
nnoremap <silent> [yshare]gp :call YSLoad()<CR>"sgp
nnoremap <silent> [yshare]gP :call YSLoad()<CR>"sgP
" }}} yankshare

" yankround {{{
if s:neobundle_enabled && ! empty(neobundle#get("yankround.vim"))
  nmap <expr> p (col('.') >= col('$') ? '$' : '') . '<Plug>(yankround-p)'
  xmap <expr> p (col('.') >= col('$') ? '$' : '') . '<Plug>(yankround-p)'
  nmap <expr> P (col('.') >= col('$') ? '$' : '') . '<Plug>(yankround-P)'
  nmap gp <Plug>(yankround-gp)
  xmap gp <Plug>(yankround-gp)
  nmap gP <Plug>(yankround-gP)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
  let g:yankround_max_history = 30
  let g:yankround_dir = '~/.vim/yankround'
  let g:yankround_max_element_length = 0
  let g:yankround_use_region_hl = 1
endif
" }}}

" vim-over {{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-over"))
  nnoremap <Leader>c :OverCommandLine<CR>%s/
  xnoremap <Leader>c :OverCommandLine<CR>s/
endif
" }}}

" status line {{{
set laststatus=2 " always show
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
" }}} status line

" neocomplcache {{{
if s:neobundle_enabled && ! empty(neobundle#get("neocomplcache.vim"))
  let g:acp_enableAtStartup = 1
  let g:neocomplcache_enable_startup = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
  let g:neocomplcache_text_mode_filetypes =
        \ {'text': 1, 'plaintex':1, 'javascript': 1,
        \  'mkd': 1, 'perl': 1, 'html': 1}
endif
" }}}

" neocomplete {{{
if s:neobundle_enabled && ! empty(neobundle#get("neocomplete.vim"))
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#max_list = 20
  let g:neocomplete#min_keyword_length = 3
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#disable_auto_complete = 0
  let g:neocomplete#enable_auto_select = 0
  let g:neocomplete#lock_buffer_name_pattern = ''
  " text mode is necessary for look
  " But it is not useful for code writing because it convert like:
  " NeoBundle to NeoBundle.
  let g:neocomplete#text_mode_filetypes =
        \ {'hybrid': 1, 'text':1, 'help': 1, 'gitcommit': 1, 'gitrebase':1,
        \  'vcs-commit': 1, 'markdown':1, 'textile':1, 'creole':1, 'org':1,
        \  'rdoc':1, 'mediawiki':1, 'rst':1, 'asciidoc':1, 'prod':1,
        \  'plaintex':1, 'mkd': 1, 'html': 1,
        \  'vim':0, 'sh':0, 'javascript':0, 'perl':0}
  let g:neocomplete#same_filetypes = {}
  let g:neocomplete#same_filetypes._ = '_'
  "inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><Tab> pumvisible() ? "\<C-n>" : neocomplete#start_manual_complete()
  inoremap <expr><A-y>  neocomplete#close_popup()
  inoremap <expr><A-e>  neocomplete#cancel_popup()
  inoremap <expr><A-l>  neocomplete#complete_common_string()
  inoremap <expr><A-u>  neocomplete#undo_completion()
endif
" }}}

" neosnippet {{{
if s:neobundle_enabled && ! empty(neobundle#get("neosnippet"))
  imap <silent><C-k> <Plug>(neosnippet_expand_or_jump)
  inoremap <silent><C-U> <ESC>:<C-U>Unite snippet<CR>
  "nnoremap <silent><Space>e :<C-U>NeoSnippetEdit -split<CR>
  smap <silent><C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <silent>o <Plug>(neosnippet_register_oneshot_snippet)
  "im <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  "smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
endif
" }}}

" matchpair, matchit {{{
"set matchpairs = (:),{:},[:]
set matchpairs+=<:>
source $VIMRUNTIME/macros/matchit.vim
" matchpairs is necessary...?
"let b:match_words = &matchpairs . ',<:>,<div.*>:</div>,if:fi'
let b:match_words = &matchpairs . ',<:>,<div.*>:</div>,{%.*%}:{% *end.*%}'
let b:match_ignorecase = 1
" }}} matchpair, matchit

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
if s:neobundle_enabled && ! empty(neobundle#get("vim-easymotion"))
  let g:EasyMotion_do_mapping=0
  let g:EasyMotion_grouping=1
  let g:EasyMotion_enter_jump_first=1
  let g:EasyMotion_space_jump_first=1
  let g:EasyMotion_smartcase=1
  let g:EasyMotion_use_upper=1
  let g:EasyMotion_keys="HJKLASDFGYUIOPQWERTNMZXCVB"
  hi EasyMotionTarget ctermbg=none ctermfg=red
  hi EasyMotionShade  ctermbg=none ctermfg=blue

  nmap S <Plug>(easymotion-s2)
  xmap S <Plug>(easymotion-s2)
  omap S <Plug>(easymotion-s2)
  map <Leader>f <Plug>(easymotion-bd-W)

  "map f <Plug>(easymotion-bd-fl)
  "map t <Plug>(easymotion-bd-tl)
  "map F <Plug>(easymotion-bd-Fl)
  "map T <Plug>(easymotion-bd-Tl)

  let g:EasyMotion_startofline=0
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)

  nmap g/ <Plug>(easymotion-sn)
  xmap g/ <Plug>(easymotion-sn)
  omap g/ <Plug>(easymotion-sn)
  "map  / <Plug>(easymotion-sn)
  "omap / <Plug>(easymotion-tn)
  "map  n <Plug>(easymotion-next)
  "map  N <Plug>(easymotion-prev)
endif
" }}} vim-easymotion

" jedi-vim{{{
if s:neobundle_enabled && ! empty(neobundle#get("jedi-vim"))
  let g:jedi#auto_initialization = 1
  let g:jedi#auto_vim_configuration = 1

  nnoremap [jedi] <Nop>
  xnoremap [jedi] <Nop>
  nmap <Leader>j [jedi]
  xmap <Leader>j [jedi]

  "let g:jedi#completions_command = "<C-N>"
  let g:jedi#goto_assignments_command = "[jedi]g"
  let g:jedi#goto_definitions_command = "[jedi]d"
  let g:jedi#documentation_command = "[jedi]K"
  let g:jedi#rename_command = "[jedi]r"
  let g:jedi#usages_command = "[jedi]n"
  let g:jedi#popup_select_first = 0
  let g:jedi#popup_on_dot = 0

  "autocmd MyAutoGroup FileType python setlocal omnifunc=jedi#complete
  "let g:jedi#auto_vim_configuration = 0
  "if ! empty(neobundle#get("neocomplete.vim"))
  "  if !exists('g:neocomplete#force_omni_input_patterns')
  "    let g:neocomplete#force_omni_input_patterns = {}
  "  endif
  "  let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
  "endif
endif
" }}} jedi-vim

" vim-indent-guides{{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-indent-guides"))
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 1
  let g:indent_guides_auto_colors = 0
  autocmd MyAutoGroup VimEnter,Colorscheme * hi IndentGuidesEven term=bold ctermfg=9 ctermbg=235
  autocmd MyAutoGroup VimEnter,Colorscheme * hi IndentGuidesOdd term=bold ctermfg=9 ctermbg=239
endif
"}}} vim-indent-guides

" vim-submode{{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-submode"))
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
if s:neobundle_enabled && ! empty(neobundle#get("vim-operator-replace"))
  map _  <Plug>(operator-replace)
endif
"}}} vim-operator-replace

" open-browser{{{
if s:neobundle_enabled && ! empty(neobundle#get("open-browser.vim"))
  let g:netrw_nogx = 1 " disable netrw's gx mapping.
  nmap gx <Plug>(openbrowser-smart-search)
  xmap gx <Plug>(openbrowser-smart-search)
endif
"}}} open-browser

" LanguageTool{{{
if s:neobundle_enabled && ! empty(neobundle#get("LanguageTool"))
  " jar file settings
  let s:languagetool_version="2.6"
  let s:languagetool_zip="LanguageTool-".s:languagetool_version.".zip"
  let s:languagetool_download=
        \"http://www.languagetool.org/download/".s:languagetool_zip
  let s:languagetool_parent_dir=g:vimdir."/languagetool/"
  let s:languagetool_dir=s:languagetool_parent_dir."/LanguageTool-"
        \.s:languagetool_version."/"
  let s:languagetool_v_file=s:languagetool_dir."/version_in_vim"

  let g:languagetool_jar=s:languagetool_dir."/languagetool-commandline.jar"

  " Check/Prepare LanguageTool
  let s:languagetool_v_test=system("cat " . s:languagetool_v_file)
  if s:languagetool_v_test != s:languagetool_version
    echo s:languagetool_v_test
    echo "Preparing LanguageTool..."
    echo "getting " . s:languagetool_download . "..."
    call system("rm -rf " . s:languagetool_dir)
    call system("rm -rf " . s:languagetool_dir . "/*.zip*")
    call system("mkdir -p " . s:languagetool_parent_dir)
    execute "lcd" s:languagetool_parent_dir
    call system("wget " . s:languagetool_download)
    echo "done wget " . s:languagetool_download
    call system("unzip " . s:languagetool_zip )
    call system("rm -f " . s:languagetool_zip)
    call system("printf " . s:languagetool_version . " > " . s:languagetool_v_file)
    lcd -
  endif

  " Other settings
  " If lang is not set, spellang value is used (if it is not set neithr, use en-US).
  "let g:languagetool_lang="en-US"
endif
"}}} LanguageTool

" ExciteTranslate{{{
if s:neobundle_enabled && ! empty(neobundle#get("excitetranslate-vim"))
  xnoremap <Leader>x :ExciteTranslate<CR>
endif
"}}} LanguageTool

" vim-anzu{{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-anzu"))
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * g*<C-o><Plug>(anzu-update-search-status-with-echo)
  "nm g* g*<C-o><Plug>(anzu-update-search-status-with-echo)
  nmap # #<C-o><Plug>(anzu-update-search-status-with-echo)
  let g:airline#extensions#anzu#enabled=0
endif
"}}} vim-anzu

" incsearch{{{
if s:neobundle_enabled && ! empty(neobundle#get("incsearch.vim"))
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  let g:incsearch#magic = '\v'
endif
"}}} vim-anzu

" syntastic{{{
if s:neobundle_enabled && ! empty(neobundle#get("syntastic"))
  " Disable automatic check at file open/close
  let g:syntastic_check_on_open=0
  let g:syntastic_check_on_wq=0
  " C
  let g:syntastic_c_check_header = 1
  " C++
  let g:syntastic_cpp_check_header = 1
  " Java
  let g:syntastic_java_javac_config_file_enabled = 1
  let g:syntastic_java_javac_config_file = "$HOME/.syntastic_javac_config"
endif
"}}} syntastic

" vim-watchdogs{{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-watchdogs"))
  let g:watchdogs_check_BufWritePost_enable = 1
  let g:watchdogs_check_CursorHold_enable = 1
  if !exists("g:quickrun_config")
    let g:quickrun_config = {}
  endif
  let g:quickrun_config["watchdogs_checker/_"] = {
  \ "outputter/quickfix/open_cmd" : "",
  \ "runner/vimproc/updatetime" : 50,
  \ "hook/qfsigns_update/enable_exit": 1,
  \ "hook/qfsigns_update/priority_exit": 3,
  \}
  call watchdogs#setup(g:quickrun_config)
endif
"}}} vim-watchdogs

" vim-hier{{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-hier"))
  highlight qf_error ctermfg=255 ctermbg=1
  highlight qf_warning ctermfg=255 ctermbg=3
  highlight qf_info ctermfg=255 ctermbg=2
  let g:hier_highlight_group_qf   = 'qf_error'
  let g:hier_highlight_group_qfw  = 'qf_warning'
  let g:hier_highlight_group_qfi  = 'qf_info'
endif
" }}} vim-hier

" vim-rooter{{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-rooter"))
  " Default: move to root directory by <Leader>cd or :Rooter

  " Change only current window's directory
  let g:rooter_use_lcd = 1
  " Do not automatically change the directory
  let g:rooter_manual_only = 1
  " Stop the automatic change (some files are )
  let g:rooter_manual_only = 1
  " files/directories for the root directory
  let g:rooter_patterns = ['tags', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', 'Makefile', 'GNUMakefile', 'GNUmakefile', '.svn/']
endif
"}}} vim-rooter

" signify{{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-signify"))
  let g:signify_disable_by_default = 1
  let g:signify_cursorhold_normal = 1
  let g:signify_cursorhold_insert = 1
  nmap <Leader>gj <Plug>(signify-next-jump)
  nmap <Leader>gk <Plug>(signify-prev-jump)
  nnoremap <Leader>gt :SignifyToggle<CR>
  nnoremap <Leader>gh :SignifyToggleHighlight<CR>
endif
"}}} signify

" vim-markdown-quote-syntax {{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-markdown-quote-syntax"))
  let g:markdown_quote_syntax_on_filetypes = ['txt', 'text']
  let g:markdown_quote_syntax_filetypes = {
        \ "css" : {
        \   "start" : "css",
        \},
        \ "scss" : {
        \   "start" : "scss",
        \},
        \ "markdown" : {
        \   "start" : "markdown",
        \},
  \}
endif
" }}} vim-markdown-quote-syntax

" markdown {{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-markdown"))
  let g:vim_markdown_liquid=1
  let g:vim_markdown_frontmatter=1
  let g:vim_markdown_math=0
  let g:vim_markdown_initial_foldlevel=&foldlevel
  let g:vim_markdown_better_folding=0
  autocmd MyAutoGroup BufRead,BufNewFile *.{txt,text,html} setlocal filetype=markdown
  "autocmd MyAutoGroup BufRead,BufNewFile *.{txt,text} setlocal filetype=markdown
endif
" }}} vim-markdown

" applescript{{{
if s:neobundle_enabled && ! empty(neobundle#get("applescript.vim"))
  autocmd MyAutoGroup BufNewFile,BufRead *.scpt,*.applescript :setlocal filetype=applescript
  "autocmd MyAutoGroup FileType applescript :inoremap <buffer> <S-CR>  ¬<CR>
endif
"}}} applescript

" lightline.vim {{{
if s:neobundle_enabled && ! empty(neobundle#get("lightline.vim"))
  let g:lightline = {
        \"colorscheme": "jellybeans",
        \"active": {
        \"left": [["test", "mode", "filename"], ["fugitive"]],
        \"right": [["lineinfo"], ["fileinfo"]]},
        \"component_visible_condition": {
        \"fugitive": '(exists("*fugitive#head") && ""!=fugitive#head())'},
        \'component_function': {
        \'test': 'LLFunc',
        \'mode': 'LLMode',
        \'filename': 'LLFileName',
        \'fugitive': 'LLFugitive',
        \'fileinfo': 'LLFileInfo',
        \'lineinfo': 'LLLineInfo',
        \},
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
        \}
  let g:lightline.inactive = g:lightline.active

  function! LLMode()
    let ps = ''
    if &paste
      let ps = " P"
    endif
    return lightline#mode() . ps
  endfunction

  function! LLFileName()
    let fn = expand("%:t")
    let ro = &ft !~? 'help' && &readonly ? " RO" : ""
    let mo = &modifiable && &modified ? " +" : ""
    return fn . ro . mo
  endfunction

  function! LLFugitive()
    let fu = exists('*fugitive#head') ? fugitive#head() : ''
    return winwidth('.') >=
          \  strlen(LLMode()) + 2
          \+ strlen(LLFileName()) + 2
          \+ strlen(fu) + 2
          \+ strlen(LLLineInfo()) + 2
          \? fu : ''
  endfunction

  function! LLFileInfo()
    let ff = &fileformat
    let fe = (strlen(&fenc) ? &fenc : &enc)
    let ft = (strlen(&filetype) ? &filetype : 'no')
    let fi = ff . " " . fe . " " . ft
    return winwidth('.') >=
          \  strlen(LLMode()) + 2
          \+ strlen(LLFileName()) + 2
          \+ strlen(LLFugitive())
          \+ ((exists("*fugitive#head") && ""!=fugitive#head()) ? 2 : 0)
          \+ strlen(fi) + 2
          \+ strlen(LLLineInfo()) + 2
          \? fi : ''
  endfunction

  function! LLLineInfo()
    let cl = line(".")
    let ll = line("$")
    let cc = col(".")
    let li = printf("%4d/%d:%3d", cl, ll, cc)
    return winwidth('.') >=
          \  strlen(LLFileName()) + 2
          \+ strlen(li) + 2
          \? li : ''
  endfunction
endif
"}}} lightline.vim

" vim-ref {{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-ref"))
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
  xnoremap [ref] <Nop>
  nmap <Leader>r [ref]
  xmap <Leader>r [ref]
  nnoremap [ref]j :Ref webdict je<Space>
  nnoremap [ref]e :Ref webdict ej<Space>
  nnoremap [ref]w :Ref webdict wiki<Space>
  nnoremap [ref]m :Ref man<Space>
  xnoremap [ref]j :<C-u>Ref webdict je <C-R><C-w><CR>
  xnoremap [ref]e :<C-u>Ref webdict ej <C-R><C-w><CR>
  xnoremap [ref]w :<C-u>Ref webdict wiki <C-R><C-w><CR>
endif
"}}}

" NERDTree+SrcExpl+tagbar {{{

" The NERD Tree  {{{
if s:neobundle_enabled && ! empty(neobundle#get("nerdtree"))
  nnoremap <Leader>N :NERDTreeToggle<CR>
endif
"}}}

" SrcExpl  {{{
if s:neobundle_enabled && ! empty(neobundle#get("SrcExpl"))
  " Set refresh time in ms
  let g:SrcExpl_RefreshTime = 1000
  " Is update tags when SrcExpl is opened
  let g:SrcExpl_isUpdateTags = 0
  " Tag update command
  let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase %'
  " Update all tags
  function! g:SrcExpl_UpdateAllTags()
    let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase -R .'
    call g:SrcExpl_UpdateTags()
    let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase %'
  endfunction
  " Source Explorer Window Height
  let g:SrcExpl_winHeight = 14
  " Mappings
  nnoremap [srce] <Nop>
  nmap <Leader>E [srce]
  nnoremap <silent> [srce]<CR> :SrcExplToggle<CR>
  nnoremap <silent> [srce]u :call g:SrcExpl_UpdateTags()<CR>
  nnoremap <silent> [srce]a :call g:SrcExpl_UpdateAllTags()<CR>
  nnoremap <silent> [srce]n :call g:SrcExpl_NextDef()<CR>
  nnoremap <silent> [srce]p :call g:SrcExpl_PrevDef()<CR>
endif
"}}}

" tagbar {{{
if s:neobundle_enabled && ! empty(neobundle#get("tagbar"))
  " Width (default 40)
  let g:tagbar_width = 20
  " Mappings
  nnoremap <silent> <leader>T :TagbarToggle<CR>
endif
"}}} tagbar

if s:neobundle_enabled &&
      \! empty(neobundle#get("nerdtree")) &&
      \! empty(neobundle#get("SrcExpl")) &&
      \! empty(neobundle#get("tagbar"))
  nnoremap <silent> <Leader>A :SrcExplToggle<CR>:NERDTreeToggle<CR>:TagbarToggle<CR>
endif

" }}}

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
if s:neobundle_enabled && ! empty(neobundle#get("gist-vim"))
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 1
  " Disable default Gist command
  cnoremap <silent> Gist<CR> echo 'use Gist -P to make a public gist'<CR>
endif
"}}} gist-vim

" previm {{{
if s:neobundle_enabled && ! empty(neobundle#get("previm"))
  if ( has("win32unix") || has ("win64unix"))
    " cygwin
    let g:previm_open_cmd = "cygstart"
  elseif ( has("mac") || has ("gui_macvim"))
    " mac
    let g:previm_open_cmd = "open"
  endif
endif

"}}} previm

" switch {{{
if s:neobundle_enabled && ! empty(neobundle#get("switch.vim"))
  nnoremap - :Switch<cr>
endif
"}}} switch

" linediff {{{
if s:neobundle_enabled && ! empty(neobundle#get("linediff.vim"))
  let g:linediff_first_buffer_command  = 'leftabove new'
  let g:linediff_second_buffer_command = 'rightbelow vertical new'
endif
"}}} linediff

" vim-expand-region {{{
if s:neobundle_enabled && ! empty(neobundle#get("vim-expand-region"))
  let g:expand_region_text_objects = {
        \ 'iw'  :0,
        \ 'iW'  :0,
        \ 'i"'  :0,
        \ 'i''' :0,
        \ 'i]'  :1,
        \ 'ib'  :1,
        \ 'iB'  :1,
        \ 'il'  :0,
        \ 'ip'  :0,
        \ 'ie'  :0,
        \ }
  if ! empty(neobundle#get("vim-submode"))
    call submode#enter_with('expand-region', 'nv', 'r', '<Leader>e', '<Plug>(expand_region_expand)')
    call submode#map('expand-region', 'nv', 'r', 'e', '<Plug>(expand_region_expand)')
    call submode#map('expand-region', 'nv', 'r', 'w', '<Plug>(expand_region_shrink)')
  endif
endif
"}}} switch

" vim-quickhl {{{
"if s:neobundle_enabled && ! empty(neobundle#get("vim-quickhl"))
"  nmap <Space>m <Plug>(quickhl-manual-this)
"  xmap <Space>m <Plug>(quickhl-manual-this)
"  nmap <Space>M <Plug>(quickhl-manual-reset)
"  xmap <Space>M <Plug>(quickhl-manual-reset)
"
"  nmap <Space>j <Plug>(quickhl-cword-toggle)
"  nmap <Space>] <Plug>(quickhl-tag-toggle)
"  map H <Plug>(operator-quickhl-manual-this-motion)
"endif
"}}} switch

" calendar.vim {{{
if s:neobundle_enabled && ! empty(neobundle#get("calendar.vim"))
  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1
  let g:calendar_first_day = "sunday"
  let g:calendar_frame = 'default'
endif
"}}} calendar.vim

" rabbit-ui.vim {{{
if s:neobundle_enabled && ! empty(neobundle#get("rabbit-ui.vim"))
  function! s:edit_csv(path)
    call writefile(map(rabbit_ui#gridview(
          \ map(readfile(expand(a:path)),'split(v:val,",",1)')),
          \ "join(v:val, ',')"), expand(a:path))
  endfunction
  command! -nargs=1 -complete=file EditCSV  :call <sid>edit_csv(<q-args>)
endif
"}}} rabbit-ui.vim

" diffhar {{{
if s:neobundle_enabled && ! empty(neobundle#get("diffchar.vim"))
  function! SetDiffChar()
    if &diff
      execute "%SDChar"
    endif
  endfunction
  " It doesn't work well for complicated files...
  "autocmd MyAutoGroup VimEnter,FilterWritePre * call SetDiffChar()
endif
"}}} diffchar

" rogue {{{
if s:neobundle_enabled && ! empty(neobundle#get("rogue.vim"))
  let g:rogue#name = "aaa"
  let g:rogue#directory = g:vimdir . "/rogue"
  let g:rogue#japanese = 1
endif
"}}} rogue

" local settings {{{
if filereadable(expand("~/.vimrc.local"))
  execute "source" expand("~/.vimrc.local")
endif

if filereadable(expand("./.vimrc.dir"))
  execute "source" expand("./.vimrc.dir")
endif
" }}}

" neobundle on_source {{{
if !has("vim_starting")
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook("on_source")
endif
" }}}

" Vim Power {{{
" http://vim-jp.org/vim-users-jp/2009/07/10/Hack-39.html
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
      \        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
      \        echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)
" }}}

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
