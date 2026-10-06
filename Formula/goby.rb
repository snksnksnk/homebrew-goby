class Goby < Formula
  desc "Local agent host and terminal workflow for your repositories"
  homepage "https://github.com/snksnksnk/goby-cli"
  url "https://github.com/snksnksnk/goby-cli/releases/download/goby-v0.2.0-beta.3/goby-0.2.0-beta.3-universal.tar.gz"
  version "0.2.0-beta.3"
  sha256 "f8e4d99a478c5eccf7c823b54477d1e1f5a4f4b4b362aba58a6d6c2d30282519"
  license "MIT"
  depends_on macos: :tahoe

  def install
    bin.install "bin/goby"
    # SwiftPM's module bundle accessor searches beside the executable.
    Pathname.glob("bin/*.bundle").each { |bundle| bin.install bundle }
    bash_completion.install "completions/goby.bash" => "goby"
    zsh_completion.install "completions/_goby"
    fish_completion.install "completions/goby.fish"
    pkgshare.install "README.md", "LICENSE", "ProviderRuntime.sha256.json", "SourceCommit.txt"
  end

  service do
    run [opt_bin/"goby", "host", "run", "--stay-alive"]
    keep_alive true
    working_dir Dir.home
    log_path var/"log/goby.log"
    error_log_path var/"log/goby.log"
  end

  def caveats
    <<~EOS
      Run goby doctor, then goby login codex|claude|copilot.
      Codex uses your installed Codex. Claude and Copilot runtimes download once,
      on demand, when you sign in (goby runtime install claude|copilot), and are
      checked against hashes built into goby. Claude takes a plan token from
      claude setup-token or an API key. CLI data and Keychain items are separate
      from the Goby app and survive uninstall. Data:
        ~/Library/Application Support/Goby CLI/
        ~/Library/Application Support/Goby CLI Runtime/
      For automations: brew services start goby
      Before uninstall: finish active work, then goby uninstall
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/goby --version")
    assert_match "Exit codes:", shell_output("#{bin}/goby --help")
  end
end
