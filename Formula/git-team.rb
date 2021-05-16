class GitTeam < Formula
  desc "Manage and enhance `git commit` messages with co-authors"
  homepage "https://github.com/hekmekk/git-team"
  url "https://github.com/hekmekk/git-team.git",
      :tag      => "v1.5.6-rc1",
      :revision => "89e87f26049cdce95452478112570158ebcaac35"
  head "https://github.com/hekmekk/git-team.git",
       :shallow => false

  depends_on "go" => :build

  def install
    ENV.deparallelize
    ENV["XC_OS"] = "darwin"
    ENV["XC_ARCH"] = "amd64"
    ENV["GOPATH"] = buildpath/"go"

    (buildpath/"go/bin").mkpath
    (buildpath/"target/bin").mkpath

    system "make"

    bin.install "target/bin/git-team"

    man1.install "target/man/git-team.1.gz"

    bash_completion = (etc/"bash_completion.d")
    bash_completion.mkpath
    bash_completion.install "bash_completion/git-team.bash" => "git-team"
  end

  test do
    system "#{bin}/git-team", "--version"
  end
end
