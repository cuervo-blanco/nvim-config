return {
    {
        "coder/claudecode.nvim",
        event = "VeryLazy",
        cmd = {
            "ClaudeCode",
            "ClaudeCodeFocus",
            "ClaudeCodeAdd",
            "ClaudeCodeSend",
            "ClaudeCodeStatus",
            "ClaudeCodeOpen",
            "ClaudeCodeClose",
            "ClaudeCodeDiffAccept",
            "ClaudeCodeDiffDeny",
        },
        keys = {
            { "<leader>l", nil, desc = "Claude Code" },
            { "<leader>lc", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude" },
            { "<leader>lf", "<cmd>ClaudeCodeFocus<CR>", desc = "Focus Claude" },
            { "<leader>lb", "<cmd>ClaudeCodeAdd %<CR>", desc = "Add buffer to Claude" },
            {
                "<leader>ls",
                ":<C-U>ClaudeCodeSend<CR>",
                mode = "x",
                desc = "Send selection to Claude",
            },
        },
        opts = {
            terminal = {
                provider = "native",
            },
        },
    },
}
