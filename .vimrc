" vimrc

" Flags {{{
let s:use_dein = 0
if filereadable(expand("~/.vim_dein"))
  let s:git = system("which git")
  if strlen(s:git) == 0
    let s:use_dein = 0
  else
    let s:use_dein = 1
  endif
endif
" }}}

" Prepare .vim dir {{{
let s:vimdir = $HOME . '/.vim'
if has('vim_starting')
  if ! isdirectory(s:vimdir)
    call system('mkdir ' . s:vimdir)
  endif
endif
" }}}

" dein {{{
let s:dein_enabled  = 0
if s:use_dein && v:version >= 704
  let s:dein_enabled = 1

  " Set dein paths
  let s:dein_dir = s:vimdir . '/dein'
  let s:dein_github = s:dein_dir . '/repos/github.com'
  let s:dein_repo_name = 'Shougo/dein.vim'
  let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

  " Check dein has been installed or not.
  if !isdirectory(s:dein_repo_dir)
    echo 'dein is not installed, install now '
    let s:dein_repo = 'https://github.com/' . s:dein_repo_name
    echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
    call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
  endif
  let &runtimepath = &runtimepath . ',' . s:dein_repo_dir

  " Begin plugin part {{{

  " Check cache
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " dein
    call dein#add('Shougo/dein.vim')

    " Basic tools {{{
    " Asynchronous execution library: need for vimshell, Gmail, unite, etc...
    call dein#add('Shougo/vimproc', {'build': 'make'})

    " Support repeat for surround, speedating, easymotion, etc...
    call dein#add('tpope/vim-repeat')

    " Sub mode
    call dein#add('kana/vim-submode')

    " webapi
    call dein#add('mattn/webapi-vim')
    " }}}

    " Unite {{{
    " Search and display information from arbitrary sources
    call dein#add('Shougo/unite.vim', {
          \ 'depends': ['vimproc'],
          \ 'on_cmd': ['Unite'],
          \ 'lazy': 1})

    " Source for unite: mru
    call dein#add('Shougo/neomru.vim', {'depdens': ['unite.vim']})

    " Source for unite: mark
    call dein#add('tacroe/unite-mark', {'depdens': ['unite.vim']})

    " Source for unite: help
    call dein#add('tsukkee/unite-help', {'depdens': ['unite.vim']})

    " Source for unite: history/command, history/search
    call dein#add('thinca/vim-unite-history', {'depdens': ['unite.vim']})

    " Source for unite: history/yank
    call dein#add('Shougo/neoyank.vim', {'depdens': ['unite.vim']})

    " Source for unite: tag
    call dein#add('tsukkee/unite-tag', {'depdens': ['unite.vim']})

    " Source for unite: outline
    call dein#add('Shougo/unite-outline', {'depdens': ['unite.vim']})
    " }}}

    " Completion {{{
    if has('lua')
      call dein#add('Shougo/neocomplete.vim', {
            \ 'on_i': 1,
            \ 'lazy': 1})
      call dein#add('ujihisa/neco-look', {
            \ 'depends': ['neocomplete.vim']})
    endif
    " }}}

    " Snippet {{{
    call dein#add('Shougo/neosnippet')
    "      \ 'on_map': ['<Plug>(neosnippet_expand_or_jump)',
    "      \            '<Plug>(neosnippet_expand_target)'],
    "      \ 'lazy': 1})
    call dein#add('Shougo/neosnippet-snippets', {'depdens': ['neosnippet']})
    call dein#add('honza/vim-snippets', {'depdens': ['neosnippet']})
    call dein#add('rcmdnk/vim-octopress-snippets', {'depdens': ['neosnippet']})
    " }}}

    " Code syntax, tools for each language {{{

    " Applescript
    call dein#add('vim-scripts/applescript.vim')

    " Automatic LaTeX Plugins
    "call dein#add('coot/atp_vim')

    " CSS3 (Sass)
    call dein#add('hail2u/vim-css3-syntax.git')

    " c++ {{{
    " syntax with c++11 support
    call dein#add('vim-jp/cpp-vim')
    " c++ completion
    call dein#add('osyo-manga/vim-marching')
    " c++ formatting
    call dein#add('rhysd/vim-clang-format')
    " }}}

    " Go
    " Extra plugins for Go
    call dein#add('vim-jp/vim-go-extra')

    " Java
    call dein#add('koron/java-helper-vim')

    " Markdown {{{
    call dein#add('junegunn/vader.vim')
    call dein#add('godlygeek/tabular')
    call dein#add('joker1007/vim-markdown-quote-syntax')
    call dein#add('rcmdnk/vim-markdown')
    "call dein#add('plasticboy/vim-markdown')
    " }}}

    " Python {{{
    " indent
    call dein#add('hynek/vim-python-pep8-indent')
    " Folding method for python, but makes completion too slow...?
    call dein#add('vim-scripts/python_fold')
    " }}}

    " Powershell
    call dein#add('PProvost/vim-ps1')

    " Homebrew
    call dein#add('xu-cheng/brew.vim')

    " LaTex
    call dein#add('lervag/vimtex')

    " Vim Syntax
    call dein#add('dbakker/vim-lint')

    " Vimperator
    call dein#add('vimperator/vimperator.vim')

    " Syntax checking
    call dein#add('vim-syntastic/syntastic')
    "call dein#add('neomake/neomake')
    "call dein#add('benjie/neomake-local-eslint.vim')
    " }}}

    " View {{{
    " Status line
    call dein#add('itchyny/lightline.vim')

    " Visual indent guides: make moving slow?
    call dein#add('nathanaelkane/vim-indent-guides')

    " Konfekt/FastFold
    call dein#add('Konfekt/FastFold')

    " replacement of matchparen (require OptionSet sutocommand event)
    if (v:version == 704 && has('patch786')) || v:version >= 705
      call dein#add('itchyny/vim-parenmatch')
    endif

    " Diff {{{
    " linediff
    call dein#add('AndrewRadev/linediff.vim', {
          \ 'on_cmd': ['Linediff'],
          \ 'lazy': 1})

    " Character base diff
    "call dein#add('rickhowe/diffchar.vim')

    " diff enhanced
    "if v:version >= 800
    "  call dein#add('chrisbra/vim-diff-enhanced')
    "endif
    " }}} Diff

    " IDE like {{{
    " The NERD Tree: File Explorer
    call dein#add('scrooloose/nerdtree', {
          \ 'on_cmd': ['NERDTreeToggle'],
          \ 'lazy': 1})

    " Source Explorer
    call dein#add('wesleyche/SrcExpl', {
          \ 'on_cmd': ['SrcExplToggle'],
          \ 'lazy': 1})

    " For Tags
    call dein#add('majutsushi/tagbar', {
          \ 'on_cmd': ['TagbarToggle'],
          \ 'lazy': 1})
    " }}} IDE like
    " }}} View

    " Version Control System {{{
    " Git
    call dein#add('tpope/vim-fugitive')
    call dein#add('gregsexton/gitv', {
          \ 'depdens': ['tpope/vim-fugitive'],
          \ 'on_cmd': ['Gitv'],
          \ 'lazy': 1})

    " Version control (especially for VCSVimDiff (<Leader>cv)
    call dein#add('vim-scripts/vcscommand.vim', {
          \ 'on_cmd': ['VCSVimDiff'],
          \ 'lazy': 1})

    " Gist
    call dein#add('mattn/gist-vim', {
          \ 'depdens': ['mattn/webapi-vim'],
          \ 'on_cmd': ['Gist'],
          \ 'lazy': 1})
    " }}} Version Control System

    " Selection {{{
    " wildfire
    "call dein#add('gcmt/wildfire.vim')

    " Highlight on the fly
    call dein#add('t9md/vim-quickhl')
    " }}} Selection

    " Search {{{
    " Count searching objects
    call dein#add('osyo-manga/vim-anzu')

    " Improved incremental searching (default incsearch shows only the next one.)
    call dein#add('haya14busa/incsearch.vim')
    " }}} Search

    " Edit {{{
    " textobj {{{
    call dein#add('kana/vim-textobj-user')
    " line: al, il
    call dein#add('kana/vim-textobj-line', {'depends': ['vim-textobj-user']})
    " line: ai, ii
    call dein#add('kana/vim-textobj-indent', {'depends': ['vim-textobj-user']})
    " function: af, if
    call dein#add('kana/vim-textobj-function', {'depends': ['vim-textobj-user']})
    " comment: ac, ic
    call dein#add('thinca/vim-textobj-comment', {'depends': ['vim-textobj-user']})
    " }}}

    " Operator {{{
    call dein#add('kana/vim-operator-user')
    call dein#add('kana/vim-operator-replace', {'depdens': ['vim-operator-user']})
    " }}}

    " Gundo
    call dein#add('sjl/gundo.vim', {
          \ 'on_cmd': ['GundoToggle'],
          \ 'lazy': 1})

    " Align
    call dein#add('h1mesuke/vim-alignta', {
          \ 'on_cmd': ['Alignta'],
          \ 'lazy': 1})

    " yank
    call dein#add('LeafCage/yankround.vim')

    " over
    call dein#add('osyo-manga/vim-over', {
          \ 'on_cmd': ['OverCommandLine'],
          \ 'lazy': 1})

    " vim-multiple-cursors, like Sublime Text's multiple selection
    "call dein#add('terryma/vim-multiple-cursors')

    " Easy to change surround
    call dein#add('tpope/vim-surround')

    " }}} Edit

    " Move {{{
    " Easymotion
    call dein#add('easymotion/vim-easymotion', {
          \ 'on_map': ['<Plug>(easymotion-sn)', '<Plug>(easymotion-bd-W)',
          \            '<Plug>(easymotion-bd-w)'],
          \ 'lazy': 1})

    " }}} Move

    " Check language, web source {{{
    " vim-ref
    call dein#add('thinca/vim-ref', {
          \ 'on_cmd': ['Ref'],
          \ 'lazy': 1})

    " Grammer check with LanguageTool
    call dein#add('rhysd/vim-grammarous', {
          \ 'on_cmd': ['GrammarousCheck'],
          \ 'lazy': 1})

    " Google Translate
    call dein#add('daisuzu/translategoogle.vim', {
          \ 'on_cmd': ['TranslateGoogle', 'TranslateGoogleCmd'],
          \ 'lazy': 1})
    " }}}

    " Other tools {{{
    " Make benchmark result of vimrc
    call dein#add('mattn/benchvimrc-vim', {
          \ 'on_cmd': ['BenchVimrc'],
          \ 'lazy': 1})

    " Open browser
    call dein#add('tyru/open-browser.vim', {
          \ 'on_map': ['<Plug>(openbrowser-smart-search)'],
          \ 'lazy': 1})

    " Database access
    call dein#add('vim-scripts/dbext.vim')

    " Plugin template
    call dein#add('mopp/layoutplugin.vim', {
          \ 'on_cmd': ['LayoutPlugin'],})

    " }}}

    " Fun {{{
    " }}}

    call dein#end()

    call dein#save_state()
  endif

  " }}} dein end

  " Installation check.
  if dein#check_install()
    call dein#install()
  endif
endif
" }}} dein

" Basic settings {{{

" Reset my auto group
augroup MyAutoGroup
  autocmd!
augroup END

" Enable plugin, indent again
filetype plugin indent on

" Switch syntax highlighting on, when the terminal has colors
syntax on

" Encode
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin

" need for two-byte characters in this script, need to be after set encodeing
"scriptencoding utf-8
""scriptencoding cp932

" Switch on highlighting the last used search pattern.
set hlsearch

" allow backspacing over everything in insert mode
" indent: spaces of the top of the line
" eol   : break
" start : character before the starting point of the insert mode
set backspace=indent,eol,start

set foldmethod=marker
set foldmarker={{{,}}}

set modeline       " enable to use settings written in the file
" use with comment lines: e.g.)
set modelines=3    " number of lines to be read (form top and bottom) for
" modeline
set tabstop=2      " width of <Tab> in view
set shiftwidth=2   " width for indent
set softtabstop=0  " disable softtabstop function
set autoindent     " autoindent
set cinoptions=g0  " g0: no indent for private/public/protected

"set textwidth=0    " a longer line than textwidth will be broken (0: disable)
autocmd MyAutoGroup FileType *  setlocal textwidth=0 " overwrite ftplugin settings
if exists ('&colorcolumn')
  set colorcolumn=80 " put line on 80
  "set colorcolumn=+1 " put line on textwidth+1
  " Change background for 80-end of the line
  "execute 'set colorcolumn=' . join(range(80, 999), ',')
endif
set wrap           " longer line is wrapped
set display=lastline " Show all even if there is many characters in one line.
"set linebreak      " wrap at 'breakat'
set nolinebreak
"set breakat=\ ^I!@*-+;:,./?()[]{}<>'"`     " break point for linebreak
set breakat=
"set showbreak=+\   " set showbreak
set showbreak=
"if (v:version == 704 && has('patch338')) || v:version >= 705
"  set breakindent    " indent even for wrapped lines
"  " breakindent option (autocmd is necessary when new file is opened in Vim)
"  " necessary even for default(min:20,shift:0)
"  autocmd MyAutoGroup BufEnter * set breakindentopt=min:20,shift:0
"endif

set expandtab      " do :retab -> tab->space

set swapfile       " use swap file
set nobackup       " do not keep a backup file
set nowritebackup  " do not create backup file

" Add Mac's temporary space
let &backupskip='/private/tmp/*,' . &backupskip

let s:defdir=&directory
let s:defbackup=&backupdir
if ! empty($TMP) && isdirectory($TMP)
  let s:tmpdir=$TMP
elseif ! empty($TMPDIR) && isdirectory($TMPDIR)
  let s:tmpdir=$TMPDIR
elseif ! empty($TEMP) && isdirectory($TEMP)
  let s:tmpdir=$TEMP
else
  let s:tmpdir='./'
endif
let &directory=s:tmpdir . ',' . s:defdir " directory for swap file
let &backupdir=s:tmpdir . ',' . s:defdir " directory for backup file

if has('win32') || has ('win64')
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
"set cursorcolumn   " Enable highlight on current column:
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
set splitright     " New window is right

set spell          " Spell check highlight
"set nospell        " No spell check

if (v:version == 704 && has('patch88')) || v:version >= 705
  set spelllang+=cjk " Ignore double-width characters
endif

" bash-like tab completion
set wildmode=list:longest
set wildmenu

" Folding
set foldnestmax=1
set foldlevel=100 "open at first

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

" For shell script (sh.vim), don't append '.' to iskeyword
let g:sh_noisk=1

" Set nopaste when it comes back to Normal mode
autocmd MyAutoGroup InsertLeave * setlocal nopaste

" VimShowHlGroup: Show highlight group name under a cursor
command! VimShowHlGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
" VimShowHlItem: Show highlight item name under a cursor
command! VimShowHlItem echo synIDattr(synID(line('.'), col('.'), 1), 'name')

function! s:get_syn_id(transparent)
  let synid = synID(line('.'), col('.'), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, 'name')
  let ctermfg = synIDattr(a:synid, 'fg', 'cterm')
  let ctermbg = synIDattr(a:synid, 'bg', 'cterm')
  let guifg = synIDattr(a:synid, 'fg', 'gui')
  let guibg = synIDattr(a:synid, 'bg', 'gui')
  return {
        \ 'name': name,
        \ 'ctermfg': ctermfg,
        \ 'ctermbg': ctermbg,
        \ 'guifg': guifg,
        \ 'guibg': guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo 'name: ' . baseSyn.name .
        \ ' ctermfg: ' . baseSyn.ctermfg .
        \ ' ctermbg: ' . baseSyn.ctermbg .
        \ ' guifg: ' . baseSyn.guifg .
        \ ' guibg: ' . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo 'link to'
  echo 'name: ' . linkedSyn.name .
        \ ' ctermfg: ' . linkedSyn.ctermfg .
        \ ' ctermbg: ' . linkedSyn.ctermbg .
        \ ' guifg: ' . linkedSyn.guifg .
        \ ' guibg: ' . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

" Max columns for syntax search
" Such XML file has too much syntax which make vim drastically slow
set synmaxcol=1000 "default 3000

" Load Man command even for other file types than man.
runtime ftplugin/man.vim

" No automatic break at the end of the file
if (v:version == 704 && has('patch785')) || v:version >= 705
  set nofixendofline
endif

" status line
set laststatus=2 " always show
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
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
let g:mapleader = ','
" use \, as , instead
noremap <Subleader> <Nop>
map <Space> <Subleader>
noremap <Subleader>, ,

" fix meta-keys
"map <ESC>p <M-p>
"map <ESC>n <M-n>

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
" Down (C-j default: <NL> ~ j)
"nnoremap <C-j> j
"nnoremap <RETURN> j
" Up (C-k default: Non)
nnoremap <C-k> k
" Right (C-l default: Clear and redraw the screen)
nnoremap <C-l> l
" Go to Head (C-a default: Increment)-><C-a> can't be used with vim-speeddating
"nnoremap <C-a> 0
nnoremap <M-h> 0
nnoremap <D-h> 0
nnoremap <Subleader>h 0
"nnoremap H 0
" Go to End (C-e default: Scroll down)
"nnoremap <C-e> $
nnoremap <M-l> $
nnoremap <D-l> $
nnoremap <Subleader>l $
nnoremap L $
" Go to top
nnoremap <M-k> gg
nnoremap <D-k> gg
nnoremap <Subleader>k gg
" Go to bottom
nnoremap <M-j> G
nnoremap <D-j> G
nnoremap <Subleader>j G
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
nnoremap <A-w> :w<CR>
nnoremap <A-q> :q!<CR>
nnoremap <A-z> :ZZ<CR>
" don't enter Ex mode: map to quit
nnoremap Q :q<CR>
" Use other one characters
nnoremap Z ZZ
nnoremap W :w<CR>
nnoremap ! :q!<CR>

" Close/Close & Save buffer
nnoremap <Leader>q :bdelete<CR>
nnoremap <Leader>w :w<CR>:bdelete<CR>

" Fix Y
nnoremap Y y$

" Paste, Paste mode
nnoremap <silent> <Leader>p "+gP
nnoremap <silent> <Leader>P :setlocal paste!<CR>:setlocal paste?<CR>
inoremap <silent> <C-]> <C-o>:setlocal paste!<CR>

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

" Avoid to paste/insert in non-editing place
if has('virtualedit') && &virtualedit =~# '\<all\>'
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

" Increment a number and keep visual mode
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

""" command line mode
" Cursor move
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <C-b>

" Write as root
cnoremap w!! w !sudo tee > /dev/null %
" }}} map

" Colors {{{

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
    if v:version >= 702
      autocmd VimEnter,WinEnter * let w:m_sp = matchadd('MySpecialKey', '\(\t\| \+$\)')
    else
      autocmd VimEnter,WinEnter * match MySpecialKey '\(\t\| \+$\)'
    end
  endif

  " colors for completion
  autocmd ColorScheme * hi Pmenu ctermbg=255 ctermfg=0 guifg=#000000 guibg=#999999
  autocmd ColorScheme * hi PmenuSel ctermbg=blue ctermfg=black
  autocmd ColorScheme * hi PmenuSbar ctermbg=0 ctermfg=9
  autocmd ColorScheme * hi PmenuSbar ctermbg=255 ctermfg=0 guifg=#000000 guibg=#FFFFFF

  " colors for diff mode
  autocmd ColorScheme * hi DiffAdd cterm=bold ctermbg=17 gui=bold guibg=slateblue
  autocmd ColorScheme * hi DiffChange ctermbg=22 guibg=darkgreen
  autocmd ColorScheme * hi DiffText cterm=bold ctermbg=52 gui=bold guibg=olivedrab
  autocmd ColorScheme * hi DiffDelete ctermbg=6 guibg=coral

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
  if v:version >= 702
    autocmd VimEnter,WinEnter * let w:m_tbs = matchadd('TwoByteSpace', '　')
  else
    autocmd VimEnter,WinEnter * 2match TwoByteSpace '　'
  end
augroup END

colorscheme ron
" }}} colorscheme

" diff mode {{{
function! SetDiffMode()
  if &diff
    setlocal nospell
    setlocal wrap
  endif
endfunction
autocmd MyAutoGroup VimEnter,FilterWritePre * call SetDiffMode()

set diffopt=filler,vertical

" Automatic diffoff
autocmd MyAutoGroup WinEnter * if(winnr('$') == 1) && (getbufvar(winbufnr(0), '&diff')) == 1 | diffoff | endif

" }}} diff mode

" DiffOrig {{{
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(':DiffOrig')
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
"nnoremap u g-
"nnoremap <C-r> g+
" }}} undo

" yank share with wviminfo/rviminfo {{{
"
" yankshare prefix
noremap [yshare] <Nop>
map s [yshare]

let g:yankshare_file = expand('~/.vim/yankshare.txt')
if !exists('g:yankshare_file')
  let g:yankshare_file = '/tmp/yankshare.txt'
endif


function! YSStore() range
  call writefile([getreg('s')], g:yankshare_file, 'b')
endfunction

function! YSLoad() range
  call setreg('s', readfile(g:yankshare_file, 'b')[0])
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

" matchparen,matchpair, matchit {{{
" Don't load matchparen (highlight parens actively, make slow)
" vim-parenmatch fills in it.
let loaded_matchparen = 1
"matchpairs, default: (:),{:},[:]
set matchpairs+=<:>
autocmd MyAutoGroup FileType c,cpp,java set matchpairs+==:;
source $VIMRUNTIME/macros/matchit.vim
function! s:set_matchit()
  "let b:match_words = b:match_words . ',{%.*%}:{% *end.*%}'
  let b:match_ignorecase = 1
endfunction
autocmd MyAutoGroup BufEnter * call s:set_matchit()
" }}} matchpair, matchit

" paste at normal mode {{{

" if not well work... (though it seems working)
" need more understanding of vim/screen pasting...
" can use :a! for temporally paste mode
" or :set paste ,....., :set nopaste
" or set noautoindent, ...., : set autoindent

" it seems working in Mac, but not in Windows (putty+XWin)

" This setting change ttimeoutlen behavior:
" timeoutlen (for mapping delay) is used even for ESC + X key code delay,
" because it map <ESC> + [200~

"if &term =~? 'screen' || &term =~? 'xterm'
"  if &term =~? 'screen'
"    let &t_SI = &t_SI . "\eP\e[?2004h\e\\"
"    let &t_EI = "\eP\e[?2004l\e\\" . &t_EI
"    let &pastetoggle = "\e[201~"
"  else
"    let &t_SI .= &t_SI . "\e[?2004h"
"    let &t_EI .= "\e[?2004l" . &t_EI
"    let &pastetoggle = "\e[201~"
"  endif
"  function! XTermPasteBegin(ret)
"    set paste
"    return a:ret
"  endfunction
"  imap <special> <expr> <Esc>[200~ XTermPasteBegin(""'
"endif
" }}} paste

" tag {{{
if has('path_extra')
  set tags+=tags;
endif
"}}} tag

" cscope {{{
if has('cscope')
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable('cscope.out')
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB !=# ''
    cs add $CSCOPE_DB
  endif
  set csverb
  set cscopequickfix=s-,c-,d-,i-,t-,e-
endif
" }}} cscope

" Remove trail spaces and align {{{
function! s:indent_all()
  normal! mxgg=G'x
  delmarks x
endfunction
command! IndentAll call s:indent_all()

function! s:delete_space()
  normal! mxG$
  let flags = 'w'
  while search(' $', flags) > 0
    let line = getline('.')
    call setline('.', substitute(getline('.'), ' \+$', '', ''))
    let flags = 'W'
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
  for i in  range(1, bufnr('$'))
    if buflisted(i)
      execute 'buffer' i
      AlignCode
      update
      bdelete
    endif
  endfor
  quit
endfunction
command! AlignAllBuf call s:align_all_buf()

"nnoremap <Leader><Subleader> :ret<CR>:IndentAll<CR>:DeleteSpace<CR>

" remove trail spaces for all
nnoremap <Leader><Space> :DeleteSpace<CR>

" remove trail spaces at selected region
xnoremap <Leader><Space> :s/<Space>\+$//g<CR>
" }}} Remove trail spaces and align

" Plugin settings {{{

" Basic tools {{{
" vim-submode{{{
if s:dein_enabled && dein#tap('vim-submode')
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
  call submode#map('winsize', 'n', '', '<C-l>', '<C-w>>')
  call submode#map('winsize', 'n', '', '<C-h>', '<C-w><')
  call submode#map('winsize', 'n', '', '<C-j>', '<C-w>-')
  call submode#map('winsize', 'n', '', '<C-k>', '<C-w>+')
  call submode#map('winsize', 'n', '', '=', '<C-w>=')
  call submode#map('winsize', 'n', '', '<C-=>', '<C-w>=')
endif
"}}} vim-submode
" }}}

" Unite {{{
if s:dein_enabled && dein#tap('unite.vim')
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
          \ unite#smart_map('x', '\<Plug>(unite_quick_match_choose_action)')
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

    " Runs 'split' action by <C-s>.
    imap <silent><buffer><expr> <C-s>     unite#do_action('split')
  endfunction
  autocmd MyAutoGroup FileType unite call s:unite_my_settings()
  " start with insert mode (can start narrow result in no time)
  let g:unite_enable_start_insert=1
  " window
  "let g:unite_enable_split_vertically=1
  let g:unite_split_rule='botright' " default topleft
  let g:unite_winheight=10          " default 20
  let g:unite_winwidth=60           " default 90
  let g:unite_data_directory=s:vimdir . '.cache/unite'

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
  " show lines of current file
  nnoremap <silent> [unite]l :Unite line<CR>
  " search (like ack.vim/ag.vim)
  nnoremap <silent> [unite]/ :Unite grep:.<CR>
  " show opened file history including current buffers
  if dein#tap('neomru.vim')
    nnoremap <silent> [unite]m :Unite file_mru<CR>
  else
    nnoremap <silent> [unite]m :UniteWithBufferDir -buffer-name=files buffer file_mru<CR>
  endif
  " mark
  if dein#tap('unite-mark')
    nnoremap <silent> [unite]M :Unite mark<CR>
  endif
  " history
  if dein#tap('unite-help')
    nnoremap <silent> [unite]h :Unite -start-insert help<CR>
  endif
  " history
  if dein#tap('vim-unite-history')
    nnoremap <silent> [unite]c :Unite history/command<CR>
    nnoremap <silent> [unite]S :Unite history/search<CR>
  endif
  " tag
  if dein#tap('unite-tag')
    nnoremap <silent> [unite]t :Unite tag<CR>
  endif
  " yank
  if dein#tap('neoyank.vim')
    nnoremap <silent> [unite]y :Unite history/yank<CR>
  elseif dein#tap('yankround.vim')
    nnoremap <silent> [unite]y :Unite yankround<CR>
  endif
  " snippet
  if dein#tap('neosnipet')
    nnoremap <silent> [unite]s :Unite neosnippet<CR>
  endif
endif
" }}} Unite

" neocomplete {{{
if s:dein_enabled && dein#tap('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#max_list = 20
  let g:neocomplete#min_keyword_length = 3
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#enable_auto_select = 0
  let g:neocomplete#lock_buffer_name_pattern = ''
  let g:neocomplete#enable_fuzzy_completion = 0
  " text mode is necessary for look
  " But it is not useful for code writing because it convert like:
  " NeoBundle to Neobundle.
  let g:neocomplete#text_mode_filetypes =
        \ {'hybrid': 1, 'text':1, 'help': 1, 'gitcommit': 1, 'gitrebase':1,
        \  'vcs-commit': 1, 'markdown':1, 'textile':1, 'creole':1, 'org':1,
        \  'rdoc':1, 'mediawiki':1, 'rst':1, 'asciidoc':1, 'prod':1,
        \  'plaintex':1, 'mkd': 1, 'html': 1,
        \  'vim':0, 'sh':0, 'javascript':0, 'perl':0}
  let g:neocomplete#same_filetypes = {}
  let g:neocomplete#same_filetypes._ = '_'
  "inoremap <expr> <TAB>  pumvisible() ? '\<C-n>' : '\<TAB>'
  inoremap <expr> <Tab> pumvisible() ? '\<C-n>' : neocomplete#start_manual_complete()
  "inoremap <expr> <A-y>  neocomplete#close_popup()
  "inoremap <expr> <A-e>  neocomplete#cancel_popup()
  "inoremap <expr> <A-l>  neocomplete#complete_common_string()
  "inoremap <expr> <A-u>  neocomplete#undo_completion()

  autocmd MyAutoGroup FileType python setlocal completeopt-=preview
endif
" }}}

" neosnippet {{{
if s:dein_enabled && dein#tap('neosnippet')
  imap <C-s> <Plug>(neosnippet_expand_or_jump)
  smap <C-s> <Plug>(neosnippet_expand_or_jump)
  xmap <C-s> <Plug>(neosnippet_expand_target)
  "xmap <C-o> <Plug>(neosnippet_register_oneshot_snippet)
  "imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  "smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  let g:neosnippet#enable_snipmate_compatibility = 1
  let g:neosnippet#disable_runtime_snippets = {'_' : 1}
  let g:neosnippet#snippets_directory = []
  if dein#tap('neosnippet-snippets')
    let g:neosnippet#snippets_directory += [expand(s:dein_github . '/Shougo/neosnippet-snippets/neosnippets')]
  endif
  if dein#tap('vim-snippets')
    let g:neosnippet#snippets_directory += [expand(s:dein_github . '/honza/vim-snippets/snippets')]
  endif
  if dein#tap('vim-octopress-snippets')
    let g:neosnippet#snippets_directory += [expand(s:dein_github . '/rcmdnk/vim-octopress-snippets/neosnippets')]
  endif
endif
" }}}

" Code syntax, tools for each language {{{
" applescript {{{
if s:dein_enabled && dein#tap('applescript.vim')
  autocmd MyAutoGroup BufNewFile,BufRead *.scpt,*.applescript :setlocal filetype=applescript
  "autocmd MyAutoGroup FileType applescript :inoremap <buffer> <S-CR>  ¬<CR>
endif
"}}} applescript

" vim-marching {{{
if s:dein_enabled && dein#tap('vim-marching')
  if dein#tap('neocomplete.vim')
    let g:marching_enable_neocomplete = 1
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  endif
endif
" }}} vim-marching

" vim-clang-format {{{
if s:dein_enabled && dein#tap('vim-clang-format')
  let g:clang_format#style_options = {
              \ 'AccessModifierOffset' : -4,
              \ 'AllowShortIfStatementsOnASingleLine' : 'true',
              \ 'AlwaysBreakTemplateDeclarations' : 'true',
              \ 'Standard' : 'C++11'}
  " map to <Leader>cf in C++ code
  autocmd MyAutoGroup FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
  autocmd MyAutoGroup FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
  " if you install vim-operator-user
  if dein#tap('vim-operator-user')
    autocmd MyAutoGroup FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
  endif
endif
" }}} vim-clang-format

" vim-markdown-quote-syntax {{{
if s:dein_enabled && dein#tap('vim-markdown-quote-syntax')
  let g:markdown_quote_syntax_on_filetypes = ['txt', 'text']
  let g:markdown_quote_syntax_filetypes = {
        \ 'css' : {
        \   'start' : 'css',
        \},
        \ 'scss' : {
        \   'start' : 'scss',
        \},
        \ 'markdown' : {
        \   'start' : 'markdown',
        \},
  \}
endif
" }}} vim-markdown-quote-syntax

" markdown {{{
if s:dein_enabled && dein#tap('vim-markdown')
  let g:vim_markdown_liquid=1
  let g:vim_markdown_frontmatter=1
  let g:vim_markdown_toml_frontmatter=1
  let g:vim_markdown_json_frontmatter=1
  let g:vim_markdown_math=1
  let g:vim_markdown_better_folding=1
  let g:vim_markdown_emphasis_multiline=0
  autocmd MyAutoGroup BufRead,BufNewFile *.{txt,text,html} setlocal filetype=markdown
  "autocmd MyAutoGroup BufRead,BufNewFile *.{txt,text} setlocal filetype=markdown
endif
" }}} vim-markdown

" syntastic {{{
if s:dein_enabled && dein#tap('syntastic')
  " Disable automatic check at file open/close
  let g:syntastic_check_on_open=0
  let g:syntastic_check_on_wq=0
  " C
  let g:syntastic_c_check_header = 1
  " C++
  let g:syntastic_cpp_check_header = 1
  " Java
  let g:syntastic_java_javac_config_file_enabled = 1
  let g:syntastic_java_javac_config_file = '$HOME/.syntastic_javac_config'
  " python
  let g:syntastic_python_checkers = ['flake8']
  " ruby
  let g:syntastic_ruby_checkers = ['rubocop']
  " args for shellcheck
  let g:syntastic_sh_shellcheck_args = "-e SC1090,SC2059,SC2155,SC2164"
endif
"}}} syntastic

" neomake {{{
if s:dein_enabled && dein#tap('neomake')
  autocmd MyAutoGroup BufWritePost * Neomake

  autocmd MyAutoGroup VimEnter,ColorScheme * hi NeomakeInfoSign term=bold ctermfg=0 ctermbg=6 gui=bold guifg=Blue guibg=coral
  autocmd MyAutoGroup VimEnter,ColorScheme * hi link NeomakeInfo NeomakeInfoSign
  autocmd MyAutoGroup VimEnter,ColorScheme * hi NeomakeWarningSign term=standout ctermfg=0 ctermbg=11 guifg=Black guibg=orange
  autocmd MyAutoGroup VimEnter,ColorScheme * hi link NeomakeWarning NeomakeWarningSign
  autocmd MyAutoGroup VimEnter,ColorScheme * hi NeomakeErrorSign term=reverse ctermfg=15 ctermbg=9 guifg=White guibg=Red
  autocmd MyAutoGroup VimEnter,ColorScheme * hi link NeomakeError NeomakeErrorSign

  let g:neomake_javascript_enabled_makers = ['eslint']

  let g:neomake_error_sign = {'text': 'e', 'texthl': 'NeomakeErrorSign'}
  let g:neomake_warning_sign = {
      \   'text': 'w',
      \   'texthl': 'NeomakeWarningSign',
      \ }
  let g:neomake_message_sign = {
       \   'text': 'm',
       \   'texthl': 'NeomakeMessageSign',
       \ }
  let g:neomake_info_sign = {'text': 'i', 'texthl': 'NeomakeInfoSign'}
endif
"}}} neomake

" }}} Code syntax, tools for each language

" View {{{
" lightline.vim {{{
if s:dein_enabled && dein#tap('lightline.vim')
  let g:lightline = {
        \'colorscheme': 'jellybeans',
        \'active': {
        \'left': [['test', 'mode', 'filename'], ['fugitive']],
        \'right': [['lineinfo'], ['fileinfo']]},
        \'component_visible_condition': {
        \'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'},
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
      let ps = ' P'
    endif
    return lightline#mode() . ps
  endfunction

  function! LLFileName()
    let fn = expand('%:t')
    let ro = &ft !~? 'help' && &readonly ? ' RO' : ''
    let mo = &modifiable && &modified ? ' +' : ''
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
    let fi = ff . ' ' . fe . ' ' . ft
    return winwidth('.') >=
          \  strlen(LLMode()) + 2
          \+ strlen(LLFileName()) + 2
          \+ strlen(LLFugitive())
          \+ ((exists('*fugitive#head') && ''!=#fugitive#head()) ? 2 : 0)
          \+ strlen(fi) + 2
          \+ strlen(LLLineInfo()) + 2
          \? fi : ''
  endfunction

  function! LLLineInfo()
    let cl = line('.')
    let ll = line('$')
    let cc = col('.')
    let li = printf('%4d/%d:%3d', cl, ll, cc)
    return winwidth('.') >=
          \  strlen(LLFileName()) + 2
          \+ strlen(li) + 2
          \? li : ''
  endfunction
endif
"}}} lightline.vim

" vim-indent-guides{{{
if s:dein_enabled && dein#tap('vim-indent-guides')
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 1
  let g:indent_guides_auto_colors = 0
  autocmd MyAutoGroup VimEnter,Colorscheme * hi IndentGuidesEven term=bold ctermfg=9 ctermbg=235
  autocmd MyAutoGroup VimEnter,Colorscheme * hi IndentGuidesOdd term=bold ctermfg=9 ctermbg=239
endif
"}}} vim-indent-guides

" linediff {{{
if s:dein_enabled && dein#tap('linediff.vim')
  let g:linediff_first_buffer_command  = 'leftabove new'
  let g:linediff_second_buffer_command = 'rightbelow vertical new'
endif
"}}} linediff

" vim-diff-enhanced {{{
if s:dein_enabled && dein#tap('vim-diff-enhanced')
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
"}}} vim-diff-enhanced

" NERDTree+SrcExpl+tagbar {{{

" The NERD Tree  {{{
if s:dein_enabled && dein#tap('nerdtree')
  nnoremap <Leader>N :NERDTreeToggle<CR>
endif
"}}}

" SrcExpl  {{{
if s:dein_enabled && dein#tap('SrcExpl')
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
if s:dein_enabled && dein#tap('tagbar')
  " Width (default 40)
  let g:tagbar_width = 20
  " Mappings
  nnoremap <silent> <leader>T :TagbarToggle<CR>
endif
"}}} tagbar

if s:dein_enabled && dein#tap('nerdtree') && dein#tap('SrcExpl') && dein#tap('tagbar')
  nnoremap <silent> <Leader>A :SrcExplToggle<CR>:NERDTreeToggle<CR>:TagbarToggle<CR>
endif
" }}}
" }}}

" Version Control System {{{
" vcscommand.vim {{{
  let VCSCommandDisableMappings = 1
  nnoremap <Leader>cv :VCSVimDiff<CR>
" }}}

" gist-vim {{{
if s:dein_enabled && dein#tap('gist-vim')
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 1
  " Disable default Gist command
  cnoremap <silent> Gist<CR> echo 'use Gist -P to make a public gist'<CR>
endif
" }}} gist-vim
" }}}

" Selection {{{
" wildfire {{{
if s:dein_enabled && dein#tap('wildfire.vim')
  "let g:wildfire_objects = {
  "      \ '*' : ['iw', "i'", "a'", 'i"', 'a"', 'i)', 'a)', 'i]', 'a]', 'i}', 'a}', 'i>', 'a>', 'ip', 'ap', 'it', 'at'],
  "      \ }
  let g:wildfire_objects = ['iw', "i'", "a'", 'i"', 'a"', 'i)', 'a)', 'i]', 'a]', 'i}', 'a}', 'i>', 'a>', 'ip', 'ap', 'it', 'at']

  " This selects the next closest text object.
  map <RETURN> <Plug>(wildfire-fuel)

  " This selects the previous closest text object.
  vmap <BS> <Plug>(wildfire-water)
endif
" }}}

" vim-quickhl {{{
if s:dein_enabled && dein#tap('vim-quickhl')
  nmap <Subleader>m <Plug>(quickhl-manual-this)
  xmap <Subleader>m <Plug>(quickhl-manual-this)
  nmap <Subleader>M <Plug>(quickhl-manual-reset)
  xmap <Subleader>M <Plug>(quickhl-manual-reset)

  nmap <Subleader>j <Plug>(quickhl-cword-toggle)
  nmap <Subleader>] <Plug>(quickhl-tag-toggle)
  "if dein#tap('vim-operator-user')
  "  map H <Plug>(operator-quickhl-manual-this-motion)
  "endif
endif
" }}} quickhl
" }}} Selection

" Search {{{
" vim-anzu {{{
if s:dein_enabled && dein#tap('vim-anzu')
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * g*<C-o><Plug>(anzu-update-search-status-with-echo)
  "nm g* g*<C-o><Plug>(anzu-update-search-status-with-echo)
  nmap # #<C-o><Plug>(anzu-update-search-status-with-echo)
  let g:airline#extensions#anzu#enabled=0
else
  " swap * and g*, and add <C-o> to stay on current word.
  nnoremap g* *<C-o>
  nnoremap * g*<C-o>
  nnoremap # #<C-o>
endif
" }}} vim-anzu

" incsearch {{{
if s:dein_enabled && dein#tap('incsearch.vim')
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  let g:incsearch#magic = '\v'
endif
" }}} incsearch
" }}} Search

" Edit {{{
" gundo {{{
if s:dein_enabled && dein#tap('gundo.vim')
  nnoremap U :GundoToggle<CR>
  let g:gundo_width = 30
  let g:gundo_preview_height = 15
  let g:gundo_auto_preview = 0 " Don't show preview by moving history. Use r to see differences
  let g:gundo_preview_bottom = 1 " Show preview at the bottom
endif
" }}} gundo

" Operator {{{
" vim-operator-replace{{{
if s:dein_enabled && dein#tap('vim-operator-replace')
  map _  <Plug>(operator-replace)
endif
" }}} vim-operator-replace
" }}} Operator

" yankround {{{
if s:dein_enabled && dein#tap('yankround.vim')
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
" }}} yankround

" vim-over {{{
if s:dein_enabled && dein#tap('vim-over')
  nnoremap <Leader>o :OverCommandLine<CR>%s/
  xnoremap <Leader>o :OverCommandLine<CR>s/
endif
" }}} vim-over

" vim-surround {{{
if s:dein_enabled && dein#tap('vim-surround')
  let g:surround_{char2nr('a')} = "**\r**"
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
" }}} Edit

" Move {{{
" vim-easymotion{{{
if s:dein_enabled && dein#tap('vim-easymotion')
  let g:EasyMotion_do_mapping=0
  let g:EasyMotion_grouping=1
  let g:EasyMotion_enter_jump_first=1
  let g:EasyMotion_space_jump_first=1
  let g:EasyMotion_smartcase=1
  let g:EasyMotion_use_upper=1
  let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvb'
  hi EasyMotionTarget ctermbg=none ctermfg=red
  hi EasyMotionShade  ctermbg=none ctermfg=blue

  map S <Plug>(easymotion-sn)
  map <Leader>f <Plug>(easymotion-bd-W)
  "nmap <Leader>f <Plug>(easymotion-overwin-w)
endif
" }}} vim-easymotion
" }}} Move

" Check language, web source {{{
" vim-ref {{{
if s:dein_enabled && dein#tap('vim-ref')
  " Set webdict sources
  let g:ref_source_webdict_sites = {
        \   'alc': {
        \     'url': 'http://eow.alc.co.jp/search?q=%s',
        \   },
        \   'je': {
        \     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
        \   },
        \   'ej': {
        \     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
        \   },
        \   'wikipedia': {
        \     'url': 'http://ja.wikipedia.org/wiki/%s',
        \   },
        \   'wikipedia_en': {
        \     'url': 'http://wikipedia.org/wiki/%s',
        \   },
        \ }

  "" Filter
  function! g:ref_source_webdict_sites.alc.filter(output)
    let l:arr = split(a:output, "\n")
    let l:start = 0
    let l:end = 0
    for l:i in range(len(l:arr))
      if l:arr[l:i] =~# '次へ'
        if l:start == 0
          let l:start = l:i + 2
        elseif l:end == 0
          let l:end = l:i - 1
          break
        endif
      endif
    endfor
    if l:start == 0
      return "No result found"
    endif
    return join(l:arr[l:start : l:end], "\n")
  endfunction
  function! g:ref_source_webdict_sites.je.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
  endfunction
  function! g:ref_source_webdict_sites.ej.filter(output)
    return join(split(a:output, "\n")[16 :], "\n")
  endfunction
  function! g:ref_source_webdict_sites.wikipedia.filter(output)
    return join(split(a:output, "\n")[17 :], "\n")
  endfunction
  function! g:ref_source_webdict_sites.wikipedia_en.filter(output)
    return join(split(a:output, "\n")[17 :], "\n")
  endfunction

  " vim-ref prefix
  nnoremap [ref] <Nop>
  xnoremap [ref] <Nop>
  nmap <Leader>r [ref]
  xmap <Leader>r [ref]
  nnoremap [ref]a :Ref webdict alc <Space>
  nnoremap [ref]j :Ref webdict je<Space>
  nnoremap [ref]e :Ref webdict ej<Space>
  nnoremap [ref]w :Ref webdict wikipedia<Space>
  nnoremap [ref]m :Ref man<Space>
  xnoremap [ref]a :<C-u>Ref webdict alc <C-R><C-w><CR>
  xnoremap [ref]j :<C-u>Ref webdict je <C-R><C-w><CR>
  xnoremap [ref]e :<C-u>Ref webdict ej <C-R><C-w><CR>
  xnoremap [ref]w :<C-u>Ref webdict wikipedia <C-R><C-w><CR>
  nnoremap <silent> <Leader>d :Ref webdict alc <C-R><C-w><CR>
endif
" }}} vim-ref

" translategoogle {{{
if s:dein_enabled && dein#tap('translategoogle.vim')
  let g:translategoogle_language = ['ja', 'en', 'fr']
  let g:translategoogle_default_sl = 'en'
  let g:translategoogle_default_tl = 'ja'
endif
" }}} translategoogle.vim
" }}} Check language, web source

" Other tools {{{
" open-browser{{{
if s:dein_enabled && dein#tap('open-browser.vim')
  let g:netrw_nogx = 1 " disable netrw's gx mapping.
  nmap gx <Plug>(openbrowser-smart-search)
  xmap gx <Plug>(openbrowser-smart-search)
endif
" }}} open-browser
" }}} Tools
" }}} Plugin settings

" OS specific settings {{{
if has('win32') || has('win64')

elseif has('mac')

elseif has('unix')

endif

" }}}

" local settings {{{
if filereadable(expand('~/.vimrc.local'))
  execute 'source' expand('~/.vimrc.local')
endif

if filereadable(expand('./.vimrc.dir'))
  execute 'source' expand('./.vimrc.dir')
endif
" }}}

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
