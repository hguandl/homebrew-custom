class Ros < Formula
  desc "Libraries and tools to create robot applications"
  homepage "https://www.ros.org"
  url "https://github.com/hguandl/ros-src-snapshot/releases/download/snapshot-20200322/ros-snapshot-20200322.tar.xz"
  sha256 "ece307afd3734fceff0572286f44a4c6ab41362bbb8bc6d501fba28997587f26"
  head "https://github.com/hguandl/ros-src-snapshot.git"

  bottle do
    root_url "https://dl.bintray.com/hguandl/homebrew-custom/bottles"
    sha256 catalina: "85c07620ee780822f3641aad7be508086e58cc95e95f9da5a96901d5b8af0c25"
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
  depends_on "hguandl/custom/gtest"
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
  depends_on "pyqt"
  depends_on "qt"
  depends_on "sbcl"
  depends_on "yaml-cpp"

  def install
    python = Formula["python"]
    pyver = Language::Python.major_minor_version python.bin/"python3"
    pylib = Formula["ros_pylib"]

    gtest = Formula["hguandl/custom/gtest"]
    opencv = Formula["opencv@3"]
    openssl = Formula["openssl@1.1"]
    qt = Formula["qt"]
    ENV["ROS_PYTHON_VERSION"] = pyver.to_s
    ENV["PYTHONPATH"] = pylib.opt_libexec/"python#{pyver}"
    ENV["CMAKE_PREFIX_PATH"] = "#{gtest.opt_prefix}:#{opencv.opt_prefix}:#{openssl.opt_prefix}:#{qt.opt_prefix}"

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
    python = Formula["python"]
    <<~EOS
      To activate the environment, please source the ROS workspace and add Python 3 to PATH:

        source #{opt_prefix}/#{rosdistro}/setup.#{Utils::Shell.preferred}
        export #{python.opt_libexec}/bin:$PATH
    EOS
  end

  def rosdistro
    "melodic"
  end

  test do
    system "source" "#{opt_prefix}/#{rosdistro}/setup.#{Utils::Shell.preferred}"
    system "roscore", "-h"
  end
end
