local da_words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/da.utf-8.add", "r"):lines() do
    table.insert(da_words, word)
end

local en_words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
    table.insert(en_words, word)
end

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
            dictionary = {
                ["en-US"] = en_words,
                ["da-DK"] = da_words,
            },
        },
    },
}
