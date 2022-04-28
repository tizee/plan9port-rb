# plan9port-rb

Why? The `homebrew-core` has removed `plan9port` (see [brew#6478] and [homebrew-core#38394]). So we cannot install with `brew install plan9port` anymore.

Use Github workflow to track lastest commit on master branch of [plan9port](https://github.com/9fans/plan9port.git) every day.

If there is a new commit, it would generate push to update version of this formula.

[brew#6478](https://github.com/Homebrew/brew/issues/6478)
[homebrew-core#38394](https://github.com/Homebrew/homebrew-core/pull/38394)

## Usage

```zsh
brew tap tizee/plan9port-rb
brew install plan9port
```
