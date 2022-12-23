{ pkgs }: {
    deps = [
        # pkgs.zig # version out of date 0.9.1
        # pkgs.glibc # For zig
        pkgs.bison
        pkgs.wget
        pkgs.scala
        pkgs.rakudo
        pkgs.luajit
        pkgs.ihaskell
        pkgs.julia-stable-bin
        pkgs.dart_stable
        pkgs.protobuf
        pkgs.bun
        pkgs.ruby_3_0
        pkgs.rubyPackages_3_0.ffi
        pkgs.python39Packages.cffi
        pkgs.python39Packages.pip
        pkgs.python39Full
    		pkgs.gcc
    		pkgs.nim-unwrapped
    		pkgs.nimble-unwrapped
        pkgs.deno
        pkgs.php80Packages.composer
    ];
}