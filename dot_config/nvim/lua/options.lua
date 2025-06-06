--- GENERAL
local o = vim.opt

o.hidden = true    -- don't unload abandoned buffers
o.updatetime = 100 -- time in ms with no activity before swap file is written to disk
o.timeoutlen = 400 -- time in ms to wait for a mapped sequence to complete
o.clipboard = {
    "unnamed",     -- use system clipboard
    "unnamedplus"  -- for all purposes
}
o.backup = true    -- backups are nice ...
o.backupdir = vim.fn.expand(vim.fn.stdpath("state") .. "/backup/")
o.undofile = true  -- so is persistent undo ...
o.undolevels = 250 -- maximum number of changes that can be undone
o.undoreload = 500 -- maximum number lines to save for undo on a buffer reload
o.sessionoptions = {
    "blank",
    "buffers",
    "curdir",
    "folds",
    "help",
    "tabpages",
    "winsize",
    "winpos",
    "terminal",
}
---- UI
o.termguicolors = true
o.cmdheight = 1
o.laststatus = 3
o.mouse = "a"          -- enable mouse
o.cursorline = true    -- highlight current line
o.cursorcolumn = false -- highlight current column
o.colorcolumn = {
    "+5"               -- set colorcolumn at &textwidth +5
}
o.scrolloff = 0
o.title = true -- populate window title
o.showmode = false -- no message when in insert, replace or visual mode
o.showcmd = false -- don't show the last command
o.showtabline = 1 -- show tabline if more than one tab
o.equalalways = false -- do not resize windows when splits are created or destroyed
o.splitright = true -- default to opening vsplits to the right
o.splitkeep = "screen" -- keep text on same screen line when resizing horizontal splits
o.wildmode = "full" -- command <tab> completion, list matches, then longest common part, then all.
o.wildignorecase = true -- case insensitive command mode completion
-- gutter
o.number = true -- show line numbers
o.relativenumber = true -- line numbers count from current line
o.signcolumn = "auto:5" -- show signcolumn in number column
-- whitespace
o.list = true -- show whitespace
o.listchars = {
    nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    tab = "▷┅", -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
    -- + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505 UTF-8: E2 94 85)
    extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    trail = "•", -- BULLET (U+2022 UTF-8: E2 80 A2)
}
o.fillchars = {
    diff = "∙", -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    fold = "·", -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    vert = "┃", -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
    eob = " ", -- suppress ~ at EndOfBuffer
}
---- EDITING
o.autoread = true  -- automatically read changed files
o.autowrite = true -- save current buffer on buffer change
o.confirm = true   -- confirm saving changes instead of throwing an error
o.virtualedit = {
    "block"        -- allow selection outside characters in visual block mode
}
-- spelling
o.spell = true  -- enable spellcheck
o.spelllang = { -- which languages to spellcheck
    "en",
    --[[ "da" ]]
}
o.spellcapcheck = "" -- don't highlight uncapitalised first word
o.spelloptions = "noplainbuffer"
-- folds
o.foldenable = true   -- allow code to be folded
o.foldlevelstart = 99 -- start unfolded
o.foldmethod = "expr" -- use tree-sitter for folding method
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- tabs
o.tabstop = 4    -- <tab> counts for 4 spaces
o.shiftwidth = 4 -- number of spaces for (auto)indent
o.expandtab = true
-- formatting
o.autoindent = true -- copy indent from previous line
o.formatoptions = {
    c = true,       -- auto wrap comments using textwidth
    r = true,       -- <cr> autoinserts current comment leader in insert mode
    o = true,       -- <o>/<O> autoinserts current comment leader in normal mode
    q = true,       -- format comments with <gq>
    j = true,       -- remove comment leader when joining lines
}
o.textwidth = 74
-- lists
--[[ TODO: how to translate vim scoped regexes to lua
o.formatlistpat = {
   ['^\s*]                     -- Optional leading whitespace
   ['[']                        -- Start character class
   ['\[({]\?']                -- |  Optionally match opening punctuation
   ['\(']                      -- |  Start group
   ['[0-9]\+']                 -- |  |  Numbers
   ['\\|']                     -- |  |  or
   ['[a-zA-Z]\+']              -- |  |  Letters
   ['\)']                      -- |  End group
   ['[\]:.)}']                 -- |  Closing punctuation
   [']']                        -- End character class
   ['\s\+']                   -- One or more spaces
   ['\\|']                     -- or
   ['^\s*[-–+o*•]\s\+']      -- Bullet points
} --]]
-- search
o.grepprg = "rg --vimgrep" -- use ripgrep in vim
o.ignorecase = true        -- case insensitive search
o.smartcase = true         -- unless there is uppercase
o.incsearch = true         -- show matches in realtime
o.hlsearch = true          -- highlight search results
-- completion
o.completeopt = {
    "menu",    -- show completion menu
    "menuone", -- even if there is only one match
    "popup",   -- popup window
    "fuzzy",   -- enable fuzzy search
}
-- text wrapping
o.wrap = false       -- wrap lines by default
o.linebreak = true   -- wrap at word boundaries
o.breakindent = true -- keep indentation level when breaking lines
-- movement
o.whichwrap = {
    -- which movement keys cross line boundaries
    b = true, -- backspace
    s = true, -- space
    h = true,
    l = true,
    ["~"] = true,
    ["<"] = true, -- arrows
    [">"] = true, -- normal/visual
    ["["] = true, -- arrows
    ["]"] = true, -- insert/replace
}
o.thesaurus = vim.fn.expand(vim.fn.stdpath("data") .. "/spell/mthesaur.txt")
if vim.fn.executable("rg") == 1 then
    -- Set RipGrep as the default grep program (if it exists)
    o.grepprg = "rg --vimgrep -H --no-heading --column --smart-case -P"
    o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
--- diagnostics ---
vim.diagnostic.config({
    virtual_text = true,
    -- current_line = true,
    virtual_lines = {
        current_line = true,
    },
});
