return {
    {
        "stevearc/conform.nvim",
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    objc = { "clang-format" },
                    objcpp = { "clang-format" },
                },
                format_on_save = function(bufnr)
                    local filetype = vim.bo[bufnr].filetype
                    if filetype == "c" or filetype == "cpp" or filetype == "objc" or filetype == "objcpp" then
                        return {
                            timeout_ms = 500,
                            lsp_format = "fallback",
                        }
                    end
                end,
            })

            vim.keymap.set("n", "<leader>f", function()
                conform.format({
                    async = false,
                    lsp_format = "fallback",
                })
            end, { desc = "Format buffer" })
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "jay-babu/mason-nvim-dap.nvim",
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup({
                icons = {
                    collapsed = ">",
                    current_frame = "*",
                    expanded = "v",
                },
            })

            require("nvim-dap-virtual-text").setup({
                commented = true,
                virt_text_pos = "inline",
            })

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end

            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end

            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end

            require("mason-nvim-dap").setup({
                automatic_installation = false,
                ensure_installed = { "codelldb" },
                -- Only use the adapter configured below.  An older cpptools
                -- install otherwise registers cppdbg alongside codelldb.
                handlers = {
                    codelldb = function() end,
                    cppdbg = function() end,
                },
            })

            local codelldb = vim.fn.exepath("codelldb")
            if codelldb == "" then
                local ok, registry = pcall(require, "mason-registry")
                if ok and registry.has_package("codelldb") then
                    codelldb = registry.get_package("codelldb"):get_install_path() .. "/codelldb"
                end
            end

            dap.adapters.codelldb = {
                type = "executable",
                command = codelldb ~= "" and codelldb or "codelldb",
            }

            dap.configurations.cpp = {
                {
                    name = "Launch current executable",
                    type = "codelldb",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
                    end,
                },
            }

            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<leader>dr", dap.continue, { desc = "Debug run or continue" })
            vim.keymap.set("n", "<leader>dv", "<cmd>DapVirtualTextToggle<CR>", {
                desc = "Toggle debug virtual text",
            })
        end,
    },
}
