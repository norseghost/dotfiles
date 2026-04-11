return {
    filetypes = { "markdown", "text", "tex", "org" },
    settings = {
        ltex = {
            language = "auto", -- EN + DA, works well enough
            completionEnabled = true,
            additionalRules = {
                enablePickyRules = true,
            },
            dictionary = {
                dictionary = {
                    -- Ensure these point to the .add files in your config/spell dir
                    ["da-DK"] = { ":" .. vim.fn.stdpath("config"):gsub("\\", "/") .. "/spell/da.utf-8.add" },
                    ["en-US"] = { ":" .. vim.fn.stdpath("config"):gsub("\\", "/") .. "/spell/en.utf-8.add" },
                },
            },
        }
    },
    on_attach = function(client, bufnr)
        -- Only run if the client is ltex
        if client.name == "ltex" then
            require("ltex-utils").on_attach(client, bufnr)
        end
    end,
}
