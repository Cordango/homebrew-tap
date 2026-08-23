# Cordango — Homebrew tap

The `cordango` command line, for macOS and Linux.

```sh
brew install cordango/tap/cordango
cordango --help
```

Or tap it first, if you would rather see what you are adding:

```sh
brew tap cordango/tap
brew install cordango
```

## What you get

One self-contained binary. It carries its own .NET runtime, so there is no SDK to install, no ICU to
install, and no `depends_on` in the formula — which is also why it runs on a slim container image
that has nothing else on it.

`cordango` compiles an App Definition into a complete application you own: ASP.NET Core with MVC
controllers, EF Core against PostgreSQL, and Vue 3 on the front. Nothing it generates depends on
Cordango at run time.

## A formula, not a cask

Homebrew quarantines what a cask downloads, which is why unsigned casks make people run extra
commands before anything will start. A formula extracts a tarball into the Cellar and is not
quarantined, so this runs as installed. That is what lets it ship before there is an Apple Developer
ID to sign with.

## Where this comes from

The formula is generated from [cordango/cordango](https://github.com/cordango/cordango) —
`packaging/homebrew/cordango.rb` — and copied here on release with the checksums taken from that
release's own `SHA256SUMS`. Report anything wrong with the tool there; this repository is the
delivery channel.

## Other ways to install

```sh
dotnet tool install -g Cordango.Cli    # if you already have the .NET SDK
```

Or download a binary directly from the
[releases](https://github.com/cordango/cordango/releases).

## License

Apache-2.0.
