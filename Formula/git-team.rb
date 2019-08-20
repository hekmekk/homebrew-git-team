class GitTeam < Formula
  desc "Manage and enhance `git commit` messages with co-authors"
  homepage "https://github.com/hekmekk/git-team"
  url "https://github.com/hekmekk/git-team.git",
      :tag      => "v1.3.1",
      :revision => "402431e52dda2feeb4954c5730491777bea8ceb4"
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

    (buildpath/"go/bin").mkpath
    (buildpath/"pkg/target/bin").mkpath

    system "make"

    bin.install "pkg/target/bin/git-team"

    hooks = (etc/"git-team/hooks")
    hooks.mkpath
    hooks.install "pkg/target/bin/prepare-commit-msg"

    man1.install "pkg/target/man/git-team.1.gz"

    bash_completion = (etc/"bash_completion.d")
    bash_completion.mkpath
    bash_completion.install "bash_completion/git-team.bash" => "git-team"
  end

  test do
    system "#{bin}/git-team", "--version"
  end
end
