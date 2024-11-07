local M = {}

function M.setup()
    -- Configure bufferline
    vim.opt.termguicolors = true
    local bufferline = require('bufferline')
    bufferline.setup {
        options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead
            style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
            themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
            numbers = "none",
            close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
            right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
            left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
            middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
            indicator = {
                icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style = 'icon',
            },
            buffer_close_icon = '󰅖',
            modified_icon = '● ',
            close_icon = ' ',
            left_trunc_marker = ' ',
            right_trunc_marker = ' ',
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            truncate_names = true,  -- whether or not tab names should be truncated
            tab_size = 18,
            diagnostics = "nvim_lsp",
            diagnostics_update_on_event = true, -- use nvim's diagnostic handler
            -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "(" .. count .. ")"
            end,
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            show_duplicate_prefix = true,    -- whether to show duplicate buffer prefix
            duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
            persist_buffer_sort = true,      -- whether or not custom sorted buffers should persist
            move_wraps_at_ends = false,      -- whether or not the move command "wraps" at the first or last position
            -- can also be a table containing 2 custom separators
            -- [focused and unfocused]. eg: { '|', '|' }
            separator_style = "slant",
            enforce_regular_tabs = false,
            always_show_bufferline = true,
            auto_toggle_bufferline = true,
            hover = {
                enabled = true,
                delay = 200,
                reveal = { 'close' }
            },
        }
    }

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'base16',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype', },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
end

return M
