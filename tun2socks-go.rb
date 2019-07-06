class Tun2socksGo < Formula
  desc "A tun2socks implementation written in Go"
  homepage "https://github.com/eycorsican/go-tun2socks"
  url "https://github.com/hguandl/go-tun2socks/releases/download/v1.16.2/go-tun2socks-1.16.2.tar.gz"
  sha256 "a1c8e399459e40da2488989b4ff9085c34c9f7a62ae104fe0daf60194c3a8cfd"
  revision 2
  head "https://github.com/hguandl/go-tun2socks.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"

    if build.stable?
      # Use vendor for released code tarball
      ENV["GOFLAGS"] = "#{ENV["GOFLAGS"]} -mod=vendor"
    else
      # Version info independent from git
      inreplace "Makefile", "$(shell git describe --tags)", "v#{version}"
    end

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
