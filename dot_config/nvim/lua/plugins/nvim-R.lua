return {
    "jalvesaq/Nvim-R", -- R development environment
    "Ikuyadeu/vscode-R", -- R snippets
    ft = {
        "r", "Rmd"
    },
    config = function()
        -- type two underscores to get <-
        --makes it less annoying to type object names with many underscores
        vim.g.R_assign = 2
        vim.g.r_syntax_folding = 1
        vim.g.R_user_maps_only = 1
        vim.g.R_non_r_compl = 0
        vim.g.R_open_example = 0

        vim.g.R_nvimpager = 'vertical'

        -- augroup Rmaps
        --     autocmd!
        --     autocmd FileType r,R,Rmd
        --                 \ nnoremap <localleader>ro  <Plug>RUpdateObjBrowser
        -- augroup EMD
        -- TODO: Add nvim specific revn maybe?
        --vim.g.R_path = '/path/to/my/preferred/R/version/bin'
    end
}
