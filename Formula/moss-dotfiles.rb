# Homebrew formula — moss dotfiles (legacy monorepo)
#
# NOTE: This formula is being replaced by per-config Nix flakes.
# See individual repos:
#   nix run github:you/nvim-config
#   nix run github:you/kitty-config
#   nix run github:you/zsh-config
#   nix run github:you/pi-config
#
# Or the aggregator:
#   nix run github:you/dotfiles
#
# This formula still works for brew-only workflows.
# Usage: brew install --formula --HEAD <raw URL>
#
class MossDotfiles < Formula
  desc "Moss dotfiles — nvim + kitty + zsh + pi configuration"
  homepage "https://github.com/advicktory/.dotfiles"
  version "1.0.0"
  license "MIT"

  head "https://github.com/advicktory/.dotfiles.git", branch: "main"

  depends_on "neovim"
  depends_on "ripgrep"
  depends_on "fzf"
  depends_on "fd"
  depends_on "node"
  depends_on "git"
  depends_on "tree-sitter"
  depends_on "powerlevel10k"
  depends_on "zsh-autosuggestions"
  depends_on "zsh-syntax-highlighting"

  def install
    # Parent install.sh clones each sub-repo and runs its installer
    system "bash", "install.sh", "all" if File.exist?("install.sh")
  end

  def caveats
    <<~EOS
      🌿  moss dotfiles #{version}

      Installed via sub-config installers.

      Next steps:
        1. Restart kitty for config to take effect
        2. Launch nvim — plugins auto-install via lazy.nvim
        3. In nvim, :Mason to install LSP servers
        4. Font: copy Hack Nerd Font .ttf to ~/Library/Fonts/

      For individual Nix installs:
        nix run github:advicktory/nvim-config
        nix run github:advicktory/kitty-config
        nix run github:advicktory/zsh-config
        nix run github:advicktory/pi-config
    EOS
  end

  test do
    assert_predicate prefix, :exist?
  end
end
