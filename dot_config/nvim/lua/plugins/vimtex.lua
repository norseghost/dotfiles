return {
    "lervag/vimtex", -- tex helper suite
    ft     = "tex",
    config = function()
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_complete_enabled = false
        vim.g.vimtex_fold_enabled = true -- Enable folding by section
        vim.g.vimtex_format_enabled = true
        vim.g.vimtex_compiler_progname = "nvr"
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
            options = {
                "-verbose",
                "-file-line-error",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-shell-escape",
                "-extra-mem-bot=10000000",
                "-extra-mem-top=10000000"
            },
        }
        vim.g.vimtex_compiler_latexmk_engines = {
            _ = "-lualatex"
        }
        vim.g.vimtex_quickfix_method = "pplatex"
        vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2
        vim.g.vimtex_complete_close_braces = false
        vim.g.vimtex_complete_bib = {
            simple = false,
            menu_fmt = '"@title", @author_short (@year)'
        }
        vim.g.vimtex_view_method = "zathura" -- Viewer for live updates
        vim.g.vimtex_quickfix_open_on_warning = 0
        -- Disable custom warnings based on regexp
        vim.g.vimtex_quickfix_ignore_filters = {
            "Marginpar on page",
            "Warning"
        }

        vim.g.vimtex_toc_config = {
            always_refresh = 1,
            show_numbers = 0,
            fold_enable = 1
        }
        vim.cmd [[
        augroup vimtex
        autocmd!
        autocmd BufWritePost *.tex call vimtex#toc#refresh()
        autocmd BufRead,BufEnter *.tex setlocal spell wrap
        augroup END
        ]]
    end
}
