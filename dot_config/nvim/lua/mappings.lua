local util = require("util")

local opts = { silent = true }
local term_opts = { silent = true }

vim.g.mapleader = " "
vim.g.maplocallleader = ";"

-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

---- toggle options
vim.keymap.set("n", "<leader>ts", function() util.toggle("spell") end, { desc = "Toggle Spelling" })
vim.keymap.set("n", "<leader>tw", function() util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
vim.keymap.set("n", "<leader>tn", function() util.toggle("relativenumber") util.toggle("number") end,
    { desc = "Toggle Line Numbers" })
vim.keymap.set("n", "<leader>td", util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
vim.keymap.set("n", "<leader>tc", function() util.toggle("conceallevel", false, { 0, conceallevel }) end,
    { desc = "Toggle Conceal" })
-- TODO: write function to toggle these
keymap("n", "<leader>te", "<cmd>setlocal spell! spelllang-=en spelllang+=da<cr>",
    util.add_desc(opts, "Set Danish Spell Check"))
keymap("n", "<leader>tE", "<cmd>setlocal spell!  spelllang-=da spelllang+=en<cr>",
    util.add_desc(opts, "Set English Spell Check"))
-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-l>", ":bnext<CR>", opts)
keymap("n", "<A-h>", ":bprevious<CR>", opts)



-- Wrapped lines j/k goes down to wrap instead of new line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "^", "g^", opts)
keymap("n", "$", "g$", opts)

-- no Ex mode
keymap("n", "Q", "", opts)

-- save quickly

keymap("n", "!", ":!", opts)

vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>", util.add_desc(opts, "Save"))
vim.keymap.set("n", "<leader>q", "<cmd>q!<CR>", util.add_desc(opts, "Close Window"))
vim.keymap.set("n", "<leader>Q", "<cmd>wqa!<CR>", util.add_desc(opts, "Exit NeoVim"))
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR><esc>",
    util.add_desc(opts, "Clear search highlight when entering normal mode"))
vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })
-- Insert --

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


-- Wrapped lines j/k goes down to wrap instead of new line
keymap("v", "j", "gj", opts)
keymap("v", "k", "gj", opts)
keymap("v", "^", "^j", opts)
keymap("v", "$", "$j", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Command --
-- Menu navigation
keymap("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
keymap("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- change word with <c-c>
vim.keymap.set("n", "<C-c>", "<cmd>normal! ciw<cr>a")

vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")
keymap("i", "<c-s>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts)
keymap("n", "<c-s>", "[s1z=<c-o>", opts)
-- makes * and # work on visual mode too.
vim.cmd([[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction
  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]])
