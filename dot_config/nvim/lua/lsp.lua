local lsp_autoformat = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        local group = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
            desc = "LSP format on save",
        })
    end
end
local function buffer_lang(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 10, false)
    for _, l in ipairs(lines) do
        local lang = l:match("^lang:%s*(%S+)")
        if lang then return lang end
    end
end
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = false }),
    callback = function(ev)
        vim.lsp.on_type_formatting.enable()
        vim.keymap.set("n", "grc", function()
            vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
        end, { desc = "Toggle codelens" })
        vim.lsp.inlay_hint.enable()
        vim.lsp.linked_editing_range.enable()
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method("textDocument/completion") then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
        end
        lsp_autoformat(client, ev.buf)
        -- lsp_highlight_document(client, ev.buf)
        if client.name == "harper_ls" or client.name == "vale_ls" then
            local lang = buffer_lang(ev.buf)
            if lang == "da-DK" then
                vim.schedule(function()
                    client:stop()
                end)
            end
        end
    end,
})
-- vim.lsp.set_log_level("DEBUG")
