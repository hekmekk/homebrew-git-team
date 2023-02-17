class GitTeam < Formula
  desc "Manage and enhance `git commit` messages with co-authors"
  homepage "https://github.com/hekmekk/git-team"
  url "https://github.com/hekmekk/git-team.git",
      :tag      => "v0.0.54",
      :revision => "fd2770b2f98cec8f0da4b5ab7f9c6d49619d2971"
  license "MIT"
  head "https://github.com/hekmekk/git-team.git", :branch => "main"

  depends_on "go@1.18" => :build
  depends_on "git"

  def install
    ENV.deparallelize
    ENV["XC_OS"] = "darwin"
    ENV["XC_ARCH"] = "amd64"
    ENV["GOPATH"] = buildpath/"go"

    system "go", "install", "./..."
    bin.install buildpath/"go/bin/git-team"

    system "make", "man-page"
    man1.install "target/man/git-team.1.gz"

    system "make", "completion"
    bash_completion = (share/"bash-completion/completions")
    bash_completion.mkpath
    bash_completion.install "target/completion/bash/git-team.bash" => "git-team"
    zsh_completion = (share/"zsh/site-functions")
    zsh_completion.mkpath
    zsh_completion.install "target/completion/zsh/git-team.zsh" => "_git-team"
  end

  test do
    system "#{bin}/git-team", "--version"
  end
end
