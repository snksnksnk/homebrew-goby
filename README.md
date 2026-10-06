# Goby for Homebrew

`goby` runs Goby's agent host on your Mac, from the terminal, for your own
repositories, with your own Codex, Claude or GitHub Copilot account.

Requires macOS 26 or later.

```sh
brew tap snksnksnk/goby
brew install goby
goby doctor
goby login codex        # or: goby login claude  (plan token or API key)
cd ~/code/my-app && goby
```

Adding the tap is a one-time step; after it, `goby` works by name in
`brew install`, `brew upgrade` and `brew uninstall`. `brew install
snksnksnk/goby/goby` does both steps in one command.

In the session, type `/` to see every command. `goby help` lists them too.

Update with `brew upgrade goby`. Remove with `goby uninstall`, which finishes
active work first; your Goby data and saved sign-ins are kept.

Source and documentation: https://github.com/snksnksnk/goby-cli
