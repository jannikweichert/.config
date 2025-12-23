# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Overview

This is a Neovim configuration based on LazyVim, a modular Neovim starter. The configuration uses lazy.nvim as the plugin manager and is organized with a clear separation between core configuration (`lua/config/`) and plugin specifications (`lua/plugins/`).

## Architecture

### Core Structure
- **init.lua**: Bootstrap entry point that loads lazy.nvim and initializes Oil file browser
- **lua/config/**: Core Neovim configuration
  - `lazy.lua`: Plugin manager setup and LazyVim extras configuration
  - `options.lua`: Vim options (sets winbar)
  - `keymaps.lua`: Custom keybindings
  - `autocmds.lua`: Autocommands (currently empty, inherits LazyVim defaults)
- **lua/plugins/**: Individual plugin specifications loaded automatically by lazy.nvim

### Plugin System
Each file in `lua/plugins/` returns a Lua table (or array of tables) defining plugin specifications. Plugins are lazy-loaded by default through LazyVim unless explicitly configured otherwise. The configuration follows LazyVim's extension pattern where you can add new plugins, disable built-in ones, or override their configuration.

### Language Support
Configured LazyVim extras for: TypeScript, JSON, Angular, Docker, Git, Java, Markdown, Python, SQL, Svelte, Tailwind, and YAML.

## Key Customizations

### Navigation
- **Tmux Integration**: Seamless navigation between Neovim splits and tmux panes using `Ctrl+h/j/k/l`
- **Oil.nvim**: File browser accessible via `-` key in normal mode
- **Harpoon**: Quick file marking and navigation (`<leader>h` prefix)

### AI/Refactoring Tools
- **Avante.nvim**: AI-assisted coding with OpenAI (gpt-4o), accessible via `<leader>CC` to toggle Claude Code
- **Refactoring.nvim**: Advanced refactoring operations (`<leader>r` prefix for extract function/variable, inline, etc.)

### Development Features
- **Auto-save**: Enabled by default (except for Lua files), toggle with `<leader>at`
- **Neotest**: Test runner with Jest and Deno adapters
- **LSP**: Configured for TypeScript (tsserver) and Python (pyright) with custom keymaps for organizing imports and renaming files

### UI
- **Colorscheme**: Catppuccin
- **Lualine**: Status line shows auto-save status (💾 AutoSave / 🛑 NoSave)

## Common Commands

### Testing
```bash
# Run tests through Neotest with Jest
# Uses: npm test --
# Config file: custom.jest.config.ts
# Note: Tests are run from current working directory
```

### Formatting
```bash
# Format Lua files with stylua (configured in stylua.toml)
stylua lua/
# Settings: 2 spaces, column width 120
```

### Plugin Management
```lua
-- Inside Neovim:
:Lazy          -- Open plugin manager UI
:Lazy sync     -- Install/update/clean plugins
:Lazy check    -- Check for plugin updates (auto-enabled, no notifications)
```

## Development Guidelines

### Adding New Plugins
Create a new file in `lua/plugins/` returning a plugin specification:
```lua
return {
  "author/plugin-name",
  opts = { },
  keys = { },  -- for lazy loading on key press
  cmd = { },   -- for lazy loading on command
}
```

### Modifying LazyVim Plugins
Override by returning a spec with the same plugin name. Use `enabled = false` to disable.

### Custom Keymaps
Add to `lua/config/keymaps.lua`. Note that LazyVim sets many default keymaps automatically.

### LSP Configuration
Extend `lua/plugins/lspconfig.lua` by adding servers to the `servers` table or custom setup functions in the `setup` table.

## Important Notes

- Plugin updates are automatically checked but notifications are disabled
- Auto-save is configured to skip special buffers and Lua files
- TypeScript setup uses typescript.nvim for enhanced functionality
- Oil.nvim is configured with simplified columns and skip confirmations for simple edits
- Avante uses OpenAI with 8192 max completion tokens and temperature 0
