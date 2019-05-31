class VapoursynthNnedi3 < Formula
  desc "nnedi3 filter for VapourSynth"
  homepage "https://github.com/dubhater/vapoursynth-nnedi3"
  url "https://github.com/dubhater/vapoursynth-nnedi3/archive/v12.tar.gz"
  sha256 "235f43ef4aac04ef2f42a8c44c2c16b077754a3e403992df4b87c8c4b9e13aa5"

  head do
    url "https://github.com/HomeOfVapourSynthEvolution/vapoursynth-nnedi3.git"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "vapoursynth"
  depends_on "yasm" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def post_install
    (HOMEBREW_PREFIX/"lib/vapoursynth").install_symlink prefix/"lib/libnnedi3.dylib" => "libnnedi3.dylib"
  end
end
