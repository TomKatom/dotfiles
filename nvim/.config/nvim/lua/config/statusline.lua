-- Reuse gitsigns' counts instead of letting lualine run its own git diff.
local function gitsigns_diff()
    local status = vim.b.gitsigns_status_dict
    if status then
        return { added = status.added, modified = status.changed, removed = status.removed }
    end
end

require('lualine').setup({
    options = {
        globalstatus = true,
        component_separators = '',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_b = { 'branch', { 'diff', source = gitsigns_diff }, 'diagnostics' },
        lualine_x = { 'filetype' },
    },
})
