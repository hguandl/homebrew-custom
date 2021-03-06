class Fmtconv < Formula
  desc "Format-conversion plug-in for the Vapoursynth video processing engine"
  homepage "https://github.com/EleonoreMizo/fmtconv"
  url "https://github.com/EleonoreMizo/fmtconv/archive/r20.tar.gz"
  version "r20"
  sha256 "44f2f2be05a0265136ee1bb51bd08e5a47c6c1e856d0d045cde5a6bbd7b4350c"

  bottle do
    root_url "https://files.hguandl.com/bottles-custom"
    cellar :any
    sha256 "4c99db478c691c854735cb40e5c4db41f7f459a5a7fdc5d3c93825a3aa5c691c" => :mojave
  end

  head do
    url "https://github.com/EleonoreMizo/fmtconv.git"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "vapoursynth"

  def install
    Dir.chdir("build/unix") do
      system "./autogen.sh"
      system "./configure", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  def post_install
    (HOMEBREW_PREFIX/"lib/vapoursynth").install_symlink prefix/"lib/libfmtconv.dylib" => "libfmtconv.dylib"
  end
end
