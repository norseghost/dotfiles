-- n: recognize numbered lists
-- 2: use the indent of the second line of a paragraph for the rest
-- t: auto-wrap text using textwidth
-- c: auto-wrap lists/comments
vim.opt_local.formatoptions = "n2tcoqj"

-- Tell Neovim what the markers are so it knows how much to indent
vim.opt_local.comments = "b:-,b:*,b:+,b:1.,n:>"

