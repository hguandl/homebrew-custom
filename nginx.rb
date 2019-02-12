class Nginx < Formula
  desc "HTTP(S) server and reverse proxy, and support TLS 1.3"
  homepage "https://nginx.org/"
  # Use "mainline" releases only (odd minor version number), not "stable"
  # See https://www.nginx.com/blog/nginx-1-12-1-13-released/ for why
  url "https://nginx.org/download/nginx-1.15.8.tar.gz"
  sha256 "a8bdafbca87eb99813ae4fcac1ad0875bf725ce19eb265d28268c309b2b40787"
  head "https://hg.nginx.org/nginx/", :using => :hg

  depends_on "hguandl/custom/boringssl"
  depends_on "jemalloc"
  depends_on "pcre"

  # SPDY, HPACK Patches
  patch do
    url "https://github.com/hguandl/nginx-patch/raw/1.15.8/nginx.patch"
    sha256 "a59a8d2f8dd0bf8baa3750397527f8c8945422f88a8b3215f651f73f99ddbd02"
  end

  # Strict-SNI Patch
  patch do
    url "https://github.com/hguandl/nginx-patch/raw/1.15.8/nginx_strict-sni.patch"
    sha256 "8e91be1a70161ec54ef8b3c8cb6e7701eb58f72c61d6de8810903c1bcdf8641d"
  end

  # OCSP Patch
  patch do
    url "https://github.com/hguandl/nginx-patch/raw/1.15.8/Enable_BoringSSL_OCSP.patch"
    sha256 "dd486fea23fabfe4755cbfc86bf62f20bedefa21c791d1f93630abf1d1134754"
  end

  def install
    # Changes default port to 8080
    # Enable brotli
    inreplace "conf/nginx.conf" do |s|
      s.gsub! "listen       80;", "listen       8080;"
      s.gsub! "    #}\n\n}", "    #}\n    include servers/*;\n}"
      s.gsub! "#gzip  on;", "#gzip  on;\n" << brotli_conf
    end

    jemalloc = Formula["jemalloc"]
    openssl = Formula["hguandl/custom/boringssl"]
    pcre = Formula["pcre"]

    cc_opt = "-O3 -DTCP_FASTOPEN=23 "
    cc_opt << "-I#{pcre.opt_include} -I#{openssl.opt_include} -I#{jemalloc.opt_include}"
    ld_opt = "-L#{pcre.opt_lib} -L#{openssl.opt_lib} -L#{jemalloc.opt_lib} -ljemalloc"

    args = %W[
      --prefix=#{prefix}
      --sbin-path=#{bin}/nginx
      --with-cc-opt=#{cc_opt}
      --with-ld-opt=#{ld_opt}
      --conf-path=#{etc}/nginx/nginx.conf
      --pid-path=#{var}/run/nginx.pid
      --lock-path=#{var}/run/nginx.lock
      --http-client-body-temp-path=#{var}/run/nginx/client_body_temp
      --http-proxy-temp-path=#{var}/run/nginx/proxy_temp
      --http-fastcgi-temp-path=#{var}/run/nginx/fastcgi_temp
      --http-uwsgi-temp-path=#{var}/run/nginx/uwsgi_temp
      --http-scgi-temp-path=#{var}/run/nginx/scgi_temp
      --http-log-path=#{var}/log/nginx/access.log
      --error-log-path=#{var}/log/nginx/error.log
      --with-debug
      --with-http_addition_module
      --with-http_auth_request_module
      --with-http_dav_module
      --with-http_degradation_module
      --with-http_flv_module
      --with-http_gunzip_module
      --with-http_gzip_static_module
      --with-http_mp4_module
      --with-http_random_index_module
      --with-http_realip_module
      --with-http_secure_link_module
      --with-http_slice_module
      --with-http_ssl_module
      --with-http_stub_status_module
      --with-http_sub_module
      --with-http_v2_module
      --with-ipv6
      --with-mail
      --with-mail_ssl_module
      --with-pcre
      --with-pcre-jit
      --with-stream
      --with-stream_realip_module
      --with-stream_ssl_module
      --with-stream_ssl_preread_module
      --with-http_v2_hpack_enc
      --with-http_spdy_module
      --add-module=ngx_brotli
    ]

    # Add Brotli module
    ngx_brotli = "https://github.com/google/ngx_brotli.git"
    system "git", "clone", "--depth=1", "--recurse-submodules", ngx_brotli.to_s

    if build.head?
      system "./auto/configure", *args
    else
      system "./configure", *args
    end

    system "make", "install"
    if build.head?
      man8.install "docs/man/nginx.8"
    else
      man8.install "man/nginx.8"
    end
  end

  def post_install
    (etc/"nginx/servers").mkpath
    (var/"run/nginx").mkpath

    # nginx's docroot is #{prefix}/html, this isn't useful, so we symlink it
    # to #{HOMEBREW_PREFIX}/var/www. The reason we symlink instead of patching
    # is so the user can redirect it easily to something else if they choose.
    html = prefix/"html"
    dst = var/"www"

    if dst.exist?
      html.rmtree
      dst.mkpath
    else
      dst.dirname.mkpath
      html.rename(dst)
    end

    prefix.install_symlink dst => "html"

    # for most of this formula's life the binary has been placed in sbin
    # and Homebrew used to suggest the user copy the plist for nginx to their
    # ~/Library/LaunchAgents directory. So we need to have a symlink there
    # for such cases
    if rack.subdirs.any? { |d| d.join("sbin").directory? }
      sbin.install_symlink bin/"nginx"
    end
  end

  def caveats
    <<~EOS
      Docroot is: #{var}/www

      The default port has been set in #{etc}/nginx/nginx.conf to 8080 so that
      nginx can run without sudo.

      nginx will load all files in #{etc}/nginx/servers/.
    EOS
  end

  plist_options :manual => "nginx"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <false/>
        <key>ProgramArguments</key>
        <array>
            <string>#{opt_bin}/nginx</string>
            <string>-g</string>
            <string>daemon off;</string>
        </array>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
      </dict>
    </plist>
  EOS
  end

  def brotli_conf; <<~EOS
        brotli on;
        brotli_static on;
        brotli_comp_level 6;
        brotli_buffers 32 8k;
        brotli_types application/javascript \
    application/atom+xml \
    application/rss+xml \
    application/json \
    application/xhtml+xml \
    font/woff \
    font/woff2 \
    image/gif \
    image/jpeg \
    image/png \
    image/svg+xml \
    image/webp \
    image/x-icon \
    image/x-ms-bmp \
    text/css \
    text/x-component \
    text/xml \
    text/plain;
  EOS
  end

  test do
    (testpath/"nginx.conf").write <<~EOS
      worker_processes 4;
      error_log #{testpath}/error.log;
      pid #{testpath}/nginx.pid;

      events {
        worker_connections 1024;
      }

      http {
        client_body_temp_path #{testpath}/client_body_temp;
        fastcgi_temp_path #{testpath}/fastcgi_temp;
        proxy_temp_path #{testpath}/proxy_temp;
        scgi_temp_path #{testpath}/scgi_temp;
        uwsgi_temp_path #{testpath}/uwsgi_temp;

        server {
          listen 8080;
          root #{testpath};
          access_log #{testpath}/access.log;
          error_log #{testpath}/error.log;
        }
      }
    EOS
    system bin/"nginx", "-t", "-c", testpath/"nginx.conf"
  end
end
