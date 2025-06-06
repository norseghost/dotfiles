local words_da = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/da.utf-8.add", "r"):lines() do
    table.insert(words_da, word)
end
for word in io.open(vim.fn.stdpath("config") .. "/spell/da.utf-8.spl", "r"):lines() do
    table.insert(words_da, word)
end
local opts = {
    settings = {
        ltex = {
            language = "da-DK",
            dictionary = {
                ["da-DK"] = words_da,

            }
        },
    },
}

return opts
