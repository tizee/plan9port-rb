# coding: utf-8
class Plan9port < Formula
  desc "Plan 9 from User Space (aka plan9port) is a port of many Plan 9 programs from their native Plan 9 environment to Unix-like operating systems. "
  homepage "https://9fans.github.io/plan9port/"
  head "https://github.com/9fans/plan9port.git", branch: "master"
  url "https://github.com/9fans/plan9port/archive/bab7b73b85f865d20a5c4f2d78ac9e81b3d39109.zip",
  version: "2022-04-28-bab7b73b",
  keg_only "Plan9Port includes Unix system programs may override their OS X equivalents."

  def install
    # 1. build with plan9port script
    # 2. symlink 9 to /usr/local/bin/9
    ENV["PLAN9_TARGET"] = libexec

    system "./INSTALL"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/9"
    prefix.install Dir[libexec/"mac/*.app"]
  end

  def caveats; <<~EOS
    In order not to collide with macOS system binaries, the Plan 9 binaries have
    been installed to #{opt_libexec}/bin.
    To run the Plan 9 version of a command simply call it through the command
    "9", which has been installed into the Homebrew prefix bin.  For example,
    to run Plan 9's ls run:
        # 9 ls
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