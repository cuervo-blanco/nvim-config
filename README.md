# nvim-config

Personal Neovim configuration for C++, Python, and general development.

Requires Neovim 0.12 or newer. The Tree-sitter setup uses its Neovim 0.12
compatibility branch and installs parsers automatically on first launch.

## Install

```sh
git clone https://github.com/cuervo-blanco/nvim-config.git ~/.config/nvim
nvim
```

Lazy.nvim installs the configured plugins on first launch.

## Explorer and Git status

Neo-tree is the file Explorer. It displays Git state beside each filename and
automatically refreshes as files change.

- `<Space>e` (or `<Space>pv`) — toggle the project Explorer
- `<Space>ge` — show only files with Git changes not yet committed

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

## Claude Code

This configuration includes [claudecode.nvim](https://github.com/coder/claudecode.nvim).
Install the `claude` CLI and authenticate it before using the integration.

- `<Space>lc` — toggle Claude Code
- `<Space>lf` — focus Claude Code
- `<Space>lb` — add the current buffer as context
- Visual `<Space>ls` — send the selection to Claude Code

Claude Code uses Neovim's native terminal and can open proposed edits as native
diffs. Run `:checkhealth claudecode` if the CLI is not detected.


