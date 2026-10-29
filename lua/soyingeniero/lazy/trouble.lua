return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false,
            })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end)

            vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle pinned=true win.relative=win win.position=right<CR>", {
                desc = "Toggle document symbols",
            })

            vim.keymap.set("n", "[t", function()
                require("trouble").next({skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "]t", function()
                require("trouble").prev({skip_groups = true, jump = true});
            end)

        end
    },
}
