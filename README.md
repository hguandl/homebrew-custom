# Homebrew Custom

hguandl's custom packges, with some personal options. Use at your own risk.

## Tap this formula repo

``` bash
brew tap hguandl/custom
```

## Install formulae from this repo

``` bash
brew install hguandl/custom/<formula>
```

## Packages

### - boringssl

A fork of OpenSSL that is designed to meet Google's needs. Built from [Google BoringSSL](https://boringssl.googlesource.com/boringssl/).

### - libass

Use Fontconfig instead of CoreText to avoid issues on fontname matching. See <https://zrstea.com/261/>.

### - nginx

Patched to support SDPY, HPACK and strict-SNI. See [kn007/patch](https://github.com/kn007/patch). Use BoringSSL as SSL library. Add custom optimizations including [brotli](https://github.com/google/brotli) and jemalloc.

### - ffmpeg

Prune some unused dependencies. Use [libass built with Fontconfig](#--libass).

## Troubleshooting

### File name to long @ rb_sysopen

It is a bug for older brew, which has been fixed in [277e8d4](https://github.com/Homebrew/brew/commit/277e8d43be89c1e8fa6699fd5e8bc3616cabd103). If you are using a version before [2019-01-31T19:16Z](https://dencode.com/date?v=2019-01-31T19%3A16Z), just execute `brew update` to upgrade it.