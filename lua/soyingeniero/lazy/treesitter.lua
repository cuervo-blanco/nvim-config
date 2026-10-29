return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vimdoc", "javascript", "typescript", "c", "lua", "rust",
                    "jsdoc", "bash", "cpp", "cmake", "python", "query",
                },

                sync_install = false,

                auto_install = true,

                indent = {
                    enable = true
                },

                highlight = {
                    enable = true,

                    additional_vim_regex_highlighting = { "markdown" },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            max_lines = 3,
            separator = "─",
        },
        config = function(_, opts)
            require("treesitter-context").setup(opts)
            vim.keymap.set("n", "<leader>tC", "<cmd>TSContext toggle<CR>", {
                desc = "Toggle code context",
            })
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufNewFile" },
    },
}
