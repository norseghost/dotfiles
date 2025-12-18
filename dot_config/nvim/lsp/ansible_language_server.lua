return {
<<<<<<< HEAD
    -- Use wsl.exe to call the server installed in your Linux distro
    cmd = { "wsl.exe", "bash", "-lc", "ansible-language-server --stdio" },
=======
    cmd = { "ansible-language-server --stdio" },
>>>>>>> cf1a8cb3c3247a4644ca7b2456f90e52fbc84520
    -- Ensure the root directory is detected correctly
    settings = {
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
