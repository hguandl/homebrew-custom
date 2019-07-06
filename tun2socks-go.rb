class Tun2socksGo < Formula
  desc "A tun2socks implementation written in Go"
  homepage "https://github.com/eycorsican/go-tun2socks"
  url "https://github.com/hguandl/go-tun2socks/releases/download/v1.16.2/go-tun2socks-1.16.2.tar.gz"
  sha256 "147089b6fc038fe1b9a40c06711acacfed57a72b39ae1ab7191b3078b010bdc1"
  revision 2
  head "https://github.com/hguandl/go-tun2socks.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"

    # Use vendor for released code tarball
    if build.stable?
      ENV["GOFLAGS"] = "#{ENV["GOFLAGS"]} -mod=vendor"

    # Version info independent from git
    inreplace "Makefile", "$(shell git describe --tags)", "v#{version}"

    system "make"

    bin.install "build/tun2socks"
  end

  def caveats; <<~EOS
    tun2socks requires root privileges so you will need to run
    `sudo tun2socks`.
    You should be certain that you trust any software you grant root privileges.
  EOS
  end

  test do
    output = shell_output("#{bin}/tun2socks -version 2>&1", 0)
    assert_match "v#{version}", output
  end
end
