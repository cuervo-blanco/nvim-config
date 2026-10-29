local site_path = vim.fn.stdpath("data") .. "/site"
vim.opt.packpath:remove(site_path)
vim.opt.rtp:remove(site_path)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
        "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "soyingeniero.lazy",
    change_detection = { notify = false },
    rocks = { enabled = false },
    {"neovim/nvim-lspconfig"},
    {"nvim-neotest/nvim-nio"}
})
