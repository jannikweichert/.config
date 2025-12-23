# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a personal Neovim configuration built on top of LazyVim (a Neovim starter template). The configuration follows LazyVim's modular plugin architecture:

- **Entry point**: `init.lua` bootstraps the lazy.nvim plugin manager and loads the Oil file browser
- **Core configuration**: `lua/config/` contains base configuration (lazy.nvim setup, options, keymaps, autocmds)
- **Plugin system**: `lua/plugins/` contains individual plugin configurations, each as a separate file returning a Lua table
- **Plugin manager**: Uses lazy.nvim with automatic lazy-loading for optimal startup performance

### Configuration Structure

1. **lua/config/lazy.lua**: Sets up lazy.nvim and imports LazyVim base + extras (TypeScript, JSON, mini-animate, testing)
2. **lua/config/options.lua**: Neovim options (currently just winbar customization)
3. **lua/config/keymaps.lua**: Custom keymaps, including tmux navigation, Oil file browser, and refactoring commands
4. **lua/plugins/*.lua**: Each file configures one or more related plugins

### Key Plugin Configurations

- **avante.lua**: AI coding assistant using OpenAI GPT-4o with blink.cmp integration for autocomplete
- **lspconfig.lua**: LSP servers (Pyright for Python, tsserver via typescript.nvim for TypeScript/JavaScript)
- **dap.lua**: Debug adapter protocol setup for Node.js/Chrome debugging with js-debug-adapter
- **tmux-navigation.lua**: Seamless navigation between vim splits and tmux panes using Ctrl+hjkl
- **harpoon.lua**: Quick file navigation and marking system
- **refactoring.lua**: Advanced refactoring operations via ThePrimeagen/refactoring.nvim

### Important Integration Points

**Tmux Integration**: The config assumes usage with tmux. Ctrl+hjkl keys navigate both vim splits and tmux panes seamlessly via vim-tmux-navigator.

**AI Tools**: Two AI assistants are configured:
- Avante (OpenAI GPT-4o) - accessible via its own keybinds
- Claude Code - accessible via `<leader>CC` (leader + CC)

**File Navigation**: Uses Oil.nvim for directory editing (accessible via `-` key) instead of netrw.

## Installed LazyVim Extras

The configuration includes these LazyVim extra modules (from lazyvim.json):
- **Coding**: mini-comment, mini-snippets, mini-surround
- **Debug**: DAP core, DAP nlua
- **Editor**: refactoring
- **Languages**: Angular, Docker, Git, Java, Markdown, Python, SQL, Svelte, Tailwind, YAML
- **Testing**: neotest core
- **Utilities**: dot files, mini-hipatterns

## Working with Plugin Configurations

### Adding a New Plugin

Create a new file in `lua/plugins/` that returns a Lua table with the plugin specification:

```lua
return {
  "username/plugin-name",
  dependencies = { "other/plugin" },
  opts = {
    -- plugin options
  },
  keys = {
    -- keybindings
  },
}
```

### Modifying Existing Plugins

Each plugin config file in `lua/plugins/` can override LazyVim defaults. Use the `opts` function to extend existing configurations:

```lua
opts = function(_, opts)
  -- modify opts table
  return opts
end
```

### LSP Server Configuration

LSP servers are configured in `lua/plugins/lspconfig.lua`. Add new servers to the `servers` table. For special setup (like tsserver with typescript.nvim), use the `setup` function table.

### DAP Configuration

Debug configurations are in `lua/plugins/dap.lua`. The setup automatically installs js-debug-adapter via Mason and configures Node.js/Chrome debugging for JavaScript/TypeScript filetypes.

## Custom Keybindings

Key custom keybindings defined in `lua/config/keymaps.lua`:

- `Ctrl+hjkl`: Navigate vim/tmux splits
- `-`: Open Oil file browser
- `<leader>r*`: Refactoring commands (extract function/variable, inline, etc.)
- `<leader>CC`: Toggle Claude Code
- `<leader>co`: Organize TypeScript imports
- `<leader>cR`: Rename TypeScript file
- `<leader>d*`: Debug commands (breakpoint, continue, REPL, toggle UI)
- `<leader>h*`: Harpoon file navigation

## Development Notes

- LazyVim's defaults are automatically loaded; config files only contain overrides and additions
- The colorscheme is set to Catppuccin (in `lua/plugins/core.lua`)
- Winbar shows file modification status and filename (`%=%m %f`)
- Plugin updates are automatically checked but notifications are disabled
- All custom plugins use `lazy = false` to load at startup unless explicitly configured otherwise
