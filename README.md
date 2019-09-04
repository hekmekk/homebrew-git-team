[![Build Status](https://travis-ci.org/hekmekk/homebrew-git-team.svg?branch=master)](https://travis-ci.org/hekmekk/homebrew-git-team)

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
docker run --rm -i -t -v `pwd`/Formula/:/home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/hekmekk/homebrew-git-team/Formula -v `pwd`/../git-team:/root/.cache/Homebrew/git-team--git linuxbrew/brew:2.1.10 /bin/bash
```

