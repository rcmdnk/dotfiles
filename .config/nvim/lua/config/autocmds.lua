-- autocmds.lua

local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

-- Jump to last known position
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set nopaste when leaving insert mode
vim.api.nvim_create_autocmd('InsertLeave', {
  group = augroup('auto_nopaste'),
  command = 'set nopaste',
})

-- Close certain filetypes with just q
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'help',
    'qf',
    'man',
    'ref',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', ':q!<CR>', { buffer = event.buf, silent = true })
    vim.opt_local.spell = false
    vim.opt_local.tabstop = 8
    vim.opt_local.list = false
    vim.opt_local.readonly = true
    vim.opt_local.modifiable = false
    vim.opt_local.modified = false
  end,
})

-- Avoid automatic comment insertion
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('formatoptions'),
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove('r')
    vim.opt_local.formatoptions:remove('o')
  end,
})

-- Set up diff mode settings
vim.api.nvim_create_autocmd({ 'VimEnter', 'FilterWritePre' }, {
  group = augroup('diff_mode'),
  callback = function()
    if vim.wo.diff then
      vim.opt_local.spell = false
      vim.opt_local.wrap = true
    end
  end,
})

-- Automatic diffoff
vim.api.nvim_create_autocmd('WinEnter', {
  group = augroup('auto_diffoff'),
  callback = function()
    if vim.fn.winnr('$') == 1 and vim.wo.diff then
      vim.cmd('diffoff')
    end
  end,
})

-- Fix heredoc highlight in vim file
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('vim_heredoc'),
  pattern = 'vim',
  callback = function()
    vim.opt_local.syntax = 'vim'
    if vim.fn.has('nvim') == 1 then
      vim.cmd('lua vim.treesitter.start()')
    end
  end,
}) 