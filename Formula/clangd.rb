class Clangd < Formula
  desc "Language server that can work with many editors"
  homepage "https://clangd.llvm.org"
  url "https://github.com/clangd/clangd/releases/download/10.0.0/clangd-mac-10.0.0.zip"
  sha256 "c3012b90898257ac2402ee9f406810006920c6b9fcee1179fe345f3e9414566b"

  bottle :unneeded

  conflicts_with "llvm", :because => "clangd is included in LLVM"

  def install
    bin.install "bin/clangd"
    lib.install Dir["lib/*"]
  end

  test do
    system "#{bin}/clangd", "--version"
  end
end
