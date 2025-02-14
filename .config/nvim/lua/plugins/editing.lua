return {
  -- Text objects
  {
    'kana/vim-textobj-user',
    event = 'VeryLazy',
  },
  {
    'kana/vim-textobj-line',
    event = 'VeryLazy',
    dependencies = { 'kana/vim-textobj-user' },
  },
  {
    'kana/vim-textobj-indent',
    event = 'VeryLazy',
    dependencies = { 'kana/vim-textobj-user' },
  },
  {
    'kana/vim-textobj-function',
    event = 'VeryLazy',
    dependencies = { 'kana/vim-textobj-user' },
    config = function()
      vim.keymap.set('o', 'iF', '<Plug>(textobj-function-i)')
      vim.keymap.set('o', 'aF', '<Plug>(textobj-function-a)')
      vim.keymap.set('x', 'iF', '<Plug>(textobj-function-i)')
      vim.keymap.set('x', 'aF', '<Plug>(textobj-function-a)')
    end,
  },
  {
    'thinca/vim-textobj-comment',
    event = 'VeryLazy',
    dependencies = { 'kana/vim-textobj-user' },
  },
  {
    'thinca/vim-textobj-between',
    event = 'VeryLazy',
    dependencies = { 'kana/vim-textobj-user' },
  },

  -- Operators
  {
    'kana/vim-operator-user',
    event = 'VeryLazy',
  },
  {
    'kana/vim-operator-replace',
    event = 'VeryLazy',
    dependencies = { 'kana/vim-operator-user' },
    config = function()
      vim.keymap.set('n', '_', '<Plug>(operator-replace)')
    end,
  },

  -- Undo
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { 'U', ':UndotreeToggle<CR>', desc = 'Toggle Undotree' },
    },
  },

  -- Alignment
  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', '<Plug>(EasyAlign)*', mode = { 'n', 'x' }, desc = 'Easy Align' },
    },
  },

  -- Yank
  {
    'rcmdnk/yankround.vim',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set('n', 'p', '<Plug>(yankround-p)')
      vim.keymap.set('x', 'p', '<Plug>(yankround-p)')
      vim.keymap.set('n', 'P', '<Plug>(yankround-P)')
      vim.keymap.set('n', 'gp', '<Plug>(yankround-gp)')
      vim.keymap.set('x', 'gp', '<Plug>(yankround-gp)')
      vim.keymap.set('n', 'gP', '<Plug>(yankround-gP)')
      vim.keymap.set('n', '<C-p>', '<Plug>(yankround-prev)')
      vim.keymap.set('n', '<C-n>', '<Plug>(yankround-next)')
      vim.g.yankround_max_history = 30
      vim.g.yankround_dir = vim.fn.stdpath('data') .. '/yankround'
      vim.g.yankround_max_element_length = 0
      vim.g.yankround_use_region_hl = 1
    end,
  },
  {
    'rcmdnk/yankshare.vim',
    keys = {
      { '<Leader>y', '<Plug>(yankshare)', mode = { 'n', 'x' }, desc = 'Share Yank' },
    },
    config = function()
      vim.g.yankshare_file = '~/.vim/yankshare.txt'
      vim.g.yankshare_register = 's'
    end,
  },

  -- Multiple cursors
  {
    'terryma/vim-multiple-cursors',
    keys = {
      { '<Leader>m', desc = 'Multiple Cursors' },
    },
    config = function()
      vim.g.multi_cursor_use_default_mapping = 0
      vim.g.multi_cursor_start_key = '<Leader>m'
    end,
  },

  -- Surround
  {
    'machakann/vim-sandwich',
    event = 'VeryLazy',
    config = function()
      vim.g['sandwich#recipes'] = vim.deepcopy(vim.g['sandwich#default_recipes'])
      table.insert(vim.g['sandwich#recipes'], {
        buns = { '**', '**' },
        nesting = 0,
        input = { 'a' },
      })

      local function map_sandwich(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { silent = true })
      end

      -- Normal mode mappings
      local pairs = {
        { '{', '}' }, { '[', ']' }, { '(', ')' },
        { '<', '>' }, { '"', '"' }, { "'", "'" },
        { '`', '`' }, { '*', '*' },
      }

      for _, pair in ipairs(pairs) do
        map_sandwich('n', '<Leader>' .. pair[1], 'saiw' .. pair[1])
        map_sandwich('x', pair[1], 'sa' .. pair[1])
      end

      map_sandwich('n', '<Leader><Leader>*', 'saiwa')
      map_sandwich('x', '<Leader>*', 'saa')
    end,
  },

  -- Auto pairs
  {
    'tpope/vim-endwise',
    event = 'InsertEnter',
    config = function()
      vim.g.endwise_no_mappings = true
    end,
  },
} 