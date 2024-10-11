return {
    "hsanson/vim-android",
    lazy = false,
    cond = function()
      -- Define your condition to load the plugin based on the directory
      local android_project = vim.fn.getcwd() -- Get current working directory
      -- Check if a file like 'build.gradle' or 'AndroidManifest.xml' exists in the directory
      return vim.fn.filereadable(android_project .. '/build.gradle') == 1 or
             vim.fn.filereadable(android_project .. '/app/src/main/AndroidManifest.xml') == 1
    end,
    config = function()
        -- You can add configuration for vim-android here
        -- Example configuration

        -- Set the path to your Android SDK (if needed)
        vim.g.android_sdk_path = '/home/johannes/Android/Sdk'


        -- Key mappings (customize as per your needs)
        vim.api.nvim_set_keymap("n", "<leader>Ak", ":AndroidRun<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>Aj", ":AndroidTest<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>Al", ":AndroidLogcat<CR>", { noremap = true, silent = true })

        -- Additional options
        vim.g.android_logcat_options = '-s MyAppTag:D *:S'  -- Example logcat filter

        vim.g.android_build_tool_path = '/home/johannes/Android/Sdk/build-tools/34.0.0' -- Path to Android build tools
        vim.g.android_ndk_path = '/path/to/your/android/ndk'       -- Path to Android NDK
    end
}

