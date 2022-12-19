[![Build Status](https://img.shields.io/github/actions/workflow/status/hekmekk/homebrew-git-team/verify.yml?branch=master&logo=github&style=for-the-badge)](https://github.com/hekmekk/homebrew-git-team/actions)

# homebrew-git-team

Homebrew formula for [git-team](https://github.com/hekmekk/git-team)

## Installation

1. Add tap
```bash
brew tap hekmekk/git-team
```

2. Install git-team

Install stable release. Use `--HEAD` in case you want to install from the latest commit.
```bash
brew install git-team
```

## Development
```bash
docker run --rm -i -t \
	-v `pwd`/Formula:/home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/hekmekk/homebrew-git-team/Formula \
	linuxbrew/brew:3.2.5 \
	/bin/sh -c "brew update && brew install --verbose git-team"
```

