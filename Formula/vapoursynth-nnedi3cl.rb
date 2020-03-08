class VapoursynthNnedi3cl < Formula
  desc "NNEDI3CL filter for VapourSynth"
  homepage "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL"
  url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL/archive/r7.3.tar.gz"
  version "r7.3"
  sha256 "01a162c036bd7f723c94160a820461fbde34cd3810194c273979cb0453b2d66b"

  bottle do
    root_url "https://files.hguandl.com/bottles-custom"
    cellar :any
    sha256 "a603b4632a2cee3b843a5a7b957a75b2465096bc33893013dccd2fb9709c1767" => :mojave
  end

  head do
    url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL.git"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "vapoursynth"

  def install
    system "meson build"
    system "ninja -C build"
    lib.install "build/libnnedi3cl.dylib"
    lib.install "NNEDI3CL/nnedi3_weights.bin"
  end

  def post_install
    (HOMEBREW_PREFIX/"lib/vapoursynth").install_symlink prefix/"lib/libnnedi3cl.dylib" => "libnnedi3cl.dylib"
  end
end
