return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local diagnostic_float_win
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )
        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",
                "gopls",
                "lua_ls",
                "rust_analyzer",
            },
            automatic_enable = false,
        })

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                    }
                }
            }
        })

        vim.lsp.config("clangd", {
            on_attach = function(client, bufnr)
                client.server_capabilities.signatureHelpProvider = false
                vim.keymap.set("n", "<leader>sh", "<cmd>LspClangdSwitchSourceHeader<CR>", {
                    buffer = bufnr,
                    desc = "Switch source/header",
                })
            end,
            cmd = { "clangd",
                    "--compile-commands-dir=build",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "-j4",
                    "--fallback-style=llvm",
            },
        })

        vim.lsp.config("gopls", {
            cmd = { "gopls", "serve" },
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                },
            },
        })

        vim.lsp.enable("clangd")
        vim.lsp.enable("gopls")
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("rust_analyzer")

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            virtual_text = false,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
            signs = true,
            underline = true,
            update_in_insert = false,
        })

        local function close_diagnostic_float()
            if diagnostic_float_win and vim.api.nvim_win_is_valid(diagnostic_float_win) then
                vim.api.nvim_win_close(diagnostic_float_win, true)
            end
            diagnostic_float_win = nil
        end

        local function open_diagnostic_float()
            if vim.bo.buftype ~= "" then
                close_diagnostic_float()
                return
            end

            local diagnostics = vim.diagnostic.get(0, {
                lnum = vim.api.nvim_win_get_cursor(0)[1] - 1,
            })

            if vim.tbl_isempty(diagnostics) then
                close_diagnostic_float()
                return
            end

            close_diagnostic_float()

            local _, winid = vim.diagnostic.open_float(nil, {
                focus = false,
                scope = "cursor",
                close_events = {
                    "BufHidden",
                    "BufLeave",
                    "CursorMoved",
                    "CursorMovedI",
                    "InsertEnter",
                    "WinLeave",
                },
            })

            diagnostic_float_win = winid
        end

        local diagnostic_float_group = vim.api.nvim_create_augroup("soyingeniero-diagnostic-float", {
            clear = true,
        })

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = diagnostic_float_group,
            callback = open_diagnostic_float,
        })

        vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave", "InsertEnter", "WinLeave" }, {
            group = diagnostic_float_group,
            callback = close_diagnostic_float,
        })
    end
}
