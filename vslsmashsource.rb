class Vslsmashsource < Formula
  desc "LSMASHSource for VapourSynth"
  homepage "https://github.com/VFR-maniac/L-SMASH-Works/tree/master/VapourSynth"
  url "https://github.com/VFR-maniac/L-SMASH-Works/archive/3edd194b1d82975cee67c0278556615c7d9ebd36.tar.gz"
  version "20171028"
  sha256 "67a4781c9701f3ff1ad5a22744305e846d32e0e0174da10e38e8791e9f06a621"

  head do
    url "https://github.com/VFR-maniac/L-SMASH-Works.git"
  end

  depends_on "pkg-config" => :build
  depends_on "vapoursynth"

  def install
    Dir.chdir("VapourSynth") do
      system "./configure", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  def caveats; <<~EOS
    This formula implictly depends on FFmpeg, while there might be various formular to choose.
    To use the officially maintained one by Homebrew, execute:
      brew install ffmpeg
    To use the light-weight one by the author of this tap, execute:
      brew install hguandl/custom/ffmpeg
    The specific dependencies are listed below, make sure they exist in /usr/local/lib:
      libavformat.58.dylib
      libavcodec.58.dylib
      libswscale.5.dylib
      libavutil.56.dylib
  EOS
  end
end
