class Ros < Formula
  desc "Libraries and tools to create robot applications"
  homepage "https://www.ros.org"
  url "https://github.com/hguandl/ros-src-snapshot/releases/download/snapshot-20200308-3/ros-snapshot-20200308-3.tar.xz"
  sha256 "a0bd5fa26255a7cee6ff69312f3cd80b462069da4e380bc9166b129ded84947b"
  revision 1
  head "https://github.com/hguandl/ros-src-snapshot.git"

  bottle do
    root_url "https://dl.bintray.com/hguandl/homebrew-custom/bottles"
    sha256 "e38d9472835660bd6df3b4d78484908622266a2385892d532fed3bc5e67aee14" => :mojave
  end

  keg_only "isolated",
  "it needs isolated environment"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  depends_on "boost"
  depends_on "boost-python3"
  depends_on "fltk"
  depends_on "gpgme"
  depends_on "hguandl/custom/ros_pylib"
  depends_on "lz4"
  depends_on "nagakiran/deps/tango-icon-theme"
  depends_on "opencv@3"
  depends_on "openssl@1.1"
  depends_on "orocos-kdl"
  depends_on "osrf/simulation/gazebo9"
  depends_on "pcl"
  depends_on "poco"
  depends_on "py3cairo"
  depends_on "qt"
  depends_on "sbcl"
  depends_on "yaml-cpp"

  def install
    python = Formula["python"]
    pyver = Language::Python.major_minor_version "python3"
    pylib = Formula["ros_pylib"]

    qt = Formula["qt"]
    boost = Formula["boost"]
    opencv = Formula["opencv@3"]
    openssl = Formula["openssl@1.1"]
    ENV["ROS_PYTHON_VERSION"] = pyver.to_s
    ENV["PYTHONPATH"] = pylib.opt_libexec/"python#{pyver}"
    ENV["CMAKE_PREFIX_PATH"] = "#{qt.opt_prefix}:#{opencv.opt_prefix}:#{openssl.opt_prefix}"

    installargs = %W[
      --directory #{buildpath}
      --source #{buildpath}/src
      --build #{buildpath}/build_isolated
      --devel #{buildpath}/devel_isolated
      --install-space #{prefix}/#{rosdistro}
      --use-ninja
      --install
      -DCATKIN_ENABLE_TESTING=OFF
      -DCMAKE_BUILD_TYPE=Release
      -DCMAKE_CXX_STANDARD=14
      -DCMAKE_FIND_FRAMEWORK=LAST
      -DCMAKE_INSTALL_RPATH=#{prefix}/#{rosdistro}/lib
      -DCMAKE_MACOSX_RPATH=ON
      -DPYTHON_VERSION=#{pyver}
    ]
    system "./src/catkin/bin/catkin_make_isolated", *installargs
  end

  def caveats
    <<~EOS
      Installation successful, please source the ROS workspace:

        source #{opt_prefix}/#{rosdistro}/setup.#{Utils::Shell.preferred}
    EOS
  end

  def rosdistro;
    "melodic"
  end

  test do
    system "source" "#{opt_prefix}/#{rosdistro}/setup.#{Utils::Shell.preferred}"
    system "roscore", "-h"
  end
end
