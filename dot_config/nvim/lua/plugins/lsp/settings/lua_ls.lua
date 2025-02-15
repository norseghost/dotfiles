return {
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                    quote_style = "double"
                }
            },
            diagnostics = {
                neededFileStatus = {
                    ["codestyle-check"] = "Any",
                },
            },
            -- completion = {
            --     callSnippet = "Replace"
            -- },
            -- workspace = {
            --     checkThirdParty = false, -- THIS IS THE IMPORTANT LINE TO ADD
            -- },
        },
    }
}
