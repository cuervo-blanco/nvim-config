return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "storm",
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.o.background = "dark"
            vim.cmd.colorscheme("tokyonight-storm")
        end,
    },
}
