vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('config.options')
require('config.keymaps')
require('config.plugins')
require('config.colors')
require('config.treesitter')
require('config.telescope')
require('config.git')
require('config.statusline')
require('config.lsp')
