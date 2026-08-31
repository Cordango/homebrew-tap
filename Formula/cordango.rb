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
  version "0.7.2"
  license "Apache-2.0"

  # No `depends_on`. The binary is self-contained: it carries its own .NET runtime and needs no
  # SDK, no ICU, and nothing else on the machine.
  on_macos do
    on_arm do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-osx-arm64.tar.gz"
      sha256 "ad6d0ee9d81960b1d105c716b0e0629218d4b2b86ba675336f119b42ba5b6598"
    end
    on_intel do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-osx-x64.tar.gz"
      sha256 "0c97bab9bd9081431809845853e6e1c70185d42d7d5915bd5331f8dc0cbf3bb5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-linux-arm64.tar.gz"
      sha256 "8a7bbd85e25077d40da6c58423b85f29c4dc7d3909ecd2f9ac9913f9315f8c27"
    end
    on_intel do
      url "https://github.com/cordango/cordango/releases/download/v#{version}/cordango-#{version}-linux-x64.tar.gz"
      sha256 "7b1e002d2bfa337253aeafeb08e2342aafe0424e7b82ba074f78a8fa34407370"
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
