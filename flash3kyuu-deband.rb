class Flash3kyuuDeband < Formula
  desc "A deband library and filter for avisynth/vapoursynth"
  homepage "https://github.com/SAPikachu/flash3kyuu_deband"
  url "https://github.com/SAPikachu/flash3kyuu_deband/archive/2.0.0-1.tar.gz"
  version "2.0.0"
  revision 1
  sha256 "5f68d017b45f8aecfeee3ac5343964c71eb8cbc209711aa5ad4dc9408f90f411"

  head do
    url "https://github.com/SAPikachu/flash3kyuu_deband.git"
  end

  depends_on "pkg-config" => :build
  depends_on "vapoursynth"

  def install
    system "./waf", "configure", "--prefix=#{prefix}"
    system "./waf", "build"
    system "./waf", "install"
  end

  def post_install
    (HOMEBREW_PREFIX/"lib/vapoursynth").install_symlink prefix/"lib/libf3kdb.dylib" => "libf3kdb.dylib"
  end
end
