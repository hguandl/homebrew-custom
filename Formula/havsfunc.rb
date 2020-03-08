class Havsfunc < Formula
  desc "Holy's ported AviSynth functions for VapourSynth"
  homepage "https://github.com/HomeOfVapourSynthEvolution/havsfunc"
  url "https://github.com/HomeOfVapourSynthEvolution/havsfunc/archive/r31.tar.gz"
  version "r31"
  sha256 "caaacb4254ac4f0b653833648fb9913d7df865e32608980b52290485b9501b7d"

  head do
    url "https://github.com/HomeOfVapourSynthEvolution/havsfunc.git"
  end

  depends_on "hguandl/custom/mvsfunc"
  depends_on "hguandl/custom/nnedi3-resample"
  depends_on "hguandl/custom/vapoursynth-adjust"
  depends_on "python"
  depends_on "vapoursynth"

  def install
    python = Formula["python"] 
    xy = python.version.to_s.slice(/(3\.\d)/) || "3.7"
    libpath = prefix/"lib/python#{xy}/site-packages"
    libpath.mkpath
    mv("havsfunc.py", libpath/"havsfunc.py")
  end
end
