class Ffmpeg < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  url "https://ffmpeg.org/releases/ffmpeg-4.1.4.tar.xz"
  sha256 "f1f049a82fcfbf156564e73a3935d7e750891fab2abf302e735104fd4050a7e1"
  head "https://github.com/FFmpeg/FFmpeg.git"

  depends_on "nasm" => :build
  depends_on "pkg-config" => :build
  depends_on "texi2html" => :build

  depends_on "aom"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "frei0r"
  depends_on "lame"
  depends_on "hguandl/custom/libass"
  depends_on "libsoxr"
  depends_on "libvorbis"
  depends_on "libvpx"
  depends_on "opus"
  depends_on "rtmpdump"
  depends_on "rubberband"
  depends_on "snappy"
  depends_on "speex"
  depends_on "theora"
  depends_on "x264"
  depends_on "x265"
  depends_on "xvid"
  depends_on "xz"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-shared
      --enable-pthreads
      --enable-version3
      --enable-hardcoded-tables
      --enable-avresample
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
      --enable-gpl
      --enable-nonfree
      --enable-frei0r
      --enable-libass
      --enable-libaom
      --enable-libmp3lame
      --enable-libfontconfig
      --enable-libfreetype
      --enable-libopus
      --enable-librtmp
      --enable-librubberband
      --enable-libsnappy
      --enable-libtheora
      --enable-libvorbis
      --enable-libvpx
      --enable-libx264
      --enable-libx265
      --enable-libxvid
      --enable-libspeex
      --enable-libsoxr
    ]

    system "./configure", *args
    system "make", "install"

    # Build and install additional FFmpeg tools
    system "make", "alltools"
    bin.install Dir["tools/*"].select { |f| File.executable? f }
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
    assert_predicate mp4out, :exist?
  end
end
