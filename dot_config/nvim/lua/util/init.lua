local M = {}

-- notify wrapper lifted from lazy.nvim
---@param msg string|string[]
---@param opts? LazyNotifyOpts
function M.notify(msg, opts)
    if vim.in_fast_event() then
        return vim.schedule(function()
            M.notify(msg, opts)
        end)
    end

    opts = opts or {}
    if type(msg) == "table" then
        msg = table.concat(
            vim.tbl_filter(function(line)
                return line or false
            end, msg),
            "\n"
        )
    end
    local lang = opts.lang or "markdown"
    vim.notify(msg, opts.level or vim.log.levels.INFO, {
        on_open = function(win)
            pcall(require, "nvim-treesitter")
            vim.wo[win].conceallevel = 3
            vim.wo[win].concealcursor = ""
            vim.wo[win].spell = false
            local buf = vim.api.nvim_win_get_buf(win)
            if not pcall(vim.treesitter.start, buf, lang) then
                vim.bo[buf].filetype = lang
                vim.bo[buf].syntax = lang
            end
        end,
        title = opts.title or "lazy.nvim",
    })
end

---@param msg string|string[]
---@param opts? LazyNotifyOpts
function M.error(msg, opts)
    opts = opts or {}
    opts.level = vim.log.levels.ERROR
    M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? LazyNotifyOpts
function M.info(msg, opts)
    opts = opts or {}
    opts.level = vim.log.levels.INFO
    M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? LazyNotifyOpts
function M.warn(msg, opts)
    opts = opts or {}
    opts.level = vim.log.levels.WARN
    M.notify(msg, opts)
end

---@param msg string|table
---@param opts? LazyNotifyOpts
function M.debug(msg, opts)
    if not require("lazy.core.config").options.debug then
        return
    end
    opts = opts or {}
    if opts.title then
        opts.title = "lazy.nvim: " .. opts.title
    end
    if type(msg) == "string" then
        M.notify(msg, opts)
    else
        opts.lang = "lua"
        M.notify(vim.inspect(msg), opts)
    end
end

local add_desc = function(opts, desc)
    -- FIXME: this seems needlessly convoluted
    --        seems like it should be possible to add the description
    --        more directly
    local opt = { desc = desc }
    opts = vim.tbl_extend("force", opt, opts)
    return opts
end
---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
    if values then
        if vim.opt_local[option]:get() == values[1] then
            vim.opt_local[option] = values[2]
        else
            vim.opt_local[option] = values[1]
        end
        return M.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
    end
    vim.opt_local[option] = not vim.opt_local[option]:get()
    if not silent then
        if vim.opt_local[option]:get() then
            M.info("Enabled " .. option, { title = "Option" })
        else
            M.warn("Disabled " .. option, { title = "Option" })
        end
    end
end

local enabled = true
function M.toggle_diagnostics()
    enabled = not enabled
    if enabled then
        vim.diagnostic.enable()
        M.info("Enabled diagnostics", { title = "Diagnostics" })
    else
        vim.diagnostic.disable()
        M.warn("Disabled diagnostics", { title = "Diagnostics" })
    end
end

local show_in_preview = function(name, fileType, lines)
    vim.cmd("silent! pedit! " .. name)
    local get_preview_window = function()
        local windows = vim.api.nvim_list_wins()
        for i, win in ipairs(windows) do
            if vim.wo[win].previewwindow then
                return win
            end
        end
    end
    local preview_win = get_preview_window()
    local bufnr = vim.api.nvim_win_get_buf(preview_win)
    --[[ vim.wo[preview_win].number = false ]]
    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].buflisted = false
    vim.bo[bufnr].bufhidden = "wipe"
    vim.bo[bufnr].swapfile = false
    vim.bo[bufnr].filetype = fileType


    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    local vars = {
        winnr = preview_win,
        bufnr = bufnr
    }
    return unpack(vars)
end

local sentence_line_format = function()
    return
end

-- show_in_preview("preview", "markdown", "preview test")
M.add_desc = add_desc
M.show_in_preview = show_in_preview
M.sentence_line_format = sentence_line_format

return M
