return  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()  -- This is where you include your configuration
        local options = {
            width = 30,
            auto_expand_width = true
        }
        require("neo-tree").setup(options)  -- Setup the plugin with your options
    end,
    lazy = false
}
