" vimrc

" For vim w/o +eval{{{
if 1
" }}} For vim w/o +eval

" Flags {{{
let s:use_dein = 1
" }}} Flags

" Prepare .vim dir {{{
if has('nvim')
  let s:vimdir = $HOME . '/.config/nvim'
else
  let s:vimdir = $HOME . '/.vim'
endif
if has('vim_starting')
  if ! isdirectory(s:vimdir)
    call system('mkdir ' . s:vimdir)
  endif
endif
" }}} Prepare .vim dir

" Python Environment {{{
let g:python3_dir = s:vimdir . '/python3'
function! InstallPipPackages()
  if !filereadable(expand(g:python3_dir . '/bin/activate'))
    call system('python3 -m venv ' . g:python3_dir)
  endif
  let g:python3_host_prog = g:python3_dir . '/bin/python'
  let $PATH = g:python3_dir . '/bin:' . $PATH
  call system('source ' . g:python3_dir . '/bin/activate && pip install pynvim autopep8 black pep8 flake8 pyflakes pylint jedi')
endfunction
if !filereadable(expand('~/.vim_no_python'))
  let s:python3 = system('which python3')
  if strlen(s:python3) != 0
    if ! isdirectory(g:python3_dir)
      call InstallPipPackages()
    endif
    let g:python3_host_prog = g:python3_dir . '/bin/python'
    let $PATH = g:python3_dir . '/bin:' . $PATH
  endif
endif
" }}} Python Environment

" dein {{{

" check/prepare dein environment {{{
let s:dein_enabled  = 0
if v:version > 704 && s:use_dein && !filereadable(expand('~/.vim_no_dein'))
  let s:git = system('which git')
  if strlen(s:git) != 0
    " Set dein paths
    let s:dein_dir = s:vimdir . '/dein'
    let s:git_server = 'github.com'
    let s:dein_repo_name = 'Shougo/dein.vim'
    let s:dein_repo = 'https://' . s:git_server . '/' . s:dein_repo_name
    let s:dein_github = s:dein_dir . '/repos/' . s:git_server
    let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

    " Check dein has been installed or not.
    if !isdirectory(s:dein_repo_dir)
      let s:is_clone = confirm('Prepare dein?', 'Yes\nNo', 2)
      if s:is_clone == 1
        let s:dein_enabled = 1
        echo 'dein is not installed, install now '
        echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
        call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
        if v:version == 704
          call system('cd ' . s:dein_repo_dir . ' && git checkout -b 1.5 1.5' )
        endif
      endif
    else
      let s:dein_enabled = 1
    endif
  endif
endif
" }}} check/prepare dein environment

" Begin plugin part {{{
if s:dein_enabled
  let &runtimepath = &runtimepath . ',' . s:dein_repo_dir
  let g:dein#install_process_timeout =  600

  " Check cache
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " dein
    " Do not manage dein at Vim 7.4, as it is not HEAD
    if v:version != 704
      call dein#add('Shougo/dein.vim')
    endif

    " Basic tools {{{
    " Sub mode
    if !has('nvim') || has('mac')
      call dein#add('kana/vim-submode')
    endif

    " webapi
    call dein#add('mattn/webapi-vim')
    " }}} Basic tools

    " Snippet {{{
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets', {'depdens': ['neosnippet']})
    call dein#add('honza/vim-snippets', {'depdens': ['neosnippet']})
    call dein#add('rcmdnk/vim-octopress-snippets', {'depdens': ['neosnippet']})
    " }}} Snippet

    " Search/Display {{{
    " Search and display information from arbitrary sources

    "if has('nvim-0.5.0') || has('patch-8.2.0662')
    "  call dein#add('Shougo/ddc.vim')
    "  " need brew install deno
    "  call dein#add('vim-denops/denops.vim')

    "  " sources
    "  call dein#add('Shougo/ddc-around')
    "  "call dein#add('Shougo/deoppet.nvim')
    "  call dein#add('matsui54/ddc-dictionary')
    "  "call dein#add('shun/ddc-vim-lsp')
    "  call dein#add('Shougo/ddc-nvim-lsp')

    "  " filters
    "  "c"all dein#add('Shougo/ddc-matcher_head')
    "  "c"all dein#add('Shougo/ddc-sorter_rank')
    "elseif has('python3')
    "  call dein#add('Shougo/denite.nvim')
    "  call dein#add('Shougo/neomru.vim')
    "endif
    " }}} Search/Display

    " Code syntax, tools for each language {{{
    if has('nvim')
      "if has('nvim-0.5.0')
      "  call dein#add('neovim/nvim-lspconfig')
      "  call dein#add('kabouzeid/nvim-lspinstall')
      "else
        call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
        call dein#add('relastle/vim-nayvy')
      "endif
    endif

    " Language packs
    call dein#add('sheerun/vim-polyglot', {'merged': 0})

    " Homebrew
    call dein#add('xu-cheng/brew.vim')

    " Java
    call dein#add('koron/java-helper-vim')

    " Markdown {{{
    call dein#add('joker1007/vim-markdown-quote-syntax')
    call dein#add('rcmdnk/vim-markdown')
    " }}} Markdown

    " Python {{{
    " Folding method for python, but makes completion too slow...?
    call dein#add('vim-scripts/python_fold')
    " }}} Python

    " Ruby (rails, erb)
    call dein#add('tpope/vim-rails')

    " LaTex
    call dein#add('lervag/vimtex')

    " Vim Syntax Checker
    call dein#add('dbakker/vim-lint')

    " }}} Code syntax, tools for each language

    " View {{{
    " Color scheme
    call dein#add('rcmdnk/rcmdnk-color.vim')

    " Status line
    call dein#add('itchyny/lightline.vim')

    " Visual indent guides: make moving slow?
    call dein#add('nathanaelkane/vim-indent-guides')

    " Fold
    call dein#add('Konfekt/FastFold')
    call dein#add('LeafCage/foldCC')

    " replacement of matchparen (require OptionSet sutocommand event)
    if has('patch-7.4.786')
      call dein#add('itchyny/vim-parenmatch')
    endif

    " Additional matchparen (such if~endif)
    call dein#add('andymass/vim-matchup')

    " Make the yanked region apparent!
    if !exists('##TextYankPost')
      call dein#add('machakann/vim-highlightedyank')
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

    " Icon
    "call dein#add('ryanoasis/vim-devicons')

    " }}} IDE like
    " }}} View

    " Version Control System {{{
    " Git
    call dein#add('tpope/vim-fugitive')
    call dein#add('gregsexton/gitv', {
          \ 'depdens': ['tpope/vim-fugitive'],
          \ 'on_cmd': ['Gitv'],
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
    " function: af, if -> remapped to aF, iF
    call dein#add('kana/vim-textobj-function', {'depends': ['vim-textobj-user']})
    " comment: ac, ic
    call dein#add('thinca/vim-textobj-comment', {'depends': ['vim-textobj-user']})
    " Between any X: afX, ifX
    call dein#add('thinca/vim-textobj-between', {'depends': ['vim-textobj-user']})
    " erb object: viE, ciE, daE
    call dein#add('whatyouhide/vim-textobj-erb', {'depends': ['vim-textobj-user']})
    " }}} textobj

    " Operator {{{
    call dein#add('kana/vim-operator-user')
    call dein#add('kana/vim-operator-replace', {'depdens': ['vim-operator-user']})
    " }}} Operator

    "" Undo
    call dein#add('simnalamburt/vim-mundo')

    " Align
    call dein#add('junegunn/vim-easy-align')

    " yank
    call dein#add('rcmdnk/yankround.vim')
    call dein#add('rcmdnk/yankshare.vim')

    " vim-multiple-cursors, like Sublime Text's multiple selection
    call dein#add('terryma/vim-multiple-cursors')

    " Easy to change surround
    call dein#add('machakann/vim-sandwich')

    " if...end
    call dein#add('tpope/vim-endwise')

    " To edit help
    call dein#add('rcmdnk/edit-help.vim')

    " Edit browser
    "if has('nvim')
    "  call dein#add('subnut/nvim-ghost.nvim', {
    "      \ 'hook_post_update': 'call nvim_ghost#installer#install()'})
    "else
    "  call dein#add('raghur/vim-ghost', {
    "      \ 'hook_post_update': 'GhostInstall'})
    "  if v:version >= 800 && !has('nvim')
    "    call dein#add('roxma/nvim-yarp')
    "    call dein#add('roxma/vim-hug-neovim-rpc')
    "  endif
    "endif

    " }}} Edit

    call dein#end()

    call dein#save_state()
  endif

  " Installation check.
  if dein#check_install()
    call dein#install()
  endif
endif
" }}} Begin plugin part
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
set expandtab      " do :retab -> tab->space
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
"set showbreak=+\
set showbreak=
"if has('patch-7.4.338')
"  set breakindent    " indent even for wrapped lines
"  " breakindent option (autocmd is necessary when new file is opened in Vim)
"  " necessary even for default(min:20,shift:0)
"  autocmd MyAutoGroup BufEnter * set breakindentopt=min:20,shift:0
"endif

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
if exists('&inccommand')
  set inccommand=split
endif

set nrformats=hex  " Not use cotal, alpha for increment or decrement
" Enable 256 colors, this seems still necessary in some environments, in such GNU screen
set t_Co=256
" Set 24 bit colors, this makes wrong if the terminal does not support true color (need some terminal env check...)
"if has('patch-7.4.1788')
"  set termguicolors
"elseif has('patch-7.4.1778')
"  set guicolors
"endif
"if has('nvim')
"  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"endif
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

if has('patch-7.4.38')
  set spelllang+=cjk " Ignore double-width characters
endif

" bash-like tab completion
set wildmode=list:longest
set wildmenu

" Folding
set foldnestmax=1
set foldlevel=100 "open at first

" tag
if has('path_extra')
  set tags+=tags;
endif

" cscope
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

" When editing a file, always jump to the last known cursor position.
autocmd MyAutoGroup BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Avoid automatic comment out for the next line after the comment lines
autocmd MyAutoGroup FileType * setlocal formatoptions-=ro

" Arrow to open new file while current file is not saved
set hidden

" Used for the CursorHold (ms, default is 4000)
set updatetime=300

" don't give ins-completion-menu message
set shortmess+=c

" Jump to the first opened window
set switchbuf=useopen

" virtualedit (can move to non-editing places: e.x. right of $)
set virtualedit=all

" For shell script (sh.vim), don't append '.' to iskeyword
let g:sh_noisk=1

" Set nopaste when it comes back to Normal mode
autocmd MyAutoGroup InsertLeave * setlocal nopaste

" Max columns for syntax search
" Such XML file has too much syntax which make vim drastically slow
set synmaxcol=1000 "default 3000

" Load Man command even for other file types than man.
runtime ftplugin/man.vim

" No automatic break at the end of the file
if has('patch-7.4.785')
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

" Use semicolon as colong
noremap ; :

""" Normal mode

" window move
" Left (C-h default: <BS> ~ h)
nnoremap <C-h> <C-w>h
nnoremap <BS> <C-w>h
" Down (C-j default: <NL> ~ j)
nnoremap <C-j> <C-w>j
nnoremap <RETURN> <C-w>j
" Up (C-k default: Non)
nnoremap <C-k> <C-w>k
" Right (C-l default: Clear and redraw the screen)
nnoremap <C-l> <C-w>l
" cursor move
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

" save/quit/buffer
nnoremap <Leader>q :bdelete<CR>
nnoremap <Leader>w :w<CR>:bdelete<CR>
nnoremap <A-w> :w<CR>
nnoremap <A-q> :q!<CR>
nnoremap <A-z> :ZZ<CR>
" don't enter Ex mode: map to quit
nnoremap Q :q<CR>
" Use other one characters
nnoremap Z ZZ
nnoremap W :w<CR>
nnoremap ! :q!<CR>

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

" My functions/commands {{{
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

" Remove trail spaces and align {{{
function! s:indent_all()
  keepjumps normal! mxgg=G'x
  delmarks x
endfunction
command! IndentAll keepjumps call s:indent_all()

function! s:delete_space()
  %s/\s\+$//
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
      execute "buffer" l:i
      AlignCode
      update
      bdelete
    endif
  endfor
  quit
endfunction
command! AlignAllBuf call s:align_all_buf()

" remove trail spaces for all
nnoremap <silent> <Leader><Space> :DeleteSpace<CR>

" remove trail spaces at selected region
xnoremap <silent> <Leader><Space> :s/\s\+$//g<CR>
" }}} Remove trail spaces and align

" Get syntax information {{{
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
" }}} Get syntax information

" Toggle sign column {{{
function! s:toggle_sign_colmn()
  let l:sc_setting = &signcolumn
  if l:sc_setting ==# 'no'
    setlocal signcolumn=auto
  else
    setlocal signcolumn=no
  endif
endfunction
command! ToggleSignColmn call s:toggle_sign_colmn()
nnoremap <silent> <Leader>c :ToggleSignColmn<CR>

" }}} Toggle sign column

" }}} My functions

" Plugin settings {{{
if s:dein_enabled

" Basic tools {{{
" vim-submode {{{
if dein#tap('vim-submode')
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

" Snippet {{{
" neosnippet {{{
if dein#tap('neosnippet')
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
if dein#tap('denite.nvim')
  " Add custom menus
  let s:menus = {}
  let s:menus.file = {'description': 'File search (buffer, file, file_rec, file_mru'}
  let s:menus.line = {'description': 'Line search (change, grep, line, tag'}
  let s:menus.others = {'description': 'Others (command, command_history, help)'}
  let s:menus.file.command_candidates = [
        \ ['buffer', 'Denite buffer'],
        \ ['file: Files in the current directory', 'Denite file'],
        \ ['file_rec: Files, recursive list under the current directory', 'Denite file_rec'],
        \ ['file_mru: Most recently used files', 'Denite file_mru']
        \ ]
  let s:menus.line.command_candidates = [
        \ ['change', 'Denite change'],
        \ ['grep', 'Denite grep'],
        \ ['line', 'Denite line'],
        \ ['tag', 'Denite tag']
        \ ]
  let s:menus.others.command_candidates = [
        \ ['command', 'Denite command'],
        \ ['command_history', 'Denite command_history'],
        \ ['help', 'Denite help']
        \ ]

  call denite#custom#var('menu', 'menus', s:menus)

  let s:denite_win_width_percent = 0.85
  let s:denite_win_height_percent = 0.5

  call denite#custom#option('default', {
      \ 'split': 'floating',
      \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
      \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
      \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
      \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
      \ 'vertical_preview': 1,
      \ 'start_filter': 1,
      \ 'auto_resize': 1,
      \ 'source_names': 'short',
      \ 'highlight_window_background': 'Visual',
      \ 'highlight_filter_background': 'VertSplit',
      \ })

  nnoremap [denite] <Nop>
  nmap <Leader>u [denite]
  nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
  nnoremap <silent> [denite]c :<C-u>Denite changes<CR>
  nnoremap <silent> [denite]f :<C-u>Denite file<CR>
  nnoremap <silent> [denite]g :<C-u>Denite grep<CR>
  nnoremap <silent> [denite]h :<C-u>Denite help<CR>
  nnoremap <silent> [denite]l :<C-u>Denite line<CR>
  nnoremap <silent> [denite]t :<C-u>Denite tag<CR>
  nnoremap <silent> [denite]m :<C-u>Denite file_mru<CR>
  nnoremap <silent> [denite]u :<C-u>Denite menu<CR>

  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
  endfunction

  autocmd FileType denite-filter call s:denite_filter_my_settings()
  function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <Esc>       <Plug>(denite_filter_quit)
    if dein#tap('deoplete.nvim')
      " disable deoplete on denite-filter
      call deoplete#custom#buffer_option('auto_complete', v:false)
    endif
  endfunction

endif
" }}} denite
" ddc {{{
if dein#tap('ddc.vim')
  call ddc#custom#patch_global('sources', ['around'])

  " you neeed to set 'dictionary' option
  setlocal dictionary+=/usr/share/dict/words
  " or you can specify dictionary path using sourceParams ('dictPaths' must be list of files)
  call ddc#custom#patch_global('sourceParams', {
        \ 'dictionary': {'dictPaths':
        \ ['/usr/share/dict/german',
        \ '/usr/share/dict/words',
        \ '/usr/share/dict/spanish'],
        \ 'smartCase': v:true,
        \ }
        \ })

  call ddc#custom#patch_global('sources', ['dictionary'])
  call ddc#custom#patch_global('sourceOptions', {
        \ '_': {'matchers': ['matcher_head']},
        \ 'dictionary': {'mark': 'D'},
        \ })


  "call ddc#custom#patch_global('sources', ['ddc-vim-lsp'])
  "call ddc#custom#patch_global('sourceOptions', {
  "    \ 'ddc-vim-lsp': {
  "    \   'matchers': ['matcher_head'],
  "    \   'mark': 'lsp',
  "    \ },
  "    \ })

  call ddc#custom#patch_global('sources', ['nvimlsp'])
  call ddc#custom#patch_global('sourceOptions', {
        \ '_': { 'matchers': ['matcher_head'] },
        \ 'nvimlsp': { 'mark': 'lsp', 'forceCompletionPattern': '\.|:|->' },
        \ })

  " Use Customized labels
  call ddc#custom#patch_global('sourceParams', {
        \ 'nvimlsp': { 'kindLabels': { 'Class': 'c' } },
        \ })

  " Mappings

  " <TAB>: completion.
  inoremap <silent><expr> <TAB>
  \ pumvisible() ? '<C-n>' :
  \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
  \ '<TAB>' : ddc#manual_complete()

  " <S-TAB>: completion back.
  inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

  " Use ddc.
  call ddc#enable()
endif
" }}} ddc
" }}} Search/Display

" Code syntax, tools for each language {{{
" coc.nvim {{{
if dein#tap('coc.nvim')
  function! InstallCocExtentions()
    CocInstall -sync coc-actions coc-browser coc-calc coc-clangd coc-cmake coc-css
    quit
    CocInstall -sync coc-explorer coc-fzf-preview coc-git coc-go coc-highlight
    quit
    CocInstall -sync coc-html coc-java coc-tsserver coc-json coc-dictionary coc-word
    quit
    CocInstall -sync coc-tag coc-lists coc-markdownlint coc-powershell coc-pyright
    quit
    CocInstall -sync coc-sh coc-spell-checker coc-sql coc-texlab coc-vimlsp coc-xml
    quit
    CocInstall -sync coc-yaml coc-yank coc-diagnostic
    quit
  endfunction

  let g:coc_config_home = s:vimdir

  " Use tab for trigger completion with characters ahead and navigate.
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Use <cr> to confirm completion
  inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <silent> <M-p> <Plug>(coc-diagnostic-prev)
  nmap <silent> <M-n> <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  nnoremap <silent> K :call <SID>show_documentation()<CR>

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)
endif
" }}} coc.nvim

" vim-markdown-quote-syntax {{{
if dein#tap('vim-markdown-quote-syntax')
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

" vim-polyglot {{{
if dein#tap('vim-polyglot')
  " for chrisbra/csv.vim
  let g:csv_no_conceal = 1
endif
" }}} vim-polyglot

" markdown {{{
if dein#tap('vim-markdown')
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

" vimtex {{{
if dein#tap('vimtex')
  "let g:vimtex_compiler_progname = 'nvr'
  let g:tex_flavor = 'latex'
endif
" }}} vimtex

" }}} Code syntax, tools for each language

" View {{{

" rcmdnk-color.vim {{{
if dein#tap('rcmdnk-color.vim')
  colorscheme rcmdnk
endif
" }}}

" lightline.vim {{{
if dein#tap('lightline.vim')
  let g:lightline = {
        \'colorscheme': 'jellybeans',
        \'active': {
              \'left': [['prepare', 'mode'], ['filename', 'fugitive']],
              \'right': [['lineinfo'], ['fileinfo'], ['coc']]},
        \'component_visible_condition': {
              \'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'},
        \'component_function': {
              \'prepare': 'LLPrepare',
              \'mode': 'LLMode',
              \'filename': 'LLFileName',
              \'fugitive': 'LLFugitive',
              \'fileinfo': 'LLFileInfo',
              \'lineinfo': 'LLLineInfo',
              \'coc': 'LLCoc',
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
    let g:ll_coc = ''

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

    let g:ll_coc = LLGetCoc()
    if g:ll_coc !=# ''
      let l:total_len += strlen(g:ll_coc) + 2
      if l:ww < l:total_len
        let g:ll_coc = ''
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

  function! LLCoc()
    return g:ll_coc
  endfunction

  if dein#tap('coc.nvim')
    function! LLGetCoc()
      let info = get(b:, 'coc_diagnostic_info', {})
      if empty(info) | return '' | endif
      let msgs = []
      if get(info, 'error', 0)
        call add(msgs, 'E' . info['error'])
      endif
      if get(info, 'warning', 0)
        call add(msgs, 'W' . info['warning'])
      endif
      return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
    endfunction

    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
  else
    function! LLGetCoc()
      return ''
    endfunction
  endif
endif
"}}} lightline.vim

" vim-indent-guides{{{
if dein#tap('vim-indent-guides')
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 1
  let g:indent_guides_auto_colors = 0
  hi IndentGuidesOdd  ctermbg=239
  hi IndentGuidesEven ctermbg=235
endif
"}}} vim-indent-guides

" foldCC {{{
if dein#tap('foldCC')
  set foldtext=FoldCCtext()
endif
"}}} foldCC

" vim-highlightedyank{{{
if dein#tap('vim-highlightedyank')
  if !exists('##TextYankPost')
    map y <Plug>(highlightedyank)
    let g:highlightedyank_highlight_duration = 100
  endif
endif
"}}} vim-highlightedyank

" linediff {{{
if dein#tap('linediff.vim')
  let g:linediff_first_buffer_command  = 'leftabove new'
  let g:linediff_second_buffer_command = 'rightbelow vertical new'
endif
"}}} linediff

" vim-diff-enhanced {{{
if dein#tap('vim-diff-enhanced')
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
"}}} vim-diff-enhanced

" NERDTree+SrcExpl+tagbar {{{

" The NERD Tree  {{{
if dein#tap('nerdtree')
  nnoremap <Leader>N :NERDTreeToggle<CR>
endif
"}}}

" SrcExpl  {{{
if dein#tap('SrcExpl')
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
if dein#tap('tagbar')
  " Width (default 40)
  let g:tagbar_width = 20
  " Mappings
  nnoremap <silent> <leader>T :TagbarToggle<CR>
endif
"}}} tagbar

if dein#tap('nerdtree') && dein#tap('SrcExpl') && dein#tap('tagbar')
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
" gist-vim {{{
if dein#tap('gist-vim')
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 1
  " Disable default Gist command
  cnoremap <silent> Gist<CR> echo 'use Gist -P to make a public gist'<CR>
endif
" }}} gist-vim
" }}}

" Selection {{{
" vim-quickhl {{{
if dein#tap('vim-quickhl')
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
if dein#tap('vim-anzu')
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
" textobj {{{
if dein#tap('vim-textobj-function')
  omap iF <Plug>(textobj-function-i)
  omap aF <Plug>(textobj-function-a)
  vmap iF <Plug>(textobj-function-i)
  vmap aF <Plug>(textobj-function-a)
endif
" }}} textobj

" mundo {{{
if dein#tap('vim-mundo')
  nnoremap U :MundoToggle<CR>
  let g:gundo_width = 30
  let g:gundo_preview_height = 15
  let g:gundo_auto_preview = 0 " Don't show preview by moving history. Use r to see differences
  let g:gundo_preview_bottom = 1 " Show preview at the bottom
endif
" }}} mundo

" Operator {{{
" vim-operator-replace{{{
if dein#tap('vim-operator-replace')
  map _  <Plug>(operator-replace)
endif
" }}} vim-operator-replace
" }}} Operator

" vim-easy-align {{{
if dein#tap('vim-easy-align')
  xmap ga <Plug>(EasyAlign)*
  nmap ga <Plug>(EasyAlign)*
endif
" }}} vim-easy-align

" yankround {{{
if dein#tap('yankround.vim')
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

" yankshare {{{
if dein#tap('yankshare.vim')
  nmap <silent> <Leader>y <Plug>(yankshare)
  xmap <silent> <Leader>y <Plug>(yankshare)
  let g:yankshare_file = '~/.vim/yankshare.txt'
  let g:yankshare_register = 's'
endif
" }}} yankshare

" vim-multiple-cursors {{{
if dein#tap('vim-multiple-cursors')
  let g:multi_cursor_use_default_mapping = 0
  let g:multi_cursor_start_key = '<Leader>m'
endif
" }}} vim-multiple-cursors

" vim-endwise {{{
if dein#tap('vim-endwise')
  let g:endwise_no_mappings = v:true
endif
" }}} vim-endwise

" vim-sandwich {{{
if dein#tap('vim-sandwich')
  let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
  let g:sandwich#recipes += [
        \   {
        \     'buns': ['**', '**'],
        \     'nesting': 0,
        \     'input': ['a'],
        \   },
        \ ]

  nmap <Leader>{ saiw{
  nmap <Leader>} saiw}
  nmap <Leader>[ saiw[
  nmap <Leader>] saiw]
  nmap <Leader>( saiw(
  nmap <Leader>) saiw)
  nmap <Leader>< saiw<
  nmap <Leader>> saiw>
  nmap <Leader>" saiw"
  nmap <Leader>' saiw'
  nmap <Leader>` saiw`
  nmap <Leader>* saiw*
  nmap <Leader><Leader>* saiwa
  xmap { sa{
  xmap } sa}
  xmap [ sa[
  xmap ] sa]
  xmap ( sa(
  xmap ) sa)
  xmap < sa<
  xmap > sa>
  xmap " sa"
  xmap ' sa'
  xmap ` sa`
  xmap * sa*
  xmap <Leader>* saa
endif
" }}} vim-sandwich
" }}} Edit
endif " if s:dein_enabled
" }}} Plugin settings

" source other setting files {{{
function! s:source_file(file)
  let l:f = (expand(a:file))
  if filereadable(l:f)
    execute "source" l:f
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
" }}} OS specific settings

" local settings {{{
call s:source_file('~/.vimrc.local')
call s:source_file('~/.vimrc.dir')
" }}} local settings
" }}} source other setting files

" For vim w/o +eval{{{
endif
" }}} For vim w/o +eval

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
