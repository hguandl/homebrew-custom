class Boringssl < Formula
  desc "SSL/TLS cryptography library by Google"
  homepage "https://boringssl.googlesource.com/boringssl/"
  url "https://boringssl.googlesource.com/boringssl/+archive/d2a0ffdfa781dd6fde482ccb924b4a756731f238.tar.gz"
  mirror "https://github.com/google/boringssl/archive/d2a0ffdfa781dd6fde482ccb924b4a756731f238.tar.gz"
  version "20190208"
  head "https://boringssl.googlesource.com/boringssl", :using => :git

  bottle do
    root_url "https://files.hguandl.com/bottles-custom"
    sha256 mojave: "e77763c8164200f697fd30be4524a48312446c6ece2817c195c595739d7ceed3"
  end

  keg_only :provided_by_macos,
    "Apple has its own TLS and crypto libraries"

  depends_on "cmake" => :build
  depends_on "go" => :build
  depends_on "ninja" => :build

  def install
    # Static libraries
    args = %w[
      -DCMAKE_BUILD_TYPE=Release
      -GNinja
    ]

    # Build with CMake & Ninja
    mkpath "build"
    Dir.chdir("build") do
      system "cmake", *args, ".."
      system "ninja"
    end

    # Shared libraries
    args << "-DBUILD_SHARED_LIBS=1"
    args << "-DCMAKE_MACOSX_RPATH=1"

    Dir.chdir("build") do
      system "cmake", *args, ".."
      system "ninja"
    end

    # Setup rpath
    tmppath = buildpath.to_s.sub! "/private/tmp", "/tmp"

    ## libssl
    MachO::Tools.change_rpath("build/ssl/libssl.dylib",
                              "#{tmppath}/build/crypto",
                              "#{opt_prefix}/lib")

    ## bssl
    MachO::Tools.delete_rpath("build/tool/bssl", "#{tmppath}/build/ssl")
    MachO::Tools.delete_rpath("build/tool/bssl", "#{tmppath}/build/crypto")
    MachO::Tools.add_rpath("build/tool/bssl", "#{opt_prefix}/lib")

    # Install
    bin.install "build/tool/bssl"
    include.install Dir["include/*"]
    lib.install "build/crypto/libcrypto.a", "build/crypto/libcrypto.dylib",
                "build/ssl/libssl.a", "build/ssl/libssl.dylib"
  end

  test do
    # Check SHA256 function as expected.
    (testpath/"testfile.txt").write("This is a test file")
    expected_checksum = "e2d0fe1585a63ec6009c8016ff8dda8b17719a637405a4e23c0ff81339148249"
    checksum = `#{bin}/bssl sha256sum testfile.txt`.split("  ").first.strip
    assert_equal checksum, expected_checksum
  end
end
