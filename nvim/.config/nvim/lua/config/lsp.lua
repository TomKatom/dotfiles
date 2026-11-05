-- Server configs live in ../../lsp/<name>.lua; the binaries come from packages.txt.
vim.lsp.enable({ 'bashls', 'clangd', 'jsonls', 'lua_ls', 'pyright', 'ruff', 'yamlls' })

local severity = vim.diagnostic.severity
vim.diagnostic.config({
    severity_sort = true,
    virtual_text = { source = 'if_many' },
    float = { source = 'if_many' },
    signs = {
        text = {
            [severity.ERROR] = '󰅚',
            [severity.WARN] = '󰀪',
            [severity.INFO] = '󰋽',
            [severity.HINT] = '󰌶',
        },
    },
})

-- Built-in defaults already cover K, grn, gra, grr, gri, grt, gO, <C-s> and [d/]d.
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { buffer = ev.buf, desc = desc })
        end

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf)
            local complete = vim.bo[ev.buf].complete
            if not complete:find('^o') then
                vim.bo[ev.buf].complete = 'o,' .. complete
            end
        end

        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('<leader>cf', vim.lsp.buf.format, 'Format buffer')
        map('<leader>ti', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
        end, 'Toggle inlay hints')
    end,
})
