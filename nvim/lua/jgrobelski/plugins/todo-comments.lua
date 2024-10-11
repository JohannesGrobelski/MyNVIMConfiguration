return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "]t", function()
            todo_comments.jump_next()
        end, { desc = "Next todo comment" })

        keymap.set("n", "[t", function()
            todo_comments.jump_prev()
        end, { desc = "Previous todo comment" })
        -- setup todo-comments with file type specific patterns
        todo_comments.setup({
            search = {
                -- Regular expressions to match TODO comments for different file types
                patterns = {
                    -- C, C++, Java, JavaScript, TypeScript, Go, etc. (single-line)
                    [[//%s*([TODO|FIXME|HACK|NOTE|BUG|WARNING]+)]],
                    -- C-like block comments (C, Java, JS, etc.)
                    [[/%*%s*([TODO|FIXME|HACK|NOTE|BUG|WARNING]+)]],
                    -- Shell scripts, Python, Lua, Ruby (hash comments)
                    [[#%s*([TODO|FIXME|HACK|NOTE|BUG|WARNING]+)]],
                    -- HTML, XML (HTML style comments)
                    [[<!--%s*([TODO|FIXME|HACK|NOTE|BUG|WARNING]+)]],
                    -- Lua-specific comment style
                    [[--%s*([TODO|FIXME|HACK|NOTE|BUG|WARNING]+)]],
                    -- Vimscript comment style
                    [["%s*([TODO|FIXME|HACK|NOTE|BUG|WARNING]+)]],
                }
            }
        })
    end,
}
