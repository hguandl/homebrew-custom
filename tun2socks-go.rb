class Tun2socksGo < Formula
  desc "A tun2socks implementation written in Go"
  homepage "https://github.com/eycorsican/go-tun2socks"
  url "https://github.com/hguandl/go-tun2socks/archive/v1.16.2.tar.gz"
  sha256 "d87ceb2b6957bb714e2d70eb01321e11acadb7ce9eda10ba28477ac329029afb"
  head "https://github.com/hguandl/go-tun2socks.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"

    # Version info independent from git
    inreplace "Makefile", "$(shell git describe --tags)", "v#{version}"

    system "make"

    bin.install "build/tun2socks"
  end
end
