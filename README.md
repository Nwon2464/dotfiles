# Terminal dotfiles

Configurations for WezTerm, Neovim, tmux, Starship, and zsh on macOS and Linux.

## macOS setup

1. Install Homebrew.
2. Run `brew bundle` from this repository.
3. Copy or symlink the configuration files using the table below.
4. Start Neovim to restore plugins from `lazy-lock.json`.
5. If needed, run `:MasonInstall html-lsp css-lsp` in Neovim.

## Configuration paths

| Repository path | Destination |
| --- | --- |
| `configs/wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` |
| `configs/nvim/` | `~/.config/nvim/` |
| `configs/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `configs/tmux/tmux.conf.loader` | `~/.tmux.conf` |
| `configs/starship/starship.toml` | `~/.config/starship.toml` |
| `configs/zsh/zshrc` | `~/.zshrc` |

The WezTerm configuration applies Wayland and IBus settings only on Linux. macOS uses its native input method.

## Reference versions

- WezTerm stable `20240203-110809-5046fc22`
- Neovim `0.12.4`
- tmux `3.2a`
- Starship `1.26.0`
