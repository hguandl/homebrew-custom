class VapoursynthSangnom < Formula
  desc "Format-conversion plug-in for the Vapoursynth video processing engine"
  homepage "https://bitbucket.org/James1201/vapoursynth-sangnom"
  url "https://bitbucket.org/James1201/vapoursynth-sangnom/get/5a00bb64258d.tar.gz"
  version "20160831"
  sha256 "b78ba8edd6a7d856c0606de822111095e64b1f4d8cbbc311a5c52cca62d6137b"

  head do
    url "https://bitbucket.org/James1201/vapoursynth-sangnom", :using => :hg
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "vapoursynth"

  def install
    system "bash autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def post_install
    (HOMEBREW_PREFIX/"lib/vapoursynth").install_symlink prefix/"lib/libsangnom.dylib" => "libsangnom.dylib"
  end
end
