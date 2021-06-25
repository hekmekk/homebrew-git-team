class GitTeam < Formula
  desc "Manage and enhance `git commit` messages with co-authors"
  homepage "https://github.com/hekmekk/git-team"
  url "https://github.com/hekmekk/git-team.git",
      :tag      => "v1.7.0",
      :revision => "d9b0234268adcbe540e242e778784975bcfa3a98"
  head "https://github.com/hekmekk/git-team.git",
       :shallow => false

  depends_on "go" => :build

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
