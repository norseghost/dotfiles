local function lsp_highlight_document(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        --[[ if client.supports_method("textDocument/documentHighlight") then ]]
        vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = false
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = "lsp_document_highlight",
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end
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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        -- extend triggerCharacters so completion fires more aggressively
        if client.server_capabilities.completionProvider then
            local cp = client.server_capabilities.completionProvider
            cp.triggerCharacters = cp.triggerCharacters or {}
            -- add any characters you want to trigger on; empty string fires on every key
            vim.list_extend(cp.triggerCharacters, { ".", ":", "-", " " })
        end
        lsp_autoformat(client, ev.buf)
        lsp_highlight_document(client, ev.buf)
        -- enable lsp completion
        vim.lsp.completion.enable(
            true, client.id, ev.buf, { autotrigger = true }
        )
    end,
})

vim.lsp.set_log_level("DEBUG")
-- enable configured language servers
-- you can find server configurations from lsp/*.lua files
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

if not is_windows then
    vim.lsp.enable(
        "ansible_language_server"
    )
end
vim.lsp.enable({
    "lua_ls",
    "bashls",
    "basics_ls",
    "clangd",
    "docker_compose_language_service",
    "marksman",
    "openscad_lsp",
    "pylsp",
})
