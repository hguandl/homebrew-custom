class Libass < Formula
  desc "Subtitle renderer for the ASS/SSA subtitle format, use fontconfig"
  homepage "https://github.com/libass/libass"
  url "https://github.com/libass/libass/releases/download/0.14.0/libass-0.14.0.tar.xz"
  sha256 "881f2382af48aead75b7a0e02e65d88c5ebd369fe46bc77d9270a94aa8fd38a2"
  revision 1

  bottle do
    root_url "https://files.hguandl.com/bottles-custom"
    cellar :any
    sha256 "3e8aba5fe2d712fdf8adb1010d88453712158675fe15c46c6974264b91c149da" => :catalina
    sha256 "c48952c93d75b1e2b5bb8a8edf990d5a6b587de1d036d396366b6fce607db15e" => :mojave
  end

  head do
    url "https://github.com/libass/libass.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "nasm" => :build
  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "fribidi"
  depends_on "harfbuzz"

  def install
    system "autoreconf", "-i" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-fontconfig",
                          "--disable-coretext"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "ass/ass.h"
      int main() {
        ASS_Library *library;
        ASS_Renderer *renderer;
        library = ass_library_init();
        if (library) {
          renderer = ass_renderer_init(library);
          if (renderer) {
            ass_renderer_done(renderer);
            ass_library_done(library);
            return 0;
          }
          else {
            ass_library_done(library);
            return 1;
          }
        }
        else {
          return 1;
        }
      }
    EOS
    system ENV.cc, "test.cpp", "-I#{include}", "-L#{lib}", "-lass", "-o", "test"
    system "./test"
  end
end
