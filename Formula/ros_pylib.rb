class RosPylib < Formula
  desc "Python libraries for ROS"
  homepage "https://github.com/hguandl/ros-src-snapshot"
  url "https://github.com/hguandl/ros-src-snapshot/releases/download/snapshot-20200308-4/requirements-snapshot-20200308-4.txt"
  sha256 "b92b1474464e602a9e7e3c2c55427d64a542199471db2e289922159cba2cdbd7"
  head "https://github.com/hguandl/ros-src-snapshot.git"

  bottle do
    root_url "https://dl.bintray.com/hguandl/homebrew-custom/bottles"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "4ee1350d39378af4fdf09f2aa1d7054e242981c52e7224b3bbf04d9cc4adec09" => :mojave
  end

  depends_on "python"

  def install
    python = Formula["python"]
    pyver = Language::Python.major_minor_version "python3"
    pypth = (opt_libexec/"python#{pyver}\n").to_s

    args = %W[
      -r
      requirements-snapshot-#{version}.txt
      --target
      #{buildpath}/target
    ]
    system python.opt_bin/"pip3", "install", *args

    mv("target/bin", ".")
    bin.install Dir["bin/catkin*"],
                Dir["bin/ros*"],
                "bin/wstool"
    (libexec/"python#{pyver}").install Dir["target/*"]
    (lib/"python#{pyver}/site-packages").mkpath
    (lib/"python#{pyver}/site-packages/ros.pth").write pypth
  end

  test do
    system bin/"rosdep", "--help"
  end
end
