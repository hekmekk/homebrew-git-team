class GitTeam < Formula
  desc "Manage and enhance `git commit` messages with co-authors"
  homepage "https://github.com/hekmekk/git-team"
  url "https://github.com/hekmekk/git-team.git",
      :tag      => "v1.7.1",
      :revision => "02e9d736c3de74a6008de6044cf7b0b7ed195242"
  license "MIT"
  head "https://github.com/hekmekk/git-team.git", :branch => "main"

  depends_on "go@1.16" => :build
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
    bash_completion = (etc/"bash_completion.d")
    bash_completion.mkpath
    bash_completion.install "target/completion/bash/git-team.bash" => "git-team"
  end

  test do
    system "#{bin}/git-team", "--version"
  end
end
