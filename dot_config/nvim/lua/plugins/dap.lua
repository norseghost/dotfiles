return {
    {
        "mfussenegger/nvim-dap", -- debug adapter protocol
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter",
                "rcarriga/nvim-dap-ui",
                config = function()
                    require("dapui").setup({
                        icons = { expanded = "▾", collapsed = "▸" },
                        mappings = {
                            -- Use a table to apply multiple mappings
                            expand = { "<CR>", "<2-LeftMouse>" },
                            open = "o",
                            remove = "d",
                            edit = "e",
                            repl = "r",
                            toggle = "t",
                        },
                        layouts = {
                            {
                                -- You can change the order of elements in the sidebar
                                elements = {
                                    -- Provide as ID strings or tables with "id" and "size" keys
                                    { id = "scopes", size = 0.25, }, -- Can be float or integer > 1
                                    { id = "breakpoints", size = 0.25 },
                                    { id = "stacks", size = 0.25 },
                                    { id = "watches", size = 0.25 },
                                },
                                size = 40,
                                position = "left", -- Can be "left", "right", "top", "bottom"
                            },
                            {
                                elements = { "console" },
                                size = 10,
                                position = "bottom", -- Can be "left", "right", "top", "bottom"
                            }
                        },
                        floating = {
                            max_height = nil, -- These can be integers or a float between 0 and 1.
                            max_width = nil, -- Floats will be treated as percentage of your screen.
                            border = "single", -- Border style. Can be "single", "double" or "rounded"
                            mappings = {
                                close = { "q", "<Esc>" },
                            },
                        },
                        windows = { indent = 1 },
                    })
                end
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                config = true
            },
        },
        init = function()
            vim.keymap.set("n", "<leader>db", function()
                require("dap").toggle_breakpoint()
            end, { desc = "Toggle Breakpoint" })

            vim.keymap.set("n", "<leader>dc", function()
                require("dap").continue()
            end, { desc = "Continue" })

            vim.keymap.set("n", "<leader>dt", function()
                require("dap").terminate()
            end, { desc = "Continue" })

            vim.keymap.set("n", "<leader>do", function()
                require("dap").step_over()
            end, { desc = "Step Over" })

            vim.keymap.set("n", "<leader>di", function()
                require("dap").step_into()
            end, { desc = "Step Into" })

            vim.keymap.set("n", "<leader>dw", function()
                require("dap.ui.widgets").hover()
            end, { desc = "Widgets" })

            vim.keymap.set("n", "<leader>dr", function()
                require("dap").repl.open()
            end, { desc = "Repl" })

            vim.keymap.set("n", "<leader>du", function()
                require("dapui").toggle({})
            end, { desc = "Dap UI" })
        end,
        config = function()
            require("dap").listeners.after.event_initialized["dapui_config"] = function()
                require("dapui").open({})
            end
            require("dap").listeners.before.event_terminated["dapui_config"] = function()
                require("dapui").close({})
            end

            require("dap").listeners.before.event_exited["dapui_config"] = function()
                require("dapui").close({})
            end
            -- local debug_status = function()
            --     if dap.status() ~= nil then
            --         return dap.status()
            --     end
            -- end
            -- local statusline = require("lualine").get_config()
            -- table.insert(statusline.sections.lualine_x, debug_status)
        end
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = "nvim-dap",
        config = function()
            local dap_python = require("dap-python")
            dap_python.setup("~/.local/lib/python/venv/debugpy/bin/python")
            dap_python.test_runner = "pytest"
            vim.keymap.set("n", "<leader>dm", dap_python.test_method, { desc = "Debug python method" })
            vim.keymap.set("n", "<leader>dC", dap_python.test_class, { desc = "Debug python class" })
        end
    },
    {
        "jbyuki/one-small-step-for-vimkind",
        ft = "lua",
        dependencies = "nvim-dap",
        config = function()
            local dap = require("dap")
            dap.configurations.lua = {
                {
                    type = "nlua",
                    request = "attach",
                    name = "Attach to running Neovim instance",
                }
            }
            dap.adapters.nlua = function(callback, config)
                callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
            end

            vim.keymap.set("n", "<leader>ds", function()
                require("osv").launch({ port = 8086 })
            end, { desc = "Launch Lua Debugger Server" })

            vim.keymap.set("n", "<leader>dd", function()
                require("osv").run_this()
            end, { desc = "Launch Lua Debugger" })
        end
    },

}
