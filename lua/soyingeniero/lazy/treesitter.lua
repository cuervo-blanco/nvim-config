return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- `master` is archived for Neovim 0.11. Neovim 0.12 requires the
        -- rewritten `main` branch; mixing the two causes nil-node crashes
        -- such as "attempt to call method 'range'" in injected languages.
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter")

            treesitter.setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            treesitter.install({
                "bash", "c", "cmake", "cpp", "css", "html", "javascript",
                "jsdoc", "json", "lua", "markdown", "markdown_inline", "python",
                "query", "rust", "toml", "typescript", "vim", "vimdoc", "yaml",
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    -- Tree-sitter highlighting belongs to Neovim 0.12 itself.
                    -- A missing parser should not prevent a buffer from opening.
                    pcall(vim.treesitter.start, args.buf)
                end,
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "c", "cpp", "lua", "python", "rust" },
                callback = function(args)
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
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
