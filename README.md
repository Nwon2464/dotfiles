# Terminal environment

Portable configuration for a personal Linux laptop and a company Mac.
The repository intentionally contains configuration and a short package manifest only; it has no installation script.

## Included

- WezTerm stable configuration
- Neovim/NvChad configuration and `lazy-lock.json`
- tmux configuration
- Starship prompt configuration
- Minimal macOS zsh initialization
- Homebrew package and font list in `Brewfile`

## macOS installation checklist

Give this repository and the following instructions to the installation LLM:

1. Respect company security policy and do not copy personal credentials, SSH keys, tokens, shell history, or Git identity.
2. Install Apple's Command Line Tools and Homebrew if approved and not already installed.
3. From the repository root, install the declared packages with `brew bundle` after reviewing `Brewfile`.
4. Back up every existing destination before replacing it.
5. Copy or symlink the files according to the mapping below.
6. Start Neovim and let lazy.nvim restore the plugins pinned by `lazy-lock.json`.
7. In Neovim, install the required language servers with `:MasonInstall html-lsp css-lsp` if they are not already present.
8. Start WezTerm and verify the Nerd Font, Korean IME, tmux clipboard, and `Ctrl+h/j/k/l` pane navigation.

## Configuration mapping

| Repository path | Destination on macOS |
| --- | --- |
| `configs/wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` |
| `configs/nvim/` | `~/.config/nvim/` |
| `configs/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `configs/tmux/tmux.conf.loader` | `~/.tmux.conf` |
| `configs/starship/starship.toml` | `~/.config/starship.toml` |
| `configs/zsh/zshrc` | `~/.zshrc` |

## Important platform notes

- Do not copy the Linux laptop's full `.bashrc` to macOS. It contains Linux-only paths and commands.
- The WezTerm file enables Wayland and IBus only on Linux. macOS uses its native IME.
- The zsh file is deliberately minimal. Merge it with an existing company-managed `.zshrc` instead of overwriting policy-managed content.
- The Neovim lockfile pins plugin revisions. Homebrew application versions are not pinned.
- Keep machine-specific settings and secrets outside this repository.

## Current reference versions

The source laptop used these versions when the repository was created:

- WezTerm stable `20240203-110809-5046fc22`
- Neovim `0.12.4`
- tmux `3.2a`
- Starship `1.26.0`

Exact parity is not required, but Neovim should be recent enough to support `vim.lsp.enable()`.
