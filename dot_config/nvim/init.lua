-- enable experimental lua-loader with byte-compilation and caching
vim.loader.enable()

-- require local submodules
require "options"
require "autocmds"
require "mappings"
require "pluginmanager"
require "lsp"
require "diagnostics"
