class Nnedi3Resample < Formula
  desc "mawen1250's VapourSynth script"
  homepage "https://github.com/mawen1250/VapourSynth-script"
  url "https://github.com/mawen1250/VapourSynth-script/archive/0983895c8a0fe65d8b342e1875294d2681c75e84.tar.gz"
  version "20180511"
  sha256 "1a704e7f03573b5e75d9a8f5417004b2c51e1ccf4264f2dace9d9736eee83bf7"

  head do
    url "https://github.com/mawen1250/VapourSynth-script.git"
  end

  depends_on "hguandl/custom/mvsfunc"
  depends_on "python"
  depends_on "vapoursynth"

  def install
    python = Formula["python"] 
    xy = python.version.to_s.slice(/(3\.\d)/) || "3.7"
    libpath = prefix/"lib/python#{xy}/site-packages"
    libpath.mkpath
    mv("nnedi3_resample.py", libpath/"nnedi3_resample.py")
  end
end
