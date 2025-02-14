-- options.lua

local opt = vim.opt

-- Encoding
opt.encoding = 'utf-8'
opt.fileencodings = { 'utf-8', 'iso-2022-jp', 'cp932', 'euc-jp', 'default', 'latin' }

-- Terminal
opt.ttimeout = true
opt.ttimeoutlen = 50
opt.ttyfast = true
opt.termguicolors = true

-- Search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = false
opt.incsearch = true
opt.inccommand = 'split'

-- Indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 0
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.cinoptions = 'g0'

-- Display
opt.number = false
opt.wrap = true
opt.display = 'lastline'
opt.showbreak = ''
opt.breakindent = true
opt.breakindentopt = 'min:20,shift:0'
opt.showmatch = true
opt.matchtime = 1
opt.list = true
opt.listchars = { tab = '>-', trail = '-', extends = '>', precedes = '<', nbsp = '%' }
opt.fillchars = { eob = ' ' }
opt.colorcolumn = '80'
opt.signcolumn = 'yes'
opt.cmdheight = 1
opt.laststatus = 2
opt.showcmd = true
opt.scrolloff=10
opt.scroll=0

-- Files
opt.backup = false
opt.swapfile = true
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 1000
opt.hidden = true

-- Completion
opt.wildmode = 'list:longest'
opt.wildmenu = true
opt.pumheight = 20

-- Folding
opt.foldmethod = 'marker'
opt.foldmarker = '{{{,}}}'
opt.foldnestmax = 1
opt.foldlevel = 100

-- Misc
opt.mouse = ''
opt.updatetime = 300
opt.shortmess:append('c')
opt.virtualedit = 'all'
opt.spell = true
opt.spelllang = { 'en', 'cjk' }
opt.whichwrap = 'b,s,h,l'

-- Tags
if vim.fn.has('path_extra') == 1 then
  opt.tags:append('tags;')
end

-- Set directory for swap and backup files
local function set_backup_dir()
  local data_dir = vim.fn.stdpath('data')
  local backup_dir = data_dir .. '/backup'
  local swap_dir = data_dir .. '/swap'
  local undo_dir = data_dir .. '/undo'

  -- Create directories if they don't exist
  for _, dir in ipairs({ backup_dir, swap_dir, undo_dir }) do
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end

  opt.backupdir = backup_dir
  opt.directory = swap_dir
  opt.undodir = undo_dir
end

set_backup_dir()
