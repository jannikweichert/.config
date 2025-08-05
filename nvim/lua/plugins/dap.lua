return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, o)
          o.ensure_installed = o.ensure_installed or {}
          table.insert(o.ensure_installed, "js-debug-adapter")
        end,
      },
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    opts = function()
      local dap = require("dap")
      local mason = require("mason-registry")
      local js_dbg = mason.get_package("js-debug-adapter"):get_install_path() .. "/js-debug/src/dapDebugServer.js"

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = { command = "node", args = { js_dbg, "${port}" } },
      }
      dap.adapters["pwa-chrome"] = dap.adapters["pwa-node"]

      local langs = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }
      for _, ft in ipairs(langs) do
        dap.configurations[ft] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Node",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach Node",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome",
            url = "http://localhost:4200",
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
          {
            type = "pwa-chrome",
            request = "attach",
            name = "Attach Chrome",
            port = 9222,
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
        }
      end
    end,
    init = function()
      -- Setup DAP UI listeners properly
      local dap, dapui = require("dap"), require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized.dapui = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui = function()
        dapui.close()
      end
    end,
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Debug Continue",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Debug REPL",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle Debug UI",
      },
    },
  },
}
