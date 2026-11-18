-- Running devcontainer for this project (`devc up`), or nil. Same lookup as bin/devc.
local function devcontainer(root)
    local folder = root and vim.fs.root(root, { '.devcontainer', '.devcontainer.json' })
    if not folder or vim.fn.executable('podman') == 0 then
        return nil
    end
    local ps = vim.system({ 'podman', 'ps', '-q', '--filter', 'label=devcontainer.local_folder=' .. folder }):wait()
    if ps.code == 0 and ps.stdout ~= '' then
        return folder
    end
end

return {
    -- Inside a devcontainer, clangd uses its toolchain and headers. `devcontainer exec` starts
    -- in the container workspace, so $PWD is the target of the host->container path mapping.
    cmd = function(dispatchers, config)
        local argv = { 'clangd' }
        local folder = devcontainer(config.root_dir)
        if folder then
            argv = {
                'devcontainer', 'exec', '--workspace-folder', folder,
                'sh', '-c', 'exec clangd --path-mappings="$0=$PWD"', folder,
            }
        end
        return vim.lsp.rpc.start(argv, dispatchers, {
            cwd = config.cmd_cwd,
            env = config.cmd_env,
            detached = config.detached,
        })
    end,
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
