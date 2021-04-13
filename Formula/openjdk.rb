class Openjdk < Formula
  desc "Development kit for the Java programming language"
  homepage "https://openjdk.java.net/"
  url "http://hg.openjdk.java.net/jdk/jdk/file/bc54620a3848/README"
  version "13.0.2+8"
  sha256 "e691f5732cb2883f32a34a80e1819c76ab0fa23f6282c0d1db4fb4ecc52d9edd"
  revision 2

  bottle :unneeded

  def install
    ohai "OpenJDK has been installed as a meta package with version #{version}."
    prefix.install "README" => "openjdk.txt"
  end

  test do
    system "java", "-version"
  end
end
