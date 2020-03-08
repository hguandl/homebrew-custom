class RosPylib < Formula
  desc "Python libraries for ROS"
  homepage "https://github.com/hguandl/ros-src-snapshot"
  url "https://github.com/hguandl/ros-src-snapshot/releases/download/snapshot-20200308-3/requirements-snapshot-20200308-3.txt"
  sha256 "3ffa69238687cbc7d2d456da5b7978a666580c14c211b0039ef6f04b6fad6920"
  head "https://github.com/hguandl/ros-src-snapshot.git"

  bottle do
    root_url "https://dl.bintray.com/hguandl/homebrew-custom/bottles"
    cellar :any_skip_relocation
    sha256 "f2f685a1f8203e8d556c99cea69182ba060eafd9921fc899276a46976e22c2a8" => :mojave
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
