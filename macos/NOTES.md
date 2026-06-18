# macOS-specific notes

Reference only — these are NOT applied by `setup.sh` and are deliberately kept OUT of
the shared `dotfiles/git/config` (which stays portable across Linux & macOS). Apply by
hand on the Mac if/when you want them.

## Git tweaks for macOS

The shared gitconfig works as-is on macOS. These are optional macOS-native improvements:

1. **Credential helper → Keychain.** The portable config uses `helper = cache`
   (in-memory, 15 min). On macOS, store credentials securely in the system Keychain:
   ```
   git config --global credential.helper osxkeychain
   ```

2. **Diff/merge tool.** The portable config sets `meld`. meld runs on macOS (Brewfile
   installs the cask) but is clunky; the native option ships with Xcode:
   ```
   git config --global diff.tool  opendiff
   git config --global merge.tool opendiff
   ```

3. **`includeIf` paths after the home reorg.** Code moves to `~/Developer/work/`, so the
   work-gitconfig includes must point there (the shared config still uses `~/work/`):
   ```
   [includeIf "gitdir:~/Developer/work/sea/"]
       path = ~/.gitconfigs/seatecnologia.gitconfig
   [includeIf "gitdir:~/Developer/work/origemmotos/"]
       path = ~/.gitconfigs/origemmotos.gitconfig
   ```

## Other macOS gotchas (not git-config, but git behavior)

- **Case-insensitive filesystem (APFS).** Git auto-sets `core.ignorecase = true`. Files
  differing only by case (`File.js` vs `file.js`) collide — watch for it in Java/Liferay repos.
- **Which `git`.** macOS ships Apple's Git at `/usr/bin/git`; Homebrew's is newer. Ensure
  `/opt/homebrew/bin` precedes `/usr/bin` on PATH (default with `brew shellenv`).
