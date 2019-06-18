class Tun2socksGo < Formula
  desc "A tun2socks implementation written in Go"
  homepage "https://github.com/eycorsican/go-tun2socks"
  url "https://github.com/eycorsican/go-tun2socks/archive/v1.16.1.tar.gz"
  sha256 "4a7178f75ea813e8ac49161ae6d8e004b848c4d1eccc44a432a908c1898ae138"
  head "https://github.com/eycorsican/go-tun2socks.git"

  bottle do
    root_url "https://files.hguandl.com/bottles-custom"
    cellar :any_skip_relocation
    sha256 "9f8209f89a43fb983cb6d9f3485618ec6d901bd0268f285de6c583a8d0abb331" => :mojave
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"

    inreplace "Makefile".gsub! "$(shell git describe --tags)", "v#{version}"

    system "go", "get", "-d", "./..."

    system "make"

    bin.install "build/tun2socks"
  end
end
