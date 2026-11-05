local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<cr>')

for _, dir in ipairs({ 'h', 'j', 'k', 'l' }) do
    map('n', '<C-' .. dir .. '>', '<C-w>' .. dir)
end

local function pum_or(key, fallback)
    return function()
        return vim.fn.pumvisible() == 1 and key or fallback
    end
end
map('i', '<Tab>', pum_or('<C-n>', '<Tab>'), { expr = true })
map('i', '<S-Tab>', pum_or('<C-p>', '<S-Tab>'), { expr = true })
