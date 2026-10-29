return {
    {
        "nwiizo/codex.nvim",
        event = "VeryLazy",
        cmd = {
            "Codex",
            "CodexOpen",
            "CodexFocus",
            "CodexClose",
            "CodexAsk",
            "CodexAskVisual",
            "CodexEdit",
            "CodexSend",
            "CodexSendVisual",
            "CodexAdd",
            "CodexDiff",
            "CodexReview",
            "CodexResume",
            "CodexContinue",
            "CodexStop",
            "CodexStatus",
            "CodexHealth",
        },
        keys = {
            { "<leader>ox", "<cmd>CodexFocus<CR>", desc = "Focus or hide Codex" },
            { "<leader>ob", "<cmd>CodexAdd<CR>", desc = "Add buffer to Codex" },
            {
                "<leader>os",
                ":<C-U>CodexSendVisual<CR>",
                mode = "x",
                desc = "Send selection to Codex",
            },
        },
        opts = {
            cwd = "root",
            terminal = {
                layout = "split",
                split_side = "right",
                split_width_percentage = 0.35,
            },
            selection = {
                keymaps = {
                    ask = "<leader>oa",
                    edit = "<leader>oe",
                },
            },
        },
    },
}
