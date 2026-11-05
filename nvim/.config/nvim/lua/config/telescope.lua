local telescope = require('telescope')
local builtin = require('telescope.builtin')

-- Search dotfiles too, but never inside .git.
telescope.setup({
    defaults = {
        sorting_strategy = 'ascending',
        layout_config = { prompt_position = 'top' },
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename', '--line-number',
            '--column', '--smart-case', '--hidden', '--glob=!**/.git/*',
        },
    },
    pickers = {
        find_files = { find_command = { 'fd', '--type=file', '--hidden', '--exclude=.git' } },
    },
})
telescope.load_extension('fzf')

local function map(lhs, picker, desc, mode)
    vim.keymap.set(mode or 'n', lhs, picker, { desc = desc })
end

map('<leader>ff', builtin.find_files, 'Find files')
map('<leader>fg', builtin.live_grep, 'Live grep')
map('<leader>fw', builtin.grep_string, 'Grep word or selection', { 'n', 'x' })
map('<leader>fb', builtin.buffers, 'Buffers')
map('<leader>fo', builtin.oldfiles, 'Recent files')
map('<leader>fh', builtin.help_tags, 'Help')
map('<leader>fr', builtin.resume, 'Resume last picker')
map('<leader>fd', builtin.diagnostics, 'Diagnostics')
map('<leader>fs', builtin.lsp_document_symbols, 'Document symbols')
map('<leader>fS', builtin.lsp_dynamic_workspace_symbols, 'Workspace symbols')
map('<leader>/', builtin.current_buffer_fuzzy_find, 'Search buffer')
map('<leader>gl', builtin.git_commits, 'Git log')
map('<leader>gL', builtin.git_bcommits, 'Git log (buffer)')
map('<leader>gb', builtin.git_branches, 'Git branches')
