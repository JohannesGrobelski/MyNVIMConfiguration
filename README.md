# Meine NVIM-Config V1.1

# Vorraussetzungen

1. Brew
2. NVIM 0.10
3. Nerdfonts
4. ripgrep
5. node/npm

# Aufbau

--TODO:

├── init.lua: Einstiegspunkt in die Konfiguration
├── lazy-lock.json: Lock für installierte Lazy Plugins
├── lua: Ordner für Konfiguration
│ ├── core: Basiskonfiguration der installierten Plugins
│ ├── options.lua: optionen für nvim: netrw-konfig, linenumbers, tab&indents, wrap, searchsettings
│ ├── keymaps.lua: Keyboard Map
│ ├── plugins: Installation und Konfiguration der Plugins
│ ├── lazy.lua: Bootstrap von Lazy

# Basiskonfiguration

This `options.lua` configures the leader key, relative and absolute line numbers,
tab and indentation settings, search behavior, cursorline, and color scheme support.
It also handles clipboard integration, window splitting behavior, disables swap files, and configures backspace behavior.
Additionally, it disables line wrapping and sets up the sign column display.

# Mappings

This config defines key mappings for basic commands, window navigation, split management, tab management, and specialized tools like Telescope, diff, quickfix, and LSP.
It includes mappings for debugging with DAP, Git blame, and Harpoon file navigation.
Additional keymaps for managing buffers, opening new tabs, resizing windows, and performing LSP functions are also set.

# Lazy

Lazy is a modern plugin manager for Neovim that optimizes startup time by loading plugins only when necessary.
It supports features like lazy-loading, plugin version control, automatic updates, and dependency management, providing a streamlined way to handle plugins efficiently.
The configuration in lazy.lua bootstraps the Lazy plugin manager for Neovim.
If Lazy.nvim is not installed, it clones the stable version from GitHub into the appropriate data directory.
After that, it sets up Lazy to load all plugins defined in the `plugin` directory and its subdirectories.
It also enables automatic plugin updates (`checker`) and change detection without sending notifications to the user.

# Features/Plugins

## Theme

This config uses `Mofiqul/dracula.nvim` as theme.

## Telescope

This config uses `telescope.nvim` plugin for Neovim, with dependencies

- `plenary.nvim`: A Lua utility library used by Telescope to provide essential functions like async operations and file handling.
- `telescope-fzf-native`: A Telescope extension that enables faster fuzzy finding using the FZF algorithm, improving search performance.
- `todo-comments`: Allows Telescope to search and display TODO comments within your project, integrated through the `<leader>ft` keymap.
- `trouble.nvim`: Provides a visual list of diagnostic issues and integrates with Telescope for sending search results to the "Trouble" quickfix list.
- `live_grep_args`: An extension for Telescope that allows users to perform live grep searches with additional arguments, enhancing search capabilities for specific file types and search patterns.
  Additional key mappings: using Telescope to search files, buffers, help tags, fuzzy find content, grep for strings, and explore LSP symbols, including a custom Treesitter search.

## LSPs

### Mason

This configuration sets up the `mason.nvim` plugin along with `mason-lspconfig.nvim` and `mason-tool-installer.nvim` to streamline the installation
and management of LSP servers and development tools.
`mason-lspconfig` plugin ensures installation of LSP servers like `bashls`, `html`, `pyright`.
`mason-tool-installer` is configured to automatically install formatters and linters like `prettier`, `stylua`, `black`.

### LSP-Config

The **`nvim-lspconfig`** plugin simplifies configuration LSP servers.
It will map various LSPs (like ts_ls) to their filetypes, enable cmp_nvim_lsp (auto-completion plugin for the languages).

- `folke/neodev`: configures lua-lsp, enables language features like auto-completion and configures vim-runtime.

### tree-sitter

This configuration for the **nvim-treesitter** plugin enables syntax highlighting, indentation, and autotagging using the **nvim-ts-autotag** plugin while ensuring that necessary language parsers are installed.
It also allows for incremental selection and automatically installs missing parsers when entering a buffer.
The incremental selection feature is set up with key mappings that allow users to initiate selection with <C-space>, incrementally select nodes (such as moving from a single word to a sentence) with the same key, and decrement the selection using the <bs> key, enhancing the editing experience in Neovim.

### nvim-autocomplete

### typescript-language-server

- unterstützt js,ts,jsx,tsx

### nvim-java

The **`nvim-java`** includes tools for Spring Boot, diagnostics and auto-completion, and automatic debug configuration.
It simplifies project management by automatically installing necessary components and leveraging `nvim-lspconfig` for efficient setup of `jdtls`.
Additionally, it supports real-time updates through `neoconf` and auto-loads essential plugins, such as `spring-boot-tools`, `lombok`, `java-test`, and `java-debug-adapter`, ensuring a seamless development experience.

## Auto-Completion

The `nvim-cmp` plugin enhances Neovim's completion capabilities with support for various sources like buffers, file paths, and snippets, triggered on entering insert mode.
Its configuration includes key mappings for navigation and selection in the completion menu, along with integrating LuaSnip for snippet expansion and LSP for intelligent code completion.
\*\*IMPORTANT: cmp_nvim_lsp is used to define the capabilities of the lsp servers (this will enabble auto-completions).

## DAP

### Java

Java Debugging wird hier ganz gut erklärt: youtube.com/watch?v=kbRIosrvof0
Kurzgefasst nutzt mfussenegger/nvim-dap JDTLS, welches wiederrum den Debugadapter microsoft/java-debug nutzt.
Dafür muss in der JDTLS Konfiguration java-debug verlinkt werden.
Außerdem muss der java-debug runtergeladen und gebaut werden (es entsteht eine jar die in jdtls verlinkt werden kann, um von ihm gebraucht zu werden).

### Other language plugins

- `nvim-ts-autotag`: automatically closes and renames HTML/XML tags in Neovim while allowing for specific configurations, such as disabling auto-closing for HTML and enabling renaming for TSX and JSX files.
- `nvim-autopairs`: automatically manage pairs of brackets and quotes, checks for compatibility with Tree-sitter for specific languages, and integrates with the nvim-cmp completion plugin to enhance auto-completion functionality.
- `comment`: use the gc prefix for toggling comments in TypeScript, JSX, Svelte, and HTML files, leveraging nvim-ts-context-commentstring for context-aware commenting.

## Navigation

- `neo-tree.nvim`: file explorer with the option to automatically expand its width, and it depends on several plugins like `plenary.nvim`, `nvim-web-devicons` for icons, `nui.nvim` for UI components, and `image.nvim` for optional image support in the preview window.
- `alpha-nvim`: customized dashboard with a stylized header and commands for creating new file, toggling the file explorer, finding files, searching words, restoring sessions, and quitting Neovim, all set to display upon entering Vim.
- `bufferline.nvim` nicer tabs requires `nvim-web-devicons` for visual file icons, and uses the latest available version.

## Visual

- `dressing.nvim`: enhances the user interface for input and selection dialogs in Neovim, and it is set to load on the "VeryLazy" event for optimal performance.
- `lualine.nvim`: status line plugin with Dracula theme and includes a section to display updates from Lazy plugin, current file's encoding, format, and type.
- `indent-blankline.nvim`: visually represents indentation levels with a customizable character (┊) and is triggered on buffer read and new file events.

## Other Plugins

- `which-key`: plugin provides a popup that displays available key bindings and their descriptions when a leader key is pressed.
- `folke/todo-comments.nvim`: key mappings (`]t` and `[t`) for navigating between TODO comments using the plugin's `jump_next` and `jump_prev` functions. Supports Lua, Java, TS and many other comment types.
- `gbprod/substitute.nvim`: key mappings for substituting with (`s`), substituting a whole line (`ss`), substituting to the end of a line (`S`), and substituting in visual mode (`s`).
- `nvim-surround`: adds surround motion `ys` + `motion` (like `iw`) + replacement (like `"`). Other motions delete surround (`ds`), change surround (`cs`).

# TODO

- #TODO python debuging funktioniert noch nicht ganz ("core.utils")
- snippet support (z.B. yuki-yano/tsnip.nvim) für java,ts
- nvim-cmp erweitern (was kann ich aus https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources gebrauchen?)
- test framework installieren (z.B. nvim-neotest/neotest)

# Quellen

Diese Config baut auf folgendem auf:

1. Josean Martinez: How I Setup Neovim To Make It AMAZING in 2024: The Ultimate Guide (https://www.youtube.com/watch?v=6pAG3BHurdM)
2. Darauf aufbauend die Grundkonfiguration von ThePrimagen (https://www.youtube.com/watch?v=w7i4amO_zaE)
   2.1. ThePrimeagen/harpoon: Lesezeichen für Datein um schnell zwischen ihnen zu springen
   2.2. mbbill/undotree: Baum der Undos aufrufen und in Änderungen zurückgehen können
   2.3. tpope/vim-fugitive: Wrapper um nvim Git Kommandos
   2.4. nvim-telescope/telescope: Finden, Filter, Auswählen u.v.m von Datein
3. Eigene Java-LSP-Konfiguration
   4.1. Einbinden von jdtls
4. Eigene Web-LSP-Konfiguration
   - unterstützung für HTML, JS, TS, CSS