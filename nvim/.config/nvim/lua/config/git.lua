local gitsigns = require('gitsigns')

gitsigns.setup({
    on_attach = function(bufnr)
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- In diff mode ]c/[c keep their built-in meaning.
        local function nav(key, direction)
            return function()
                if vim.wo.diff then
                    vim.cmd.normal({ key, bang = true })
                else
                    gitsigns.nav_hunk(direction)
                end
            end
        end

        local function selection(action)
            return function()
                action({ vim.fn.line('.'), vim.fn.line('v') })
            end
        end

        map('n', ']c', nav(']c', 'next'), 'Next hunk')
        map('n', '[c', nav('[c', 'prev'), 'Previous hunk')
        map('n', '<leader>hs', gitsigns.stage_hunk, 'Stage hunk')
        map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset hunk')
        map('x', '<leader>hs', selection(gitsigns.stage_hunk), 'Stage selection')
        map('x', '<leader>hr', selection(gitsigns.reset_hunk), 'Reset selection')
        map('n', '<leader>hp', gitsigns.preview_hunk_inline, 'Preview hunk')
        map('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end, 'Blame line')
        map('n', '<leader>hd', gitsigns.diffthis, 'Diff against index')
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Toggle line blame')
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Hunk')
    end,
})

vim.keymap.set('n', '<leader>gg', '<cmd>Git<cr>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gB', '<cmd>Git blame<cr>', { desc = 'Git blame' })
