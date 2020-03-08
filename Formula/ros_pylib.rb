class RosPylib < Formula
  desc "Python libraries for ROS"
  homepage "https://github.com/hguandl/ros-src-snapshot"
  url "https://github.com/hguandl/ros-src-snapshot/releases/download/snapshot-20200308-1/ros-snapshot-20200308-1_pylib.tar.xz"
  sha256 "99982fe2e97223d195bb430b6c819d52183919e27a0c5e40757b54c47195677f"
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
