# plan9port-rb

![update version](https://img.shields.io/github/workflow/status/tizee/plan9port-rb/check-upstream/main)
![last commit](https://img.shields.io/github/last-commit/tizee/plan9port-rb/main)

Why? The `homebrew-core` has removed `plan9port` (see https://github.com/Homebrew/brew/issues/6478 and https://github.com/Homebrew/homebrew-core/pull/38394 ). So we cannot install with `brew install plan9port` anymore.

Use Github workflow to track lastest commit on master branch of [plan9port](https://github.com/9fans/plan9port.git) every day.

If there is a new commit, it would push to update version of this formula.

## Usage

```zsh
brew tap tizee/plan9port-rb
brew install plan9port
```
