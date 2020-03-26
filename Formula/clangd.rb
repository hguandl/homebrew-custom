class Clangd < Formula
  desc "Language server that can work with many editors"
  homepage "https://clangd.llvm.org"
  url "https://github.com/clangd/clangd/releases/download/10rc3/clangd-mac-10rc3.zip"
  sha256 "7d8137f8c19d1464ce9a292942fa11672a7abacd5e7218159ae8eae22c2f784e"

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
