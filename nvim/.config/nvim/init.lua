-- =========================================================
-- 1. Core Settings & Keymaps
-- =========================================================
-- Note: Mapleader MUST be set before lazy.nvim loads!
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core options
require('config.options')
require('config.keymaps')
require('config.autocmds')

-- =========================================================
-- 2. Bootstrap lazy.nvim
-- =========================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- =========================================================
-- 3. Start Lazy and load all plugins
-- =========================================================
require("lazy").setup("plugins", {
    rocks = {
        enabled = false,
    },
    ui = {
        border = "rounded",
    },
})

-- =========================================================
-- 4. Project Specific Configuration
-- =========================================================
local local_config = vim.fn.getcwd() .. '/init_local.lua'
if (vim.uv or vim.loop).fs_stat(local_config) then
    dofile(local_config)
end
