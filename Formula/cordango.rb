# The Cordango command line, as a Homebrew formula.
#
# THIS FILE BELONGS IN `cordango/homebrew-tap`, at `Formula/cordango.rb`. It is kept here so the
# canonical copy sits beside the workflow that produces the assets it points at.
#
# THE CHECKSUMS BELOW ARE ZEROS ON PURPOSE. They are of files that do not exist until the release is
# built, so this copy is the shape rather than the answer: `release.yml` runs `packaging/render.sh`
# over the real SHA256SUMS and attaches the finished formula to the release. Copy THAT into the tap.
# A formula carrying the previous release's checksums under this release's version would look
# finished and reject every download.
#
# A FORMULA RATHER THAN A CASK, deliberately. A cask is for .app bundles and installers, and Homebrew
# quarantines what a cask downloads — which is why unsigned casks make people run `brew trust` before
# anything will start. A formula extracts a tarball into the Cellar and is not quarantined, so an
# unsigned binary installed this way simply runs. That is what lets this ship before there is an
# Apple Developer ID to sign with.
class Cordango < Formula
  desc "Compile an App Definition into a complete application you own"
  homepage "https://github.com/cordango/cordango"
  version "0.6.1"
  license "Apache-2.0"

  # No `depends_on`. The binary is self-contained: it carries its own .NET runtime and needs no
  # SDK, no ICU, and nothing else on the machine.
  on_macos do
    on_arm do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-osx-arm64.tar.gz"
      sha256 "62a3f1f01629627280ff73f82dc194c7b4c22eb46556932d52202fa3e664187e"
    end
    on_intel do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-osx-x64.tar.gz"
      sha256 "ff442540d017dda3bb8d2e49c296501eddcd14b008c76fd502f88fc83c4b3ce0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-linux-arm64.tar.gz"
      sha256 "a5436730c8f8828cd88648d5c07f6d8843361872d5c19fe5003ee7a70bc46e61"
    end
    on_intel do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-linux-x64.tar.gz"
      sha256 "82f405aedaea05a6373b7eaaeed880a1f3b7e9fc3203f8da2a810b2cf7e1c0c6"
    end
  end

  def install
    bin.install "cordango"
  end

  # `brew test` runs this. Deliberately a command that exercises the embedded resources rather than
  # just printing a string: `version` reports the App Definition schema version, which means the
  # schema was found inside the single-file bundle. A binary that started but could not read its own
  # resources would pass a plainer test and fail on the user's first real command.
  test do
    assert_match "App Definition schema", shell_output("#{bin}/cordango version")
  end
end
