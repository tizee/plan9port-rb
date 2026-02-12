# coding: utf-8
class Plan9port < Formula
  desc "Plan 9 from User Space (aka plan9port) is a port of many Plan 9 programs from their native Plan 9 environment to Unix-like operating systems. "
  homepage "https://9fans.github.io/plan9port/"
  head "https://github.com/9fans/plan9port.git", branch: "master"
  url "https://github.com/9fans/plan9port/archive/cb7001c8d27f22f7229be302f53012bb1db52418.zip"
  version "2026-02-12-cb7001c8"

  def install
    # 1. build with plan9port script
    # 2. symlink 9 to /usr/local/bin/9
    ENV["PLAN9_TARGET"] = libexec

    system "./INSTALL"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/9"
    prefix.install Dir[libexec/"*.app"]
  end

  def caveats; <<~EOS
    In order not to collide with macOS system binaries, the Plan 9 binaries have
    been installed to #{opt_libexec}/bin.
    To run the Plan 9 version of a command simply call it through the command
    "9", which has been installed into the Homebrew prefix bin.  For example,
    to run Plan 9's ls run:
        # 9 ls

    You should set environment variables $PLAN9 for plan9port:
      $PLAN9=#{opt_libexec}

  EOS
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <u.h>
      #include <libc.h>
      #include <stdio.h>
      int main(void) {
        return printf("Hello World\\n");
      }
    EOS
    system bin/"9", "9c", "test.c"
    system bin/"9", "9l", "-o", "test", "test.o"
    assert_equal "Hello World\n", shell_output("./test", 1)
  end
end