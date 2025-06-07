local add_desc = require("util").add_desc
-- local show_in_preview = require("util.helpers").show_in_preview

local M = {}

local hover_preview = function(_, result, ctx, config)
    local config = config or {}
    local client_id = ctx.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local client_name = client and client.name or string.format("id=%d", client_id)
    if not (result and result.contents) then
        vim.notify("No information available")
        return
    end
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
    if vim.tbl_isempty(markdown_lines) then
        vim.notify("No information available")
        return
    end
    vim.cmd("silent! pedit! " .. vim.fn.expand("<cword>"))
    local get_preview_window = function()
        local windows = vim.api.nvim_list_wins()
        for i, win in ipairs(windows) do
            if vim.wo[win].previewwindow then
                return win
            end
        end
    end
    local winnr = get_preview_window()
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    vim.wo[winnr].number = false
    vim.wo[winnr].relativenumber = false
    vim.wo[winnr].spell = false
    vim.wo[winnr].wrap = true
    vim.wo[winnr].conceallevel = 3
    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].buflisted = false
    vim.bo[bufnr].bufhidden = "wipe"
    vim.bo[bufnr].swapfile = false
    vim.bo[bufnr].filetype = "markdown"



    local styled_md = vim.lsp.util.stylize_markdown(bufnr, markdown_lines, {})
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, styled_md)
end

vim.lsp.handlers["textDocument/hover"] = hover_preview
M.setup = function()


    local config = {
        -- disable virtual text
        virtual_text = true,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
end

local function toggle_inlay_hint()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

local function format_range_operator()
    local old_func = vim.go.operatorfunc
    _G.op_func_formatting = function()
        local start = vim.api.nvim_buf_get_mark(0, "[")
        local finish = vim.api.nvim_buf_get_mark(0, "]")
        vim.lsp.buf.range_formatting({}, start, finish)
        vim.go.operatorfunc = old_func
        _G.op_func_formatting = nil
    end
    vim.go.operatorfunc = "v:lua.op_func_formatting"
    vim.api.nvim_feedkeys("g@", "n", false)
end

local function lsp_keymaps(client, bufnr)
    local map = vim.keymap.set
    local opts = { silent = true, buffer = bufnr }
    if client.server_capabilities.declarationProvider then
        map("n", "gD", vim.lsp.buf.declaration, add_desc(opts, "Go to declaration"))
    end
    map("n", "gd", vim.lsp.buf.definition, add_desc(opts, "Go to definition"))
    map("n", "gi", vim.lsp.buf.implementation, add_desc(opts, "Go to implementation"))
    -- map("n", "K", vim.lsp.buf.hover, add_desc(opts, "Show documentation"))
    map("n", "<C-k>", vim.lsp.buf.signature_help, add_desc(opts, "Show signature help"))
    -- map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- map('n', '<leader>wl', print(vim.inspect(vim.lsp.buf.list_workspace_folders)), opts)
    map("n", "gr", vim.lsp.buf.references, add_desc(opts, "List LSP references"))

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        map("n", "<leader>lf", vim.lsp.buf.format, add_desc(opts, "Format document"))
    end
    if client.server_capabilities.documentRangeFormattingProvider then
        map({ "n", "v" }, "gm", format_range_operator, add_desc(opts, "Format range"))
    end
    -- leader keymaps
    map("n", "<leader>li", "<cmd>LspInfo<cr>", add_desc(opts, "Info"))
    map("n", "<leader>ld", toggle_inlay_hint, add_desc(opts, "Toggle virtual text"))
    map("n", "<leader>ll", vim.lsp.buf.code_action, add_desc(opts, "Code Actions"))
    map("n", "<leader>lL", vim.lsp.codelens.run, add_desc(opts, "CodeLens Actions"))
    map("n", "<leader>lq", vim.diagnostic.setloclist, add_desc(opts, "Diagnostics to location list"))
    map("n", "<leader>lr", vim.lsp.buf.references, add_desc(opts, "References"))
    map("n", "<leader>lR", vim.lsp.buf.rename, add_desc(opts, "Rename"))
    map("n", "<leader>ls", vim.lsp.buf.document_symbol, add_desc(opts, "Document Symbols"))
    map("n", "<leader>lS", vim.lsp.buf.workspace_symbol, add_desc(opts, "Workspace Symbols"))
end

local autoformat = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        local g = vim.api.nvim_create_augroup("LspFormatting", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
            group = g,
            desc = "LSP format on save"
        })
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
--
-- M.on_attach = function(client, bufnr)
--     lsp_keymaps(client, bufnr)
--     require("lsp-format").on_attach(client)
--     lsp_highlight_document(client, bufnr)
--
--     if client.server_capabilities.documentSymbolProvider then
--         require("nvim-navic").attach(client, bufnr)
--     end
-- end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true)
        end
        lsp_keymaps(client, bufnr)
        require("lsp-format").on_attach(client)
        lsp_highlight_document(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end
    end
})

return M
