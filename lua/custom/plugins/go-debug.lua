-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'andythigpen/nvim-coverage',
    lazy = false,
    config = function()
      require('coverage').setup {
        commands = true,
        auto_reload = true,
        virtual_text = true,
      }
    end,
  },
  {
    'nvim-neotest/neotest',
    lazy = false,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'fredrikaverpil/neotest-golang',
        dependencies = {
          'leoluz/nvim-dap-go',
        },
      },
    },

    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-golang' {
            recursive_run = true,
            testify_enabled = true,
            go_test_args = { '-v', '-coverprofile=' .. vim.fn.getcwd() .. '/coverage.out' },
          },
        },
      }
    end,

    keys = {
      {
        '<leader>tn',
        function()
          require('neotest').run.run()
        end,
        desc = 'Test nearest',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug nearest',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Test file',
      },
      {
        '<leader>ta',
        function()
          require('neotest').run.run(vim.fn.getcwd())
        end,
        desc = '[t]est [a]ll files',
      },
      { '<leader>tc', '<cmd>CoverageLoad<CR><cmd>CoverageShow<CR>', desc = 'Show test coverage' },
    },
  },
}
