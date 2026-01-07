return {
    filetypes = { "markdown", "text", "tex", "org" },
    settings = {
        ltex = {
            language = "auto",          -- EN + DA, works well enough
            completionEnabled = true,
            checkFrequency = "on-type", -- DO NOT do on-type; too noisy
            additionalRules = {
                enablePickyRules = false,
            },
            dictionaryDirectory = vim.fn.stdpath("config") .. "/ltex-dict",
        },
    },
}
