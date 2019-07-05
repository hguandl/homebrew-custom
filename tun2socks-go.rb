class Tun2socksGo < Formula
  desc "A tun2socks implementation written in Go"
  homepage "https://github.com/eycorsican/go-tun2socks"
  url "https://github.com/hguandl/go-tun2socks/archive/v1.16.2.tar.gz"
  sha256 "648658875ee81ba6a1197b1c7c5e16ef2422e10537665fa918b4fbe57ee08f31"
  revision 1
  head "https://github.com/hguandl/go-tun2socks.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"

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
