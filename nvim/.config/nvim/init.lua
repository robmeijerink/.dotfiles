-- =========================================================
-- 1. Core Settings & Keymaps
-- =========================================================
-- Note: Mapleader MUST be set before lazy.nvim loads!
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core options
require('config.options')

-- Load global keymaps
pcall(require, 'config.keymaps')
pcall(require, 'config.autocmds')

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
    "--branch=stable", -- Fetch the latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =========================================================
-- 3. Start Lazy and load all plugins
-- =========================================================
-- Automatically loads everything in the lua/plugins/ directory
require("lazy").setup("plugins")

-- =========================================================
-- 4. Project Specific Configuration (Rob Meijerink)
-- =========================================================
-- Retain the ability for project-local overrides
local f = io.open('./init_local.lua', 'r')
if f ~= nil then
    io.close(f)
    pcall(require, 'init_local')
end
