class GitTeam < Formula
  desc "Command line interface for managing and enhancing `git commit` messages with co-authors."
  homepage "https://github.com/hekmekk/git-team"
  url "https://github.com/hekmekk/git-team.git",
      :tag      => "v1.3.0",
      :revision => "fb9ad5c303438215f50b0a00f08b8b54c2976fda"
  head "https://github.com/hekmekk/git-team.git",
       :shallow => false

  bottle do
    cellar :any_skip_relocation
  end

  depends_on "go" => :build

  def install
    ENV.deparallelize
    ENV["XC_OS"] = "darwin"
    ENV["XC_ARCH"] = "amd64"
    ENV["GOPATH"] = buildpath/"go"
    system "make"
    bin.install "pkg/target/bin/git-team"
    hooks = "/usr/local/share/.config/git-team/hooks"
    mkdir_p hooks
    Pathname(hooks).install "pkg/target/bin/prepare-commit-msg"
    man1.install "pkg/target/man/git-team.1.gz"
    (etc/"bash_completion.d").install "bash_completion/git-team.bash" => "git-team"
  end

  test do
    system "#{bin}/git-team", "--version"
  end
end

