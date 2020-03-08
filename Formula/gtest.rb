class Gtest < Formula
  desc "Google Testing and Mocking Framework"
  homepage "https://github.com/google/googletest"
  url "https://github.com/google/googletest/archive/release-1.8.1.tar.gz"
  sha256 "9bf1fe5182a604b4135edc1a425ae356c9ad15e9b23f9f12a02e80184c3a249c"
  head "https://github.com/google/googletest.git"

  bottle do
    root_url "https://dl.bintray.com/hguandl/homebrew-custom/bottles"
    cellar :any_skip_relocation
    sha256 "d47c1dc5bd320e92945d60d97b0a800b691a4b677b56b99fc8314c03ca83caf6" => :mojave
  end

  keg_only "isolate environment",
  "it may conflict with other libraries"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  def install
    args = %W[
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -GNinja
    ]

    mkpath "build"
    Dir.chdir("build") do
      system "cmake", *args, ".."
      system "ninja", "install"
    end
  end

  test do
    (lib/"libgtest.a").exist?
  end
end
