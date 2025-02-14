return {
  -- GitHub Copilot
  {
    'github/copilot.vim',
    event = 'InsertEnter',
    config = function()
      vim.keymap.set('i', '<M-i>', '<Plug>(copilot-next)', { silent = true })
      vim.keymap.set('i', '<M-o>', '<Plug>(copilot-previous)', { silent = true })
    end,
  },

  -- CopilotChat
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      'github/copilot.vim',
      'nvim-lua/plenary.nvim',
    },
    cmd = {
      'CopilotChatBuffer',
      'CopilotChatExplain',
      'CopilotChatReview',
      'CopilotChatFix',
      'CopilotChatOptimize',
      'CopilotChatDocs',
      'CopilotChatTests',
      'CopilotChatFixDiagnostic',
      'CopilotChatCommit',
      'CopilotChatCommitStaged',
      'CopilotChatRefactor',
      'CopilotChatVisual',
      'CopilotChatInPlace',
    },
    keys = {
      { '<leader>ccb', '<cmd>CopilotChatBuffer<cr>', desc = 'CopilotChat - Buffer' },
      { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain' },
      { '<leader>ccr', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review' },
      { '<leader>ccf', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat - Fix' },
      { '<leader>cco', '<cmd>CopilotChatOptimize<cr>', desc = 'CopilotChat - Optimize' },
      { '<leader>ccd', '<cmd>CopilotChatDocs<cr>', desc = 'CopilotChat - Docs' },
      { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Tests' },
      { '<leader>ccF', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - Fix Diagnostic' },
      { '<leader>ccc', '<cmd>CopilotChatCommit<cr>', desc = 'CopilotChat - Commit' },
      { '<leader>ccC', '<cmd>CopilotChatCommitStaged<cr>', desc = 'CopilotChat - Commit Staged' },
      { '<leader>ccR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor' },
      { '<leader>ccv', ':CopilotChatVisual<cr>', mode = 'x', desc = 'CopilotChat - Visual' },
      { '<leader>ccx', ':CopilotChatInPlace<cr>', mode = 'x', desc = 'CopilotChat - In Place' },
    },
    config = function()
      require('CopilotChat').setup({
        debug = true,
      })
    end,
  },

  -- Snippets
  {
    'Shougo/neosnippet',
    dependencies = {
      'Shougo/neosnippet-snippets',
      'honza/vim-snippets',
      'rcmdnk/vim-octopress-snippets',
    },
    event = 'InsertEnter',
    config = function()
      vim.g.neosnippet_enable_snipmate_compatibility = 1
      vim.g.neosnippet_disable_runtime_snippets = { _= 1 }
      vim.g.neosnippet_snippets_directory = {
        vim.fn.stdpath('data') .. '/lazy/neosnippet-snippets/neosnippets',
        vim.fn.stdpath('data') .. '/lazy/vim-snippets/snippets',
        vim.fn.stdpath('data') .. '/lazy/vim-octopress-snippets/neosnippets',
      }

      vim.keymap.set('i', '<C-s>', '<Plug>(neosnippet_expand_or_jump)')
      vim.keymap.set('s', '<C-s>', '<Plug>(neosnippet_expand_or_jump)')
      vim.keymap.set('x', '<C-s>', '<Plug>(neosnippet_expand_target)')
    end,
  },

  -- LSP and completion
  {
    'neoclide/coc.nvim',
    branch = 'release',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Some servers have issues with backup files
      vim.opt.backup = false
      vim.opt.writebackup = false

      -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
      -- delays and poor user experience
      vim.opt.updatetime = 300

      -- Always show the signcolumn
      vim.opt.signcolumn = "yes"

      local keyset = vim.keymap.set

      -- Autocomplete
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- Use Tab for trigger completion with characters ahead and navigate
      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
      keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

      -- Make <CR> to accept selected completion item or notify coc.nvim to format
      keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

      -- Use <c-space> to trigger completion
      keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

      -- Use `[g` and `]g` to navigate diagnostics
      keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
      keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
      keyset("n", "<M-p>", "<Plug>(coc-diagnostic-prev)", {silent = true})
      keyset("n", "<M-n>", "<Plug>(coc-diagnostic-next)", {silent = true})

      -- GoTo code navigation
      keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
      keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
      keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
      keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

      -- Use K to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end
      keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

      -- Symbol renaming
      keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

      -- Formatting selected code
      keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
      keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

      -- Apply codeAction to the selected region
      keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", {silent = true})
      keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", {silent = true})

      -- Remap keys for apply code actions at the cursor position.
      keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", {silent = true})
      -- Remap keys for apply code actions affect whole buffer.
      keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", {silent = true})
      -- Apply the most preferred quickfix action to fix diagnostic on the current line.
      keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", {silent = true})

      -- Remap keys for apply refactor code actions.
      keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
      keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
      keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

      -- Run the Code Lens action on the current line
      keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", {silent = true})

      -- Map function and class text objects
      -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
      keyset("x", "if", "<Plug>(coc-funcobj-i)", {silent = true})
      keyset("o", "if", "<Plug>(coc-funcobj-i)", {silent = true})
      keyset("x", "af", "<Plug>(coc-funcobj-a)", {silent = true})
      keyset("o", "af", "<Plug>(coc-funcobj-a)", {silent = true})
      keyset("x", "ic", "<Plug>(coc-classobj-i)", {silent = true})
      keyset("o", "ic", "<Plug>(coc-classobj-i)", {silent = true})
      keyset("x", "ac", "<Plug>(coc-classobj-a)", {silent = true})
      keyset("o", "ac", "<Plug>(coc-classobj-a)", {silent = true})

      -- Remap <C-f> and <C-b> to scroll float windows/popups
      ---@diagnostic disable-next-line: redefined-local
      local opts = {silent = true, nowait = true, expr = true}
      keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
      keyset("i", "<C-f>",
             'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
      keyset("i", "<C-b>",
             'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
      keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

      -- Use CTRL-S for selections ranges
      -- Requires 'textDocument/selectionRange' support of language server
      keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
      keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})

      -- Add `:Format` command to format current buffer
      vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

      -- " Add `:Fold` command to fold current buffer
      vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

      -- Add `:OR` command for organize imports of the current buffer
      vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

      -- Add (Neo)Vim's native statusline support
      -- NOTE: Please see `:h coc-status` for integrations with external plugins that
      -- provide custom statusline: lightline.vim, vim-airline
      vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

      -- Mappings for CoCList
      -- code actions and coc stuff
      ---@diagnostic disable-next-line: redefined-local
      local opts = {silent = true, nowait = true}
      -- Show all diagnostics
      keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
      -- Manage extensions
      keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
      -- Show commands
      keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
      -- Find symbol of current document
      keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
      -- Search workspace symbols
      keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
      -- Do default action for next item
      keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
      -- Do default action for previous item
      keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
      -- Resume latest coc list
      keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)

      -- Python specific
      keyset("n", "<leader>i", ":CocCommand python.sortImports<CR>", opts)
    end,
  },

  -- DAP (Debug Adapter Protocol)
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup()

      -- Python setup
      require('dap-python').setup('python')

      -- Automatically open UI
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },

  -- Language specific plugins
  {
    'lervag/vimtex',
    ft = { 'tex', 'latex' },
    config = function()
      vim.g.tex_flavor = 'latex'
    end,
  },

  {
    'hashivim/vim-terraform',
    ft = { 'terraform', 'tf', 'terraform-vars' },
  },

  {
    'rcmdnk/vim-markdown',
    ft = { 'markdown', 'md' },
    dependencies = {
      'joker1007/vim-markdown-quote-syntax',
    },
    config = function()
      vim.g.vim_markdown_liquid = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_json_frontmatter = 1
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_better_folding = 1
      vim.g.vim_markdown_folding_level = 6
      vim.g.vim_markdown_emphasis_multiline = 0

      -- Set markdown filetype for txt and text files
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = { '*.txt', '*.text', '*.html' },
        command = 'setlocal filetype=markdown',
      })
    end,
  },
} 