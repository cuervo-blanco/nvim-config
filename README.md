# nvim-config

Personal Neovim configuration for C++, Python, and general development.

## Install

```sh
git clone https://github.com/cuervo-blanco/nvim-config.git ~/.config/nvim
nvim
```

Lazy.nvim installs the configured plugins on first launch.

## Codex

This configuration includes [codex.nvim](https://github.com/nwiizo/codex.nvim).
It requires the `codex` CLI to be available on your `PATH`.

- `<Space>ox` — open, focus, or hide Codex
- `<Space>ob` — add the current buffer as context
- Visual `<Space>os` — send the selection to Codex
- Visual `<Space>oa` — ask Codex about the selection
- Visual `<Space>oe` — request an edit for the selection

Codex opens in a right-hand split rooted at the current project. Use `:CodexHealth`
to diagnose the integration.


