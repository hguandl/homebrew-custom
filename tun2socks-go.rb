class Tun2socksGo < Formula
  desc "A tun2socks implementation written in Go"
  homepage "https://github.com/eycorsican/go-tun2socks"
  url "https://github.com/hguandl/go-tun2socks/archive/v1.16.2.tar.gz"
  sha256 "d87ceb2b6957bb714e2d70eb01321e11acadb7ce9eda10ba28477ac329029afb"
  head "https://github.com/hguandl/go-tun2socks.git"

  bottle do
    root_url "https://files.hguandl.com/bottles-custom"
    cellar :any_skip_relocation
    sha256 "386b096bf2659b96a54dd2fb38d6c3f0ec74fa5b06953ab05951b2ac53ac2d25" => :mojave
  end

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
    output = shell_output("#{bin}/tun2socks --help 2>&1", 1)
    assert_match "Usage of tun2socks:", output
  end
end
