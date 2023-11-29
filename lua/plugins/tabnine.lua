return {
    -- {
    --     'codota/tabnine-nvim',
    --     enabled = true,
    --     build = './dl_binaries.sh',
    --     config = function()
    --         require('tabnine').setup({
    --             disable_auto_comment=true,
    --             -- accept_keymap="<Tab>",
    --             -- dismiss_keymap = "<C-]>",
    --             debounce_ms = 800,
    --             suggestion_color = {gui = "#808080", cterm = 244},
    --             exclude_filetypes = {"TelescopePrompt"},
    --             log_file_path = '/Users/navaritcharoenlarp/Documents/logs/tabnine'
    --         })
    --     end,
    -- },
    {
        'tzachar/cmp-tabnine',
        enabled = false,
        build = './install.sh',
        dependencies = 'hrsh7th/nvim-cmp',
        config = function()
            local tabnine = require('cmp_tabnine.config')
            tabnine:setup({
                max_lines = 1000,
                max_num_result = 20,
                sort = true,
                run_on_every_keystroke = true,
                snippet_placeholder = '..',
                ignored_file_types = {},
                show_predictin_strength = true,
            })
        end,
    }
}
