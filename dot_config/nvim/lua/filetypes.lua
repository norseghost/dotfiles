vim.filetype.add({
    pattern = {
        [".*/playbooks/.*%.ya?ml"]         = "yaml.ansible",
        [".*/roles/.*/tasks/.*%.ya?ml"]    = "yaml.ansible",
        [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
        [".*/group_vars/.*%.ya?ml"]        = "yaml.ansible",
        [".*/host_vars/.*%.ya?ml"]         = "yaml.ansible", -- top-level playbooks (common names)
        [".*/site%.ya?ml"]                 = "yaml.ansible",
        [".*/main%.ya?ml"]                 = "yaml.ansible",
        [".*/playbook%.ya?ml"]             = "yaml.ansible",
        [".*/nfr%.ya?ml"]                  = "yaml.ansible",
        [".*/deploy%.ya?ml"]               = "yaml.ansible",
    },
})
-- TODO: make a loop
