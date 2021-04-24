class GitTeam < Formula
  desc "Manage and enhance `git commit` messages with co-authors"
  homepage "https://github.com/hekmekk/git-team"
  url "https://github.com/hekmekk/git-team.git",
      :tag      => "v1.5.4",
      :revision => "60f09baec4dbac284239a73bf93952ff8c9c4cf5"
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

    hooks = Pathname.new("/usr/local/etc/git-team/hooks") # currently hard-coded within git-team
    hooks.mkpath
    hooks.install "target/bin/prepare-commit-msg-git-team"
    hooks.install "git-hooks/prepare-commit-msg.sh" => "prepare-commit-msg"

    available_git_hooks = [
      'applypatch-msg',
      'commit-msg',
      'fsmonitor-watchman',
      'p4-pre-submit',
      'post-applypatch',
      'post-checkout',
      'post-commit',
      'post-index-change',
      'post-merge',
      'post-receive',
      'post-rewrite',
      'post-update',
      'pre-applypatch',
      'pre-auto-gc',
      'pre-commit',
      'pre-push',
      'pre-rebase',
      'pre-receive',
      'push-to-checkout',
      'sendemail-validate',
      'update'
    ]

    hooks.install "git-hooks/proxy.sh" => "proxy.sh"

    for hook in available_git_hooks do
      hooks.install_symlink hooks/"proxy.sh" => hook
    end

    man1.install "target/man/git-team.1.gz"

    bash_completion = (etc/"bash_completion.d")
    bash_completion.mkpath
    bash_completion.install "bash_completion/git-team.bash" => "git-team"
  end

  test do
    system "#{bin}/git-team", "--version"
  end
end
