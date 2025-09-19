-- init.lua - Keep this clean with only general Neovim settings
-- set tab width --
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

-- Show absolute line number for current line, relative for others
vim.opt.number = true
vim.opt.relativenumber = true

-- Use system clipboard for yank/paste
vim.opt.clipboard = "unnamedplus"

-- Indent in visual mode with Tab / Shift-Tab
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })

-- install package manager (lazy) if not available --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- This will automatically load all files in the plugins/ directory
require("lazy").setup("plugins")
