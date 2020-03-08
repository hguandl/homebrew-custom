class RosPylib < Formula
  desc "Python libraries for ROS"
  homepage "https://github.com/hguandl/ros-src-snapshot"
  url "https://github.com/hguandl/ros-src-snapshot/releases/download/snapshot-20200308/ros-snapshot-20200308-1_pylib.tar.xz"
  sha256 "30db46932ede1d21926db9a7f38f1a643bd34377f121ddcdc8417ff4ec41fc0b"
  head "https://github.com/hguandl/ros-src-snapshot.git"

  depends_on "python"

  def install
    pyver = Language::Python.major_minor_version "python3"
    pypth = (opt_libexec/"python#{pyver}").to_s

    bin.install Dir["bin/catkin*"],
                Dir["bin/ros*"],
                "bin/wstool"
    libexec.install Dir["lib/*"]
    (lib/"python#{pyver}/site-packages").mkpath
    (lib/"python#{pyver}/site-packages/ros.pth").write pypth
  end

  test do
    system bin/"rosdep", "--help"
  end
end
