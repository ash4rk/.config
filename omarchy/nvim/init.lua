-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Remove <D-Space> on changing language
vim.keymap.set({"n", "i"}, "<D-Space>", "<Nop>", {noremap = true, silent = true})

-- Pretty log colorizer
vim.cmd [[
call plug#begin()
Plug 'MTDL9/vim-log-highlighting'
call plug#end()
]]

-- Ctrl+Backspace deletes word backward in insert mode
vim.keymap.set('i', '<C-BS>', '<C-w>', { noremap = true })
vim.keymap.set('i', '<C-H>', '<C-w>', { noremap = true })  -- Some terminals send Ctrl+H for Ctrl+Backspace

-- Ctrl+Delete deletes word forward in insert mode
vim.keymap.set('i', '<C-Del>', '<C-o>dw', { noremap = true })

-- Save file: Space + f + s
vim.keymap.set('n', '<leader>fs', ':w<CR>', { noremap = true })
