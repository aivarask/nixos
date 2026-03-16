vim.lsp.inlay_hint.enable(false)
local severity = {
    min = vim.diagnostic.severity.WARN,
    max = vim.diagnostic
        .severity.ERROR
}
vim.diagnostic.config({
    underline = { severity = severity },
    virtual_text = { severity = severity },
    -- virtual_lines = { severity = severity },
    virtual_lines = false,

    signs = true,
    float = {
        -- scope = 'buffer',
        -- pos = { 10, 10 },
        -- severity = severity
    },
    status = { severity = severity },
    update_in_insert = true,
    severity_sort = true,

    jump = {
        severity = severity,
        wrap = true
    },
    loclist = {
        open = false,
        severity = severity,
    },
})



vim.api.nvim_create_autocmd('CursorHold',
    {
        group = vim.api.nvim_create_augroup('diagnostic', { clear = true }),
        callback = function()
            vim.diagnostic.open_float({
                scope = 'buffer',
                close_events = { 'CursorMoved' },
                severity = severity,
                foo = '',
                pos = { 30, 30 },
                focusable = false


            })
        end,
    })

if false then
    vim.diagnostic.handlers.loclist = {
        show = function(_, _, _, opts)
            ---@diagnostic disable-next-line: undefined-field
            opts.loclist.open = opts.loclist.open or false
            local winid = vim.api.nvim_get_current_win()
            ---@diagnostic disable-next-line: undefined-field
            vim.diagnostic.setloclist(opts.loclist)
            vim.api.nvim_set_current_win(winid)
        end,
        hide = function(namespace, bufnr)

        end
    }
end
