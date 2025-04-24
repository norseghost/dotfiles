local servers = {
    "lua_ls",
    "bashls",
    "docker_compose_language_service",
    "dockerls",
    "powershell_es",
    "texlab", -- latex syntax
    "vimls",
    "html",
    "jsonls",
    "clangd",
    "yamlls",
    "pylsp",
    "prosemd_lsp",
    "nginx_language_server",
    "typos_lsp",
    "r_language_server"
}

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local set_opts = function(server)
    local opts = {
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities,
    }
    if server == "jsonls" then
        local jsonls_opts = require("plugins.lsp.settings.jsonls")
        opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end
    if server == "ltex" then
        local ltex_opts = require("plugins.lsp.settings.ltex")
        opts = vim.tbl_deep_extend("force", ltex_opts, opts)
    end
    if server == "pylsp" then
        local pylsp_opts = require("plugins.lsp.settings.pylsp")
        opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
    end
    if server == "lua_ls" then
        require("neodev").setup()
        local lua_opts = require("plugins.lsp.settings.lua_ls")
        opts = vim.tbl_deep_extend("force", lua_opts, opts)
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    return opts
end


for _, server in ipairs(servers) do
    require "lspconfig"[server].setup(
        set_opts(server)
    )
end
-- local lsp = require("lspconfig")
--
-- lsp.citation_ls.setup({
--     settings = {
--         citation = {
--             bibliographies = {
--                 "~/Sites/martinandreasandersen.com/_bibliography/references.bib"
--             }
--         }
--     }
-- })
