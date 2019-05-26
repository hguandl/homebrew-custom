class Vszimg < Formula
  desc "Scaling, colorspace conversion, and dithering library for VapourSynth"
  homepage "https://github.com/sekrit-twc/zimg"
  url "https://github.com/sekrit-twc/zimg/archive/release-2.0.1a.tar.gz"
  sha256 "b424eab91e0874b9289d8ca5238c7896c839a72256c0e6b949ae214a28291343"

  bottle do
    root_url "https://files.hguandl.com/bottles-custom"
    cellar :any
    sha256 "e7451608049ba15716d352d0988e1d3b4e2e9fa6c33102a1a42e2be5ffc05c53" => :mojave
  end

  head do
    url "https://github.com/sekrit-twc/zimg.git"
  end

  keg_only "Not a universal library",
    "it is a plugin for VapourSynth exclusively"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "vapoursynth"

  def install
    system "git checkout 1aa2811d" if build.head?
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def post_install
    (HOMEBREW_PREFIX/"lib/vapoursynth").install_symlink prefix/"lib/vszimg.so" => "vszimg.dylib"
  end

  def caveats; <<~EOS
    The original source of this formula was deprecated.
    This formula is used only for compatibility with old software.
    No update would be provided.
  EOS
  end
end
