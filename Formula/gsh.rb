class Gsh < Formula
  desc "Extremely simple shell implementation"
  homepage "https://github.com/hguandl/gsh"
  url "https://github.com/hguandl/gsh/releases/download/1.0.2/gsh-1.0.2.tar.gz"
  sha256 "2a10cc3c0322bbcc7e690333ed546e7a78961f276a5ae0ef33681b925ec37b55"

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
