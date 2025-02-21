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
    'gbprod/yanky.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'kkharji/sqlite.lua' },
    },
    opts = {
      ring = {
        history_length = 100,
        storage = "sqlite",
        storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db",
        sync_with_numbered_registers = true,
        cancel_event = "update",
      },
      picker = {
        telescope = {
          use_default_mappings = true,
          mappings = nil,
        },
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 200,
      },
      preserve_cursor_position = {
        enabled = true,
      },
    },
    keys = {
      -- Normal mode
      { "p", "<Plug>(YankyPutAfter)", mode = { "n" }, desc = "Put yanked text after cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n" }, desc = "Put yanked text before cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n" }, desc = "Put yanked text after cursor and leave cursor after" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n" }, desc = "Put yanked text before cursor and leave cursor after" },
      { "<c-n>", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
      { "<c-p>", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
      -- Visual mode
      { "p", "<Plug>(YankyPutAfter)", mode = { "x" }, desc = "Put yanked text after cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "x" }, desc = "Put yanked text before cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "x" }, desc = "Put yanked text after cursor and leave cursor after" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "x" }, desc = "Put yanked text before cursor and leave cursor after" },
      -- Telescope integration
      { "<leader>fy", "<cmd>Telescope yank_history<cr>", desc = "Open yank history in Telescope" },
    },
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
        vim.keymap.set(mode, lhs, rhs, { remap = true, silent = true })
      end

      local keys = {'{', '}', '[', ']', '(', ')', '<', '>', '"', "'", '`', '*'}
      for _, key in ipairs(keys) do
        map_sandwich('n', '<Leader>' .. key, 'saiw' .. key)
        map_sandwich('x', key, 'sa' .. key)
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
