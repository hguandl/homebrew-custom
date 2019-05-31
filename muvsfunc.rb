class Muvsfunc < Formula
  desc "Muonium's VapourSynth functions"
  homepage "https://github.com/WolframRhodium/muvsfunc"
  url "https://github.com/WolframRhodium/muvsfunc/archive/v0.2.0.tar.gz"
  sha256 "2c6c3bd1a8ede6b9dbe39fd981c9e79badcbe1335939f53f55269c53bb960a2b"

  head do
    url "https://github.com/WolframRhodium/muvsfunc.git"
  end

  depends_on "hguandl/custom/havsfunc"
  depends_on "hguandl/custom/mvsfunc"
  depends_on "python"
  depends_on "vapoursynth"

  def install
    python = Formula["python"] 
    xy = python.version.to_s.slice(/(3\.\d)/) || "3.7"
    libpath = prefix/"lib/python#{xy}/site-packages"
    libpath.mkpath
    mv("muvsfunc.py", libpath/"muvsfunc.py")
    mv("LUM.py", libpath/"LUM.py")
    mv("muvsfunc_misc.py", libpath/"muvsfunc_misc.py")
    mv("muvsfunc_numpy.py", libpath/"muvsfunc_numpy.py")
    mv("SuperRes.py", libpath/"SuperRes.py")
  end
end
