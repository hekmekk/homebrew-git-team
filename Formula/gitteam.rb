class Gitteam < Formula
  desc "Command line interface for managing and enhancing `git commit` messages with co-authors."
  homepage "https://github.com/hekmekk/git-team"
  url "https://github.com/hekmekk/git-team/archive/v1.3.0.tar.gz"
  sha256 "d185ef03830d75874eb71b2d8e9673ff3b15ae11561924e990b36379335a940f"
  head "https://github.com/hekmekk/git-team.git"

  bottle do
    cellar :any_skip_relocation
  end

  depends_on "go" => :build

  def install
    ENV["XC_OS"] = "darwin"
    ENV["XC_ARCH"] = "amd64"
    ENV["GOPATH"] = buildpath
    dir = buildpath/"go/src/github.com/hekmekk/git-team"
    dir.install buildpath.children
    cd dir do
      system "make"
      bin.install "pkg/target/bin/git-team"
      hooks = "#{HOMEBREW_PREFIX}/share/.config/git-team"
      mkdir_p hooks
      hooks.install "pkg/target/bin/prepare-commit-msg"
      man1.install "pkg/target/man/git-team.1.gz"
      (etc/"bash_completion.d").install "bash_completion/git-team.bash" => "git-team"
    end
  end

  test do
    system "#{bin}/git-team", "--version"
  end
end

