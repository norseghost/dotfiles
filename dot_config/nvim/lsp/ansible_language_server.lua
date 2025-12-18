return {
    cmd = { "ansible-language-server", "--stdio" },
    -- Ensure the root directory is detected correctly
    settings = {
        root_markers = { "ansible.cfg", ".ansible-lint", "inventory" },
        filetypes = { "yaml.ansible" },
        ansible = {
            ansible = {
                path = "ansible" -- This refers to the 'ansible' command inside WSL
            },
            executionEnvironment = {
                enabled = false -- Disable if you aren't using containers
            },
            validation = {
                lint = {
                    enabled = true,
                    path = "ansible-lint" -- The server will look for this in the WSL PATH
                }
            }
        }
    },
}
