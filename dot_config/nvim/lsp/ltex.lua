return {
    filetypes = { "markdown", "text", "tex", "org" },
    settings = {
        ltex = {
            language = "auto", -- EN + DA, works well enough
            completionEnabled = false,
            checkFrequency = "save", -- DO NOT do on-type; too noisy
            additionalRules = {
                enablePickyRules = false,
            },
        },
    },
}
