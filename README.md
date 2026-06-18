# post-install

Bootstrap a fresh machine: install tooling and symlink dotfiles.

## Layout

```
.
├── macos/              # macOS (Apple Silicon) bootstrap
│   ├── setup.sh        #   Homebrew + Brewfile.core + asdf + dotfile symlinks
│   ├── asdf-plugins.txt#   asdf plugins to re-add on the new machine
│   ├── Brewfile.core   #   CLI/shell/asdf/fonts — AUTO-installed by setup.sh
│   ├── Brewfile.apps   #   GUI apps — install on demand (brew install --cask X)
│   ├── Brewfile.all    #   everything in one (backup; bulk install if ever wanted)
│   └── NOTES.md        #   macOS-specific git/keychain notes
├── post-install.sh     # legacy Ubuntu/Linux bootstrap (apt/snap/asdf)
├── .tool-versions      # runtime versions (asdf/mise)
├── dotfiles/
│   ├── zsh/            #   .zshrc, .p10k.zsh   (macOS default shell)
│   ├── bash/           #   .bash_aliases
│   └── git/            #   gitconfig (paths use ~ so they work on Linux & macOS)
└── scripts/            # assorted helper scripts
```

## macOS (new Mac)

```bash
git clone <this-repo> ~/developer/github/post-install
cd ~/developer/github/post-install
./macos/setup.sh
```

`setup.sh` installs only **`Brewfile.core`** (CLI, shell, asdf, fonts) — it does
**not** install GUI apps. Pull those on demand later, e.g. `brew install --cask cursor`
(see `Brewfile.apps`), or all at once with `brew bundle --file=macos/Brewfile.apps`.

It's idempotent and backs up any existing dotfiles before symlinking. It also does
**not** handle secrets, per-app cloud-sync settings, or the VPN — those are manual
steps it prints at the end (detailed in the migration kit under `~/mac-migration/`).

## Linux (Ubuntu)

```bash
./post-install.sh
```

> Note: the Linux script targets apt/snap and `asdf v0.12.0`; update versions as needed.

## Dotfiles are symlinked, not copied

`setup.sh` symlinks repo files into `$HOME`, so editing a dotfile in `$HOME` edits the
repo copy — commit and push to keep machines in sync. Keep machine-specific or secret
values OUT of these files (the git config uses `~` and `includeIf` to stay portable).
