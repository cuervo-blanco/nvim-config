return {
    {
        "Bekaboo/deadcolumn.nvim",
        event = "VeryLazy",
        config = function()
            require("deadcolumn").setup({
                scope = "line",
                modes = function(mode)
                    return mode:find("^[iR]") ~= nil
                end,
                blending = {
                    threshold = 0.85,
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = false,
                theme = "auto",
                component_separators = "",
                section_separators = "",
                disabled_filetypes = {
                    statusline = { "NvimTree", "vista", "dbui", "packer", "qf", "help" },
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    { "filename", path = 0 },
                },
                lualine_c = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        sections = { "error", "warn" },
                        symbols = { error = "E:", warn = "W:" },
                    },
                    function()
                        local names = {}
                        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                            names[#names + 1] = client.name
                        end
                        return table.concat(names, ", ")
                    end,
                },
                lualine_x = { "branch" },
                lualine_y = { "fileformat" },
                lualine_z = { "location" },
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            current_line_blame = false,
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
            win = { border = "rounded" },
        },
    },
    {
        "davidgranstrom/scnvim",
        ft = { "supercollider" },
        config = function()
            local scnvim = require("scnvim")
            local map = scnvim.map

            scnvim.setup({
                ensure_installed = false,
                keymaps = {
                    ["<leader>st"] = map("sclang.start"),
                    ["<leader>sk"] = map("sclang.recompile"),
                    ["<leader>sl"] = map("editor.send_line", { "n", "i" }),
                    ["<leader>sb"] = map("editor.send_block", { "n", "i" }),
                    ["<leader>sp"] = map("postwin.toggle"),
                },
                postwin = {
                    float = {
                        enabled = true,
                    },
                },
            })
        end,
    },
}
