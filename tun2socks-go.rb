class Tun2socksGo < Formula
  desc "A tun2socks implementation written in Go"
  homepage "https://github.com/eycorsican/go-tun2socks"
  url "https://github.com/eycorsican/go-tun2socks/archive/v1.16.1.tar.gz"
  sha256 "4a7178f75ea813e8ac49161ae6d8e004b848c4d1eccc44a432a908c1898ae138"
  head "https://github.com/eycorsican/go-tun2socks.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"

    inreplace "Makefile".gsub! "$(shell git describe --tags)", "v#{version}"

    system "go", "get", "-d", "./..."

    system "make"

    bin.install "build/tun2socks"
  end
end
