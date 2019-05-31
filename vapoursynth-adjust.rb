class VapoursynthAdjust < Formula
  desc "A very basic port of the built-in Avisynth filter Tweak"
  homepage "https://github.com/dubhater/vapoursynth-adjust"
  url "https://github.com/dubhater/vapoursynth-adjust/archive/v1.tar.gz"
  version "v1"
  sha256 "f5b151ecc007ac784a360d84b6e4a8819d8e969dfdeacc5e4b1dfb2a6fda710f"

  head do
    url "https://github.com/dubhater/vapoursynth-adjust.git"
  end

  depends_on "python"
  depends_on "vapoursynth"

  def install
    python = Formula["python"] 
    xy = python.version.to_s.slice(/(3\.\d)/) || "3.7"
    libpath = prefix/"lib/python#{xy}/site-packages"
    libpath.mkpath
    mv("adjust.py", libpath/"adjust.py")
  end
end
