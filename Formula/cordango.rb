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
  version "0.7.3"
  license "Apache-2.0"

  # No `depends_on`. The binary is self-contained: it carries its own .NET runtime and needs no
  # SDK, no ICU, and nothing else on the machine.
  on_macos do
    on_arm do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-osx-arm64.tar.gz"
      sha256 "5abfc964c27ce42650bd4cfc20449753a7d60c1348773d577734baade3c67573"
    end
    on_intel do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-osx-x64.tar.gz"
      sha256 "f422734e684c97d08322d436dcd934c8a6b9b288b36c764b14c64376320488ba"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-linux-arm64.tar.gz"
      sha256 "ab633450f642ab7992c10b2272ab0fcf0776f2b51a8b6f160fe21ce6b087aa6d"
    end
    on_intel do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-linux-x64.tar.gz"
      sha256 "76dc5d82d665e99af0feffe38841efb7e6e667302fd9152b5dfb0086102b82c0"
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
