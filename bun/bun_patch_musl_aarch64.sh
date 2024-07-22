#!/bin/bash

exe_deps=("unzip" "curl" "tar" "mktemp" "patchelf")
libs=("libdl.so.2" "libm.so.6" "libpthread.so.0" "libc.so.6")

quit=false

for exe in "${exe_deps[@]}"; do
    if ! command -v $exe > /dev/null; then
        echo "ERROR: '$exe' not found, install it first"
        quit=true
    fi
done

if $quit; then
    exit 1
fi

if [ $# -eq 0 ]; then
    printf "bun-musl: Wrapper for bun.js runtime on musl systems

  install\tInstalls bun, prepares libraries and patches bun
  upgrade\tUpgrades installed bun, works as override for bun upgrade
  patch\t\tPatch allready installed bun

Note:
  bun will run through a wrapper, both the wrapper and this script share the same upgrade function
"
    exit 1
fi

tmpdir=$(mktemp -d)

prepatch() {
    echo "Downloading void linux glibc rootfs"
    cd $tmpdir
    curl https://repo-default.voidlinux.org/live/current/void-aarch64-ROOTFS-20230628.tar.xz --output void.tar.xz
    echo "Downloaded void linux glibc rootfs"

    echo "Extracting libraries from the archive"
    tar -xf void.tar.xz ./usr/lib/libdl.so.2 ./usr/lib/libm.so.6 ./usr/lib/libpthread.so.0 ./usr/lib/libc.so.6 ./usr/lib/ld-linux-aarch64.so.1
    mkdir -p $HOME/.bun/libs/
    cp ./usr/lib/* $HOME/.bun/libs/
    cp ./usr/lib/ld-linux-aarch64.so.1 $HOME/.bun/libs/
    echo "Extracted ${libs[*]}"
}

patchbun() {
    echo "Patching bun"
    for lib in "${libs[@]}"; do
        patchelf --replace-needed "$lib" "$HOME/.bun/libs/$lib" $HOME/.bun/bin/bun 
    done
    patchelf --set-interpreter $HOME/.bun/libs/ld-linux-aarch64.so.1 $HOME/.bun/bin/bun
    echo "Done patching"
}

cleanup() {
    echo "Removing garbage"
    cd $HOME

    rm -r $tmpdir
}

if [ $1 = "install" ]; then
    echo "Installing bun like you would"
    curl -fsSL https://bun.sh/install | bash 2> /dev/null > /dev/null
    echo "Bun installed"

    prepatch

    patchbun

    cleanup

    echo "Bun installed!"
    exit 0
fi

if [ $1 = "patch" ]; then
    echo "Patching bun"

    prepatch

    patchbun

    cleanup
    exit 0
fi

if [ $1 = "upgrade" ]; then
    echo "Still unavailable, but very soon"
fi