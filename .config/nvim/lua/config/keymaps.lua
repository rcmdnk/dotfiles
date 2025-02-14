-- keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Use semicolon as colon
map('n', ';', ':', { noremap = true })

-- Cursor movement
map('n', '<M-h>', '0', opts)
map('n', '<D-h>', '0', opts)
map('n', '<Leader>h', '0', opts)
map('n', 'L', '$', opts)
map('n', '<M-l>', '$', opts)
map('n', '<D-l>', '$', opts)
map('n', '<Leader>l', '$', opts)
map('n', '<M-k>', 'gg', opts)
map('n', '<D-k>', 'gg', opts)
map('n', '<Leader>k', 'gg', opts)
map('n', '<M-j>', 'G', opts)
map('n', '<D-j>', 'G', opts)
map('n', '<Leader>j', 'G', opts)

-- Window navigation
map('n', '<C-w><CR>', '<C-w><C-j>', opts)

-- Spell check toggle
map('n', '<Leader>s', ':setlocal spell!<CR>', opts)

-- Stop highlight search
map('n', '<Leader>/', ':noh<CR>', opts)

-- Buffer operations
map('n', '<Leader>q', ':bdelete<CR>', opts)
map('n', '<Leader>w', ':w<CR>:bdelete<CR>', opts)
map('n', '<A-w>', ':w<CR>', opts)
map('n', '<A-q>', ':q!<CR>', opts)
map('n', '<A-z>', ':ZZ<CR>', opts)
map('n', 'Q', ':q<CR>', opts)
map('n', 'Z', 'ZZ', opts)
map('n', 'W', ':w<CR>', opts)
map('n', '!', ':q!<CR>', opts)

-- Fix Y behavior
map('n', 'Y', 'y$', opts)

-- Paste operations
map('n', '<Leader>p', '"+gP', opts)
map('n', '<Leader>P', ':setlocal paste!<CR>:setlocal paste?<CR>', opts)
map('i', '<C-]>', '<C-o>:setlocal paste!<CR>', opts)

-- Source init.lua
map('n', '<Leader>.', ':source $MYVIMRC<CR>', opts)

-- Insert mode mappings
map('i', '<C-a>', '<Home>', opts)
map('i', '<C-e>', '<End>', opts)
map('i', '<C-d>', '<Delete>', opts)
map('i', '<C-b>', '<Left>', opts)
map('i', '<C-f>', '<Right>', opts)
map('i', '<C-k>', '<Leader><C-o>D', opts)
map('i', '<C-u>', '<C-g>u<C-u>', opts)

-- Visual mode mappings
map('x', 'w', 'iw', opts)
map('x', 'W', 'iW', opts)
map('x', '$', '$h', opts)
map('x', 'L', '$h', opts)
map('x', 'v', '$h', opts)
map('x', '<C-a>', '<C-a>gv', opts)
map('x', '<C-x>', '<C-x>gv', opts)

-- Command mode mappings
map('c', '<C-b>', '<Left>', { noremap = true })
map('c', '<C-f>', '<Right>', { noremap = true })
map('c', '<C-a>', '<Home>', { noremap = true })
map('c', '<C-e>', '<End>', { noremap = true })
map('c', '<C-h>', '<BS>', { noremap = true })
map('c', '<C-d>', '<Del>', { noremap = true })
map('c', '<M-b>', '<S-Left>', { noremap = true })
map('c', '<M-f>', '<S-Right>', { noremap = true })
map('c', 'w!!', 'w !sudo tee > /dev/null %', { noremap = true })

-- Virtual edit mode fixes
if vim.o.virtualedit == 'all' then
  map('n', 'p', "col('.') >= col('$') ? '$p' : 'p'", { expr = true })
  map('n', 'i', "col('.') >= col('$') ? '$i' : 'i'", { expr = true })
  map('n', 'a', "col('.') >= col('$') ? '$a' : 'a'", { expr = true })
  map('n', 'r', "col('.') >= col('$') ? '$r' : 'r'", { expr = true })
  map('n', 'R', "col('.') >= col('$') ? '$R' : 'R'", { expr = true })
  map('n', '.', "col('.') >= col('$') ? '$.' : '.'", { expr = true })
  map('n', 'x', "col('.') >= col('$') ? '$\"_x' : '\"_x'", { expr = true })
end 
