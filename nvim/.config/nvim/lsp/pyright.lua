return {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'pyrightconfig.json', '.git' },
    settings = {
        -- ruff sorts imports.
        pyright = { disableOrganizeImports = true },
        python = { analysis = { diagnosticMode = 'openFilesOnly' } },
    },
    -- Pick up uv's project venv without having to activate it first.
    before_init = function(_, config)
        local python = config.root_dir and config.root_dir .. '/.venv/bin/python'
        if python and vim.uv.fs_stat(python) then
            config.settings.python.pythonPath = python
        end
    end,
}
