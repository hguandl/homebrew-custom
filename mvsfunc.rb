class Mvsfunc < Formula
  desc "mawen1250's VapourSynth functions"
  homepage "https://github.com/HomeOfVapourSynthEvolution/mvsfunc"
  url "https://github.com/HomeOfVapourSynthEvolution/mvsfunc/archive/r8.tar.gz"
  version "r8"
  sha256 "011a86eceb5485093d91a7c12a42bdf9f35384c6c89dc0ab92fca4481f68d373"

  head do
    url "https://github.com/HomeOfVapourSynthEvolution/mvsfunc.git"
  end

  depends_on "python"
  depends_on "vapoursynth"

  python = Formula["python"] 

  def install
    xy = python.version.to_s.slice(/(3\.\d)/) || "3.7"
    libpath = prefix/"lib/python#{xy}/site-packages"
    libpath.mkpath
    mv("mvsfunc.py", libpath/"mvsfunc.py")
  end
end
