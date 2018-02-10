" vimrc

" For vim w/o +eval{{{
if 1
" }}}

" Flags {{{
let s:use_dein = 1
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
if v:version >= 704 && s:use_dein && !filereadable(expand('~/.vim_no_dein'))
  let s:git = system('which git')
  if strlen(s:git) != 0
    " Set dein paths
    let s:dein_dir = s:vimdir . '/dein'
    let s:dein_github = s:dein_dir . '/repos/github.com'
    let s:dein_repo_name = 'Shougo/dein.vim'
    let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

    " Check dein has been installed or not.
    if !isdirectory(s:dein_repo_dir)
      let s:is_clone = confirm('Prepare dein?', 'Yes\nNo', 2)
      if s:is_clone == 1
        let s:dein_enabled = 1
        echo 'dein is not installed, install now '
        let s:dein_repo = 'https://github.com/' . s:dein_repo_name
        echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
        call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
      endif
    else
      let s:dein_enabled = 1
    endif
  endif
endif

" Begin plugin part {{{
if s:dein_enabled
  let &runtimepath = &runtimepath . ',' . s:dein_repo_dir
  let g:dein#install_process_timeout =  600

  " Check cache
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " dein
    call dein#add('Shougo/dein.vim')

    " Basic tools {{{
    " Support repeat for surround, speedating, easymotion, etc...
    call dein#add('tpope/vim-repeat')

    " Sub mode
    call dein#add('kana/vim-submode')

    " webapi
    call dein#add('mattn/webapi-vim')

    " }}}

    " Completion {{{
"    if ((has('nvim')  || has('timers')) && has('python3')) && system('pip3 show neovim') !=# ''
"      call dein#add('Shougo/deoplete.nvim')
"      if !has('nvim')
"        call dein#add('roxma/nvim-yarp')
"        call dein#add('roxma/vim-hug-neovim-rpc')
"      endif
"      call dein#add('ujihisa/neco-look')
"      call dein#add('Shougo/neco-syntax')
"      call dein#add('Shougo/neco-vim')
"      "call dein#add('zchee/deoplete-clang')
"      "call dein#add('zchee/deoplete-go')
"      "call dein#add('zchee/deoplete-jedi')
"      "call dein#add('zchee/deoplete-zsh')
"    elseif has('lua')
"      call dein#add('Shougo/neocomplete.vim', {
"            \ 'on_i': 1,
"            \ 'lazy': 1})
"      call dein#add('ujihisa/neco-look')
"      call dein#add('Shougo/neco-syntax')
"      call dein#add('Shougo/neco-vim')
"    endif
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

    " Search/Display {{{
    " Search and display information from arbitrary sources
"    if has('python3')
"      call dein#add('Shougo/denite.nvim')
"      call dein#add('Shougo/neomru.vim')
"    else
"      call dein#add('Shougo/unite.vim', {
"            \ 'on_cmd': ['Unite'],
"            \ 'lazy': 1})
"      " Source for unite: mru
"      call dein#add('Shougo/neomru.vim', {'depdens': ['unite.vim']})
"
"      " Source for unite: mark
"      call dein#add('tacroe/unite-mark', {'depdens': ['unite.vim']})
"
"      " Source for unite: help
"      call dein#add('tsukkee/unite-help', {'depdens': ['unite.vim']})
"
"      " Source for unite: history/command, history/search
"      call dein#add('thinca/vim-unite-history', {'depdens': ['unite.vim']})
"
"      " Source for unite: history/yank
"      call dein#add('Shougo/neoyank.vim', {'depdens': ['unite.vim']})
"
"      " Source for unite: tag
"      call dein#add('tsukkee/unite-tag', {'depdens': ['unite.vim']})
"
"      " Source for unite: outline
"      call dein#add('Shougo/unite-outline', {'depdens': ['unite.vim']})
"    endif
    " }}}

    " Code syntax, tools for each language {{{

    " Applescript
    call dein#add('vim-scripts/applescript.vim')

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

    " Homebrew
    call dein#add('xu-cheng/brew.vim')

    " HTML
    call dein#add('othree/html5.vim')

    " Java
    call dein#add('koron/java-helper-vim')

    " JavaScript
    call dein#add('jelera/vim-javascript-syntax')

    " Markdown {{{
    call dein#add('junegunn/vader.vim')
    call dein#add('godlygeek/tabular')
    call dein#add('joker1007/vim-markdown-quote-syntax')
    call dein#add('rcmdnk/vim-markdown')
    " }}}

    " Python {{{
    " indent
    call dein#add('hynek/vim-python-pep8-indent')
    " Folding method for python, but makes completion too slow...?
    call dein#add('vim-scripts/python_fold')
    " }}}

    " Powershell
    call dein#add('PProvost/vim-ps1')

    " Ruby (rails, erb)
    call dein#add('vim-ruby/vim-ruby')
    call dein#add('tpope/vim-rails')

    " LaTex
    call dein#add('lervag/vimtex')

    " Vim Syntax Checker
    call dein#add('dbakker/vim-lint')

    " Vimperator
    call dein#add('vimperator/vimperator.vim')

    " Syntax checking
    if has('job') && has('channel') && has('timers')
      call dein#add('w0rp/ale')
    else
      call dein#add('vim-syntastic/syntastic')
    endif

    " comment
    call dein#add('tomtom/tcomment_vim')
    " }}}

    " View {{{
    " Color scheme
    call dein#add('rcmdnk/rcmdnk-color.vim')

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
    " Highlight on the fly
    call dein#add('t9md/vim-quickhl')
    " }}} Selection

    " Search {{{
    " Count searching objects
    call dein#add('osyo-manga/vim-anzu')

    " }}} Search

    " Edit {{{
    " textobj {{{
    call dein#add('kana/vim-textobj-user')
    " line: al, il
    call dein#add('kana/vim-textobj-line', {'depends': ['vim-textobj-user']})
    " indent: ai, ii
    call dein#add('kana/vim-textobj-indent', {'depends': ['vim-textobj-user']})
    " function: af, if
    call dein#add('kana/vim-textobj-function', {'depends': ['vim-textobj-user']})
    " comment: ac, ic
    call dein#add('thinca/vim-textobj-comment', {'depends': ['vim-textobj-user']})
    " erb object: viE, ciE, daE
    call dein#add('whatyouhide/vim-textobj-erb', {'depends': ['vim-textobj-user']})
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

    " vim-multiple-cursors, like Sublime Text's multiple selection
    call dein#add('terryma/vim-multiple-cursors')

    " Easy to change surround
    call dein#add('tpope/vim-surround')

    " if...end
    call dein#add('tpope/vim-endwise')

    " }}} Edit

    " Move {{{
    " }}} Move

    " Check language, web source {{{
    " vim-ref
    call dein#add('thinca/vim-ref', {
          \ 'on_cmd': ['Ref'],
          \ 'lazy': 1})

    " Grammar check with LanguageTool
    call dein#add('rhysd/vim-grammarous', {
          \ 'on_cmd': ['GrammarousCheck'],
          \ 'lazy': 1})

    " Google Translate
    call dein#add('daisuzu/translategoogle.vim', {
          \ 'on_cmd': ['TranslateGoogle', 'TranslateGoogleCmd'],
          \ 'lazy': 1})
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
set smarttab       " smart tab
set shiftwidth=2   " width for indent
set softtabstop=0  " disable softtabstop function
set autoindent     " autoindent
set smartindent    " do indent by checking previous line.
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
set backupskip+=/private/tmp/*

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
"
"if has('win32') || has ('win64')
"  let s:viminfo = 'viminfo_win'
"else
"  let s:viminfo = 'viminfo'
"endif
"let &viminfo = &viminfo . ',n' . s:vimdir . '/' . s:viminfo

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
set whichwrap=b,s,h,l " Move to next/prev line by h/l (Only b(Backspace) and s(Space) are default)

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
  let l:synid = synID(line('.'), col('.'), 1)
  if a:transparent
    return synIDtrans(l:synid)
  else
    return l:synid
  endif
endfunction

function! s:get_syn_attr(synid)
  let l:name = synIDattr(a:synid, 'name')
  let l:ctermfg = synIDattr(a:synid, 'fg', 'cterm')
  let l:ctermbg = synIDattr(a:synid, 'bg', 'cterm')
  let l:guifg = synIDattr(a:synid, 'fg', 'gui')
  let l:guibg = synIDattr(a:synid, 'bg', 'gui')
  return {
        \ 'name': l:name,
        \ 'ctermfg': l:ctermfg,
        \ 'ctermbg': l:ctermbg,
        \ 'guifg': l:guifg,
        \ 'guibg': l:guibg}
endfunction

function! s:get_syn_info()
  let l:baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo 'name: ' . l:baseSyn.name .
        \ ' ctermfg: ' . l:baseSyn.ctermfg .
        \ ' ctermbg: ' . l:baseSyn.ctermbg .
        \ ' guifg: ' . l:baseSyn.guifg .
        \ ' guibg: ' . l:baseSyn.guibg
  let l:linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo 'link to'
  echo 'name: ' . l:linkedSyn.name .
        \ ' ctermfg: ' . l:linkedSyn.ctermfg .
        \ ' ctermbg: ' . l:linkedSyn.ctermbg .
        \ ' guifg: ' . l:linkedSyn.guifg .
        \ ' guibg: ' . l:linkedSyn.guibg
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
" <C-l> == <FF> (formfeed)
" <C-j> == <NL> (next line)
" <C-m> == <CR> (return)
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
nnoremap <Subleader>, ,
xnoremap <Subleader>, ,

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
nnoremap <C-h> h
" Down (C-j default: <NL> ~ j)
nnoremap <C-j> j
nnoremap <RETURN> j
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

" Fix RETURN to C-j at win move (if C-j is mapped as RETURN at OS level)
nnoremap <C-w><RETURN> <C-w><C-j>

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

" Source vimrc
nnoremap <Leader>. :source $MYVIMRC<CR>

" Close immediately by q, set non-modifiable settings
autocmd MyAutoGroup FileType help,qf,man,ref nnoremap <silent> <buffer> q :q!<CR>
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
  let s:vimundodir=expand(s:vimdir . '/undo')
  let &undodir = s:vimundodir
  if ! isdirectory(s:vimundodir)
    call system('mkdir ' . s:vimundodir)
  endif
  set undofile
  set undoreload=1000
endif
set undolevels=1000
"nnoremap u g-
"nnoremap <C-r> g+
" }}} undo

" matchparen,matchpair, matchit {{{
" Don't load matchparen (highlight parens actively, make slow)
" vim-parenmatch fills in it.
let g:loaded_matchparen = 1
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
  set cscopetagorder=0
  set cscopetag
  set nocscopeverbose
  " add any database in current directory
  if filereadable('cscope.out')
    cs add cscope.out
    " else add database pointed to by environment
  elseif $CSCOPE_DB !=# ''
    cs add $CSCOPE_DB
  endif
  set cscopeverbose
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
  let l:flags = 'w'
  while search(' $', l:flags) > 0
    call setline('.', substitute(getline('.'), ' \+$', '', ''))
    let l:flags = 'W'
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
  for l:i in  range(1, bufnr('$'))
    if buflisted(l:i)
      execute 'buffer' l:i
      AlignCode
      update
      bdelete
    endif
  endfor
  quit
endfunction
command! AlignAllBuf call s:align_all_buf()

" remove trail spaces for all
nnoremap <Leader><Space> :DeleteSpace<CR>

" remove trail spaces at selected region
xnoremap <Leader><Space> :s/<Space>\+$//g<CR>
" }}} Remove trail spaces and align

" Plugin settings {{{

" Basic tools {{{
" vim-submode {{{
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
  call submode#map('winsize', 'n', '', '<RETURN>', '<C-w>-')
  call submode#map('winsize', 'n', '', '<C-k>', '<C-w>+')
  call submode#map('winsize', 'n', '', '=', '<C-w>=')
  call submode#map('winsize', 'n', '', '<C-=>', '<C-w>=')
endif
" }}} vim-submode
" }}} Basic tools

" Completion {{{
" deoplete.nvim {{{
if s:dein_enabled && dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
endif
" }}} deoplete.nvim

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
" }}} neocomplete
" }}} Completion

" Snippet
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
" }}} neosnippet
" }}} Snippet

" Search/Display {{{
" Denite {{{
if s:dein_enabled && dein#tap('denite.nvim')
  " Add custom menus
  let s:menus = {}
  let s:menus.file = {'description': 'File search (buffer, file, file_rec, file_mru'}
  let s:menus.line = {'description': 'Line search (change, grep, line, tag'}
  let s:menus.others = {'description': 'Others (command, command_history, help)'}
  let s:menus.file.command_candidates = [
        \ ['Buffers', 'Denite buffer'],
        \ ['Files in the current directory', 'Denite file'],
        \ ['Files, recursive list under the current directory', 'Denite file_rec'],
        \ ['Most recently used files', 'Denite file_mru']
        \ ]
  let s:menus.line.command_candidates = [
        \ ['Changes', 'Denite change'],
        \ ['grep', 'Denite grep'],
        \ ['Lines', 'Denite line'],
        \ ['Tags', 'Denite tag']
        \ ]
  let s:menus.others.command_candidates = [
        \ ['Commands', 'Denite command'],
        \ ['Command history', 'Denite command_history'],
        \ ['Helps', 'Denite help']
        \ ]

  call denite#custom#var('menu', 'menus', s:menus)

  nnoremap [denite] <Nop>
  nmap <Leader>u [denite]
  nnoremap <silent> [denite]b :Denite buffer<CR>
  nnoremap <silent> [denite]c :Denite changes<CR>
  nnoremap <silent> [denite]f :Denite file<CR>
  nnoremap <silent> [denite]g :Denite grep<CR>
  nnoremap <silent> [denite]h :Denite help<CR>
  nnoremap <silent> [denite]h :Denite help<CR>
  nnoremap <silent> [denite]l :Denite line<CR>
  nnoremap <silent> [denite]t :Denite tag<CR>
  nnoremap <silent> [denite]m :Denite file_mru<CR>
  nnoremap <silent> [denite]u :Denite menu<CR>

  call denite#custom#map(
        \ 'insert',
        \ '<Down>',
        \ '<denite:move_to_next_line>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<Up>',
        \ '<denite:move_to_previous_line>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<C-N>',
        \ '<denite:move_to_next_line>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<C-P>',
        \ '<denite:move_to_previous_line>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<C-G>',
        \ '<denite:assign_next_txt>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<C-T>',
        \ '<denite:assign_previous_line>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'normal',
        \ '/',
        \ '<denite:enter_mode:insert>',
        \ 'noremap'
        \)
  call denite#custom#map(
        \ 'insert',
        \ '<Esc>',
        \ '<denite:enter_mode:normal>',
        \ 'noremap'
        \)
" }}}
" Unite {{{
elseif s:dein_enabled && dein#tap('unite.vim')
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

    let l:unite = unite#get_current_unite()
    if l:unite.buffer_name =~# '^search'
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
  " help
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
" }}} Search/Display

" Code syntax, tools for each language {{{
" applescript {{{
if s:dein_enabled && dein#tap('applescript.vim')
  autocmd MyAutoGroup BufNewFile,BufRead *.scpt,*.applescript setlocal filetype=applescript
  "autocmd MyAutoGroup FileType applescript inoremap <buffer> <S-CR>  ¬<CR>
endif
"}}} applescript

" vim-marching {{{
if s:dein_enabled && dein#tap('vim-marching')
  if dein#tap('neocomplete.vim')
    let g:marching_enable_neocomplete = 1
    let g:neocomplete#force_omni_input_patterns =
        \ get(g:, 'neocomplete#force_omni_input_patterns', {})
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
        \   'start' : '\%(markdown\|md\)',
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
  let g:vim_markdown_folding_level=6
  let g:vim_markdown_emphasis_multiline=0
  autocmd MyAutoGroup BufRead,BufNewFile *.{txt,text,html} setlocal filetype=markdown
endif
" }}} vim-markdown

" ale/syntastic {{{
if s:dein_enabled && dein#tap('ale')
  let g:ale_sign_column_always = 0
  let g:ale_lint_on_enter = 0
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_text_changed = 'normal'

  nmap <silent> <Subleader>p <Plug>(ale_previous)
  nmap <silent> <Subleader>n <Plug>(ale_next)
  nmap <silent> <Subleader>a <Plug>(ale_toggle)

  function! s:ale_list()
    let g:ale_open_list = 1
    call ale#Queue(0, 'lint_file')
  endfunction
  command! ALEList call s:ale_list()
  nnoremap <Subleader>m  :ALEList<CR>
  autocmd MyAutoGroup FileType qf nnoremap <silent> <buffer> q :let g:ale_open_list = 0<CR>:q!<CR>
  autocmd MyAutoGroup FileType help,qf,man,ref,markdown let b:ale_enabled = 0

  if dein#tap('lightline.vim')
    autocmd MyAutoGroup User ALELint call lightline#update()
  endif

  let g:ale_sh_shellcheck_options = '-e SC1090,SC2059,SC2155,SC2164'
elseif s:dein_enabled && dein#tap('syntastic')
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
  let g:syntastic_sh_shellcheck_args = '-e SC1090,SC2059,SC2155,SC2164'
endif
" }}}

" tomtom/tcomment_vim {{{
" if s:dein_enabled && dein#tap('tcomment_vim')
  let g:tcommentOptions = {'whitespace': 'no'}
" endif
" }}}

" }}} Code syntax, tools for each language

" View {{{

" rcmdnk-color.vim {{{
if s:dein_enabled && dein#tap('rcmdnk-color.vim')
  colorscheme rcmdnk
endif
" }}}

" lightline.vim {{{
if s:dein_enabled && dein#tap('lightline.vim')
  let g:lightline = {
        \'colorscheme': 'jellybeans',
        \'active': {
              \'left': [['prepare', 'mode'], ['filename', 'fugitive']],
              \'right': [['lineinfo'], ['fileinfo'], ['ale']]},
        \'component_visible_condition': {
              \'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'},
        \'component_function': {
              \'prepare': 'LLPrepare',
              \'mode': 'LLMode',
              \'filename': 'LLFileName',
              \'fugitive': 'LLFugitive',
              \'fileinfo': 'LLFileInfo',
              \'lineinfo': 'LLLineInfo',
              \'ale': 'LLAle',
              \},
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' }
        \}
  let g:lightline.inactive = g:lightline.active

  function! LLPrepare()
    let g:ll_mode = ''
    let g:ll_filename = ''
    let g:ll_fugitive = ''
    let g:ll_fileinfo = ''
    let g:ll_lineinfo = ''
    let g:ll_ale = ''

    let l:ww = winwidth('.')
    let l:total_len = 0

    let g:ll_mode = lightline#mode() . (&paste ? ' P' : '')
    if g:ll_mode !=# ''
      let l:total_len += strlen(g:ll_mode) + 2
      if l:ww < l:total_len
        return ''
      endif
    endif

    let g:ll_lineinfo = printf('%d/%d:%d', line('.'), line('$'), col('.'))
    if g:ll_lineinfo !=# ''
      let l:total_len += strlen(g:ll_lineinfo) + 2
      if l:ww < l:total_len
        let g:ll_lineinfo = ''
        return ''
      endif
    endif

    let g:ll_filename = expand('%:t') . (&filetype !~? 'help' && &readonly ? ' RO' : '') . (&modifiable && &modified ? ' +' : '')
    if g:ll_filename !=# ''
      let l:total_len += strlen(g:ll_filename) + 2
      if l:ww < l:total_len
        let g:ll_filename = ''
        return ''
      endif
    endif

    let g:ll_fileinfo = &fileformat . ' ' . (strlen(&fileencoding) ? &fileencoding : &encoding) . ' ' . (strlen(&filetype) ? &filetype : 'no')
    if g:ll_fileinfo !=# ''
      let l:total_len += strlen(g:ll_fileinfo) + 2
      if l:ww < l:total_len
        let g:ll_fileinfo = ''
        return ''
      endif
    endif

    let g:ll_ale = LLGetAle()
    if g:ll_ale !=# ''
      let l:total_len += strlen(g:ll_ale) + 2
      if l:ww < l:total_len
        let g:ll_ale = ''
        return ''
      endif
    endif

    let g:ll_fugitive = exists('*fugitive#head') ? fugitive#head() : ''
    if g:ll_fugitive !=# ''
      let g:ll_fugitive = '[' . g:ll_fugitive . ']'
      let l:total_len += strlen(g:ll_fugitive) + 2
      if l:ww < l:total_len
        let g:ll_fugitive = ''
        return ''
      endif
    endif

    return ''
  endfunction

  function! LLMode()
    return g:ll_mode
  endfunction

  function! LLFileName()
    return g:ll_filename
  endfunction

  function! LLFugitive()
    return g:ll_fugitive
  endfunction

  function! LLFileInfo()
    return g:ll_fileinfo
  endfunction

  function! LLLineInfo()
    return g:ll_lineinfo
  endfunction

  function! LLAle()
    return g:ll_ale
  endfunction

  if dein#tap('ale')
    function! LLGetAle()
      if get(b:, 'ale_enabled', get(g:, 'ale_enabled', 0))
        let l:count = ale#statusline#Count(bufnr(''))
        let l:errors = l:count.error + l:count.style_error
        let l:warnings = l:count.warning + l:count.style_warning
        return l:count.total == 0 ? 'OK' : 'E:' . l:errors . ' W:' . l:warnings
      endif
      return ''
    endfunction
  else
    function! LLGetAle()
      return ''
    endfunction
  endif
endif
"}}} lightline.vim

" vim-indent-guides{{{
if s:dein_enabled && dein#tap('vim-indent-guides')
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 1
  let g:indent_guides_auto_colors = 0
  hi IndentGuidesOdd  ctermbg=239
  hi IndentGuidesEven ctermbg=235
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
  function! s:ide()
    SrcExplToggle
    NERDTreeToggle
    TagbarToggle
  endfunction
  command! IDE call s:ide()
  nnoremap <silent> <Leader>A :IDE<CR>
endif
" }}}
" }}}

" Version Control System {{{
" vcscommand.vim {{{
  let g:VCSCommandDisableMappings = 1
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
" vim-quickhl {{{
if s:dein_enabled && dein#tap('vim-quickhl')
  nnoremap [quickhl] <Nop>
  xnoremap [quickhl] <Nop>
  nmap <Leader>h [quickhl]
  xmap <Leader>h [quickhl]
  nmap [quickhl]m <Plug>(quickhl-manual-this)
  xmap [quickhl]m <Plug>(quickhl-manual-this)
  nmap [quickhl]w <Plug>(quickhl-manual-this-whole-word)
  xmap [quickhl]w <Plug>(quickhl-manual-this-whole-word)
  nmap [quickhl]M <Plug>(quickhl-manual-reset)
  xmap [quickhl]M <Plug>(quickhl-manual-reset)
  nmap [quickhl]j <Plug>(quickhl-cword-toggle)
  nmap [quickhl]] <Plug>(quickhl-tag-toggle)
  map [quickhl]H <Plug>(operator-quickhl-manual-this-motion)
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
  let g:yankround_dir = s:vimdir . '/yankround'
  let g:yankround_max_element_length = 0
  let g:yankround_use_region_hl = 1
endif
" }}} yankround

" vim-multiple-cursors {{{
if s:dein_enabled && dein#tap('vim-multiple-cursors')
  "let g:multi_cursor_use_default_mapping = 0
  let g:multi_cursor_start_key = '<Leader>m'
endif
" }}} vim-multiple-cursors

" vim-surround {{{
if s:dein_enabled && dein#tap('vim-surround')
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
endif
" }}} vim-surround.vim
" }}} Edit

" Move {{{
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
      return 'No result found'
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

" }}} Plugin settings

" source other setting files{{{
function! s:source_file(file)
  let l:f = (expand(a:file))
  if filereadable(l:f)
    execute 'source' l:f
  endif
endfunction

" OS specific settings {{{
if has('win32') || has('win64')
  call s:source_file('~/.vimrc.win')
elseif has('mac')
  call s:source_file('~/.vimrc.mac')
elseif has('unix')
  call s:source_file('~/.vimrc.unix')
endif
" }}}

" local settings {{{
call s:source_file('~/.vimrc.local')
call s:source_file('~/.vimrc.dir')
" }}}

" }}}

" For vim w/o +eval{{{
endif
" }}}

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
