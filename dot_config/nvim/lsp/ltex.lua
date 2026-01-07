local function read_words(path)
  local words = {}
  local f = io.open(path, "r")
  if not f then
    return words
  end
  for line in f:lines() do
    table.insert(words, line)
  end
  f:close()
  return words
end

local config_dir = vim.fn.stdpath("config")

local da_words = read_words(config_dir .. "/spell/da.utf-8.add")
local en_words = read_words(config_dir .. "/spell/en.utf-8.add")

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
