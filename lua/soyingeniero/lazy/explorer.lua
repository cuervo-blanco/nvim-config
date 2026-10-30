return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        -- Neo-tree must load before VimEnter to replace netrw for `nvim .`.
        lazy = false,
        cmd = "Neotree",
        init = function()
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    local directory = vim.fn.argv(0)
                    if vim.fn.isdirectory(directory) == 0 then
                        return
                    end

                    vim.schedule(function()
                        vim.cmd("Neotree show filesystem dir=" .. vim.fn.fnameescape(directory))
                    end)
                end,
            })
        end,
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
                hijack_netrw_behavior = "open_default",
                use_libuv_file_watcher = true,
            },
            window = {
                position = "left",
                width = 32,
            },
        },
    },
}
