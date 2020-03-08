class Gsh < Formula
  desc "Extremely simple shell implementation"
  homepage "https://github.com/hguandl/gsh"
  url "https://github.com/hguandl/gsh/releases/download/1.0.2/gsh-1.0.2.tar.gz"
  sha256 "2a10cc3c0322bbcc7e690333ed546e7a78961f276a5ae0ef33681b925ec37b55"

  bottle do
    root_url "https://dl.bintray.com/hguandl/homebrew-custom/bottles"
    cellar :any_skip_relocation
    sha256 "dad0d12fd9c7be109094f3862190d613a6ce717c14a0da259995576e95a41a1b" => :mojave
  end

  head do
    url "https://github.com/hguandl/gsh.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    if build.head?
      autoconf = Formula["autoconf"]
      system autoconf.bin/"autoreconf", "-f", "-i"
    end

    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (bin/"gsh").exist?
  end
end
