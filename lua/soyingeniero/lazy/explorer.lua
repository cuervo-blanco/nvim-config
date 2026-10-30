return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            {
                "<leader>e",
                "<cmd>Neotree toggle filesystem reveal left<CR>",
                desc = "Explorer",
            },
            {
                "<leader>ge",
                "<cmd>Neotree toggle git_status float<CR>",
                desc = "Git changed files",
            },
        },
        opts = {
            close_if_last_window = true,
            filesystem = {
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
            },
            window = {
                position = "left",
                width = 32,
            },
        },
    },
}
