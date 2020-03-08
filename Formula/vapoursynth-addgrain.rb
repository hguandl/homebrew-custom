class VapoursynthAddgrain < Formula
  desc "AddGrain filter for VapourSynth"
  homepage "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain"
  url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain/archive/r7.tar.gz"
  version "r7"
  sha256 "3adeb77f59b6da43663f906523eb19e47a16a8a9b9607ad97442f09ab12680b9"

  bottle do
    root_url "https://files.hguandl.com/bottles-custom"
    cellar :any
    sha256 "04521e008507fe6f05ea534c5faf2afc6d0090867c9865488e6389f3238b12b5" => :mojave
  end

  head do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain.git"
  end

  keg_only "Not a universal library",
    "it is a plugin for VapourSynth exclusively"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "vapoursynth"

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def post_install
    (HOMEBREW_PREFIX/"lib/vapoursynth").install_symlink prefix/"lib/libaddgrain.dylib" => "libaddgrain.dylib"
  end
end
