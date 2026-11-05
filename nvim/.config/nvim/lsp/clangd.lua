return {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt', '.git' },
    on_attach = function(client, bufnr)
        vim.keymap.set('n', '<leader>ch', function()
            local params = vim.lsp.util.make_text_document_params(bufnr)
            client:request('textDocument/switchSourceHeader', params, function(err, uri)
                if err or not uri then
                    return vim.notify('No matching source/header', vim.log.levels.WARN)
                end
                vim.cmd.edit(vim.uri_to_fname(uri))
            end, bufnr)
        end, { buffer = bufnr, desc = 'Switch source/header' })
    end,
}
