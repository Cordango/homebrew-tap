# Contributing

This repository is a **delivery channel**, not a codebase. It holds one Homebrew formula and nothing else.

By taking part you agree to the [Code of Conduct](CODE_OF_CONDUCT.md).

## Where to report what

**A bug in `cordango` itself** — the command, the compiler, or the code it generates — belongs in
[cordango/cordango](https://github.com/cordango/cordango/issues/new/choose). Nothing here can fix it.

**A problem installing** — the wrong version resolves, a checksum does not match, the install fails
on your platform — belongs here. That is what this repository is for.

## Editing the manifest

`Formula/cordango.rb` is **generated**. The canonical copy lives at `packaging/homebrew/cordango.rb` in the compiler
repository and is copied here on release with the version and checksums taken from that release's own
`SHA256SUMS`.

Edit it there. A fix made only here is undone by the next release.

## Getting help

- [hello@cordango.com](mailto:hello@cordango.com)
