return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    -- config = function(_, opts)
    --     -- FIX 1: Explicitly use zig as the compiler
    --     require("nvim-treesitter.install").compilers = { "zig" }
    --     require("nvim-treesitter.configs").setup(opts)
    -- end,
    -- opts = {
    --     -- FIX 2: Avoid "all" on Windows. List what you actually use.
    --     -- If you must have all, keep it, but expect long install times.
    --     compilers        = { "zig", "gcc", "clang" },
    --     ensure_installed = {
    --         "lua", "vim", "vimdoc", "query", "javascript",
    --         "typescript", "c", "cpp", "python", "markdown", "markdown_inline",
    --         "ruby", "powershell", "bash"
    --     },
    --
    --     -- FIX 3: Set to true. This installs parsers one-by-one.
    --     -- This prevents the "Paging file too small" error by not spawning 50 git/zig jobs at once.
    --     sync_install     = true,
    -- }
}
