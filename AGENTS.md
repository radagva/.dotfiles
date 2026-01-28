# Agent Guidelines for Dotfiles Repository

This repository hosts personal configuration files (dotfiles) managed via **GNU Stow**.
The structure is modular: each top-level directory corresponds to a package (e.g., `nvim`, `zsh`, `tmux`).
Inside each package directory, the file structure mirrors the target home directory structure.

**Example:**
- Repository path: `./nvim/.config/nvim/init.lua`
- Target system path: `~/.config/nvim/init.lua`

## 1. Environment & Build Commands

Since this is a configuration repository, there are no traditional "build" artifacts. However, validation and formatting are critical.

### Configuration Management
- **Stow**: To simulate installation or check symlinks:
  ```bash
  # Check stow conflicts
  stow -n -v <package_name> 
  
  # "Install" a package (create symlinks)
  stow -v <package_name>
  ```

### Formatting & Linting
Use the project's established formatters to maintain consistency.

- **Lua (Neovim)**:
  - Format: `stylua .`
  - Lint: Standard `luacheck` globals (vim) are assumed.
  
- **Web/Config (JSON, YAML, Markdown, JS/TS)**:
  - Format: `prettier --write "**/*.{json,yaml,md,js,ts}"`
  
- **Python**:
  - Format: `ruff format .` AND `isort .`
  - Lint: `ruff check .`
  
- **Shell (Zsh)**:
  - Verify syntax: `zsh -n .zshrc`

- **Go**:
  - Format: `gofumpt -w .`

### Testing
There is no automated test suite. "Testing" involves verifying the configuration works in the target application.
- **Neovim**: Open nvim and check for startup errors (`:messages`).
- **Zsh**: Run `exec zsh` to reload shell and check for errors.

## 2. Code Style & Conventions

### General
- **Indentation**: Respect the `.editorconfig` or existing file indentation.
  - Lua: 2 spaces.
  - Shell: 2 or 4 spaces (consistent per file).
- **Comments**: minimal but descriptive. Explain *why* a complex config exists (e.g., "Workaround for issue #123").

### Neovim (`nvim/`)
- **Plugin Manager**: Uses `lazy.nvim`.
- **Structure**:
  - `lua/core/`: Core settings, options, keymaps.
  - `lua/plugins/`: Plugin specifications. Each file returns a table or list of tables.
  - `lua/config/`: Autocommands and other setup.
- **Convention**: Prefer splitting plugins into separate files in `lua/plugins/` rather than one giant file.
- **Lazy Spec**:
  ```lua
  return {
    "plugin/repo",
    event = "VeryLazy", -- Use lazy loading where possible
    opts = { ... },     -- Prefer 'opts' table over 'config' function
  }
  ```

### Zsh (`zsh/`)
- **Performance**: Avoid heavy computations in `.zshrc`. Lazy load tools if possible.
- **Aliases**: Keep aliases short and memorable.

### Directory Handling (Critical for Agents)
- **DO NOT** write files assuming the root is the home directory.
- **ALWAYS** write to the package subdirectory.
  - WRONG: `write ~/.config/nvim/init.lua`
  - WRONG: `write init.lua` (if in root)
  - CORRECT: `write nvim/.config/nvim/init.lua`

### Error Handling
- Config files should generally fail gracefully or silently where possible, rather than crashing the application (e.g., check if a binary exists before adding an alias for it).

## 3. Tool Specifics
- **Neovim Formatters**: configured in `nvim/.config/nvim/lua/plugins/conform.lua`.
- **LSP**: configured via `nvim-lspconfig` and `mason`.

## 4. Cursor/Copilot Rules
- **Formatting**: Always run the relevant formatter on the file after editing.
- **Validation**: If editing lua, ensure syntax is valid (`luac -p file.lua` can help).
