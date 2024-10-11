return {
    "windwp/nvim-ts-autotag",
    config = function()
        require('nvim-ts-autotag').setup({
            opts = {
                -- Defaults
                enable_close = true,          -- Auto close tags
                enable_rename = true,         -- Auto rename pairs of tags
                enable_close_on_slash = false  -- Auto close on trailing </
            },
            -- Override individual filetype configs
            per_filetype = {
                ["html"] = {
                    enable_close = false  -- Disable auto close for HTML
                },
                ["tsx"] = {
                    enable_rename = true    -- Ensure auto rename is enabled for TSX
                },
                ["jsx"] = {
                    enable_rename = true    -- Ensure auto rename is enabled for JSX
                },
            }
        })
    end,
}

