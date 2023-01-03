# Pre-requisities

### Clone the repo

```sh
git clone https://github.com/YOU54F/hello_ffi.git
cd hello_ffi
```

### Linux

- Assumed Ubuntu 20.04 / 22.04

```sh
apt --version

```

```sh
snap --version 
```

### MacOS

- Assumed Homewbrew is installed

```sh
brew --version
```

### Windows

```sh
choco --version
```

### All Platforms

- `make`

```sh
make --version
```

- `jq`

```sh
jq --version
```

```sh
sudo apt-get install --yes jq
```

```sh
choco install --yes jq
```

- `grep`

```sh
grep --version
```

```sh
choco install --yes grep
```

- `jenv`

```sh
jenv --version
```

## Pact FFI

```sh
make get_pact_ffi
```

```sh
deno run -A --unstable https://deno.land/x/pact/src/downloadFfi.ts --run
ls $HOME\.pact\ffi\v0.3.15 .
```

## Run - Hello FFI

```sh
make hello_ffi | grep -e INFO
```

```sh
make -i hello_ffi
```

```sh
make -i hello_ffi | grep -e INFO
```

## Ada

```sh
sudo apt-get --yes install gnat-10
```

```sh
choco install --yes gnat-gpl
```

```sh
gnat --version
gnatmake --version
```

```sh
make ada_hello_ffi
```

```sh
cd ada && gnatmake helloffi.adb -largs -lpact_ffi -L../.
```

```sh
cd ada; gnatmake helloffi.adb -largs -lpact_ffi -L../.
```

```sh
./ada/helloffi
```

## Bun

```sh
curl -fsSL https://bun.sh/install | bash
source ~/.zshrc
```

```sh
bun --version
```

```sh
make bun_hello_ffi
```

## C

```sh
sudo apt install --yes gcc
```

```sh
choco install --yes mingw
```

```sh
gcc --version
```

```sh
make c_hello_ffi
```

```sh
gcc c/hello_ffi.c -L./ -lpact_ffi -o c/hello_ffi
```

```sh
$$env:LD_LIBRARY_PATH=$env:PWD.Path; ./c/hello_ffi
```

```sh
./c/hello_ffi
```

## C#

```sh
sudo apt-get install --yes mono-mcs
```

```sh
make csharp_hello_ffi
```

```sh
cd csharp; & 'C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\Roslyn\csc.exe' helloPact.cs; 
```

```sh
$$env:LD_LIBRARY_PATH=$env:PWD.Path; csharp/helloPact
```

```sh
csharp/helloPact
```

## Dart

```sh
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
sudo apt-get update
sudo apt-get install dart
```

```sh
choco install --yes dart-sdk
```

```sh
dart --version
```

```sh
make dart_hello_ffi
```

## Deno

```sh
curl -fsSL https://deno.land/x/install/install.sh | sh`
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"`
```

```sh
choco install --yes deno
```

```sh
deno --version
```

```sh
make deno_hello_ffi
```

### Powershell

drop the first `$` if copy/pasting into a shell

```sh
$$env:LD_LIBRARY_PATH=$env:PWD.Path; deno run --allow-ffi --unstable deno/hello_ffi.ts
```

```sh
deno run --allow-ffi --unstable deno/hello_ffi.ts
```

## GoLang

```sh
sudo apt-get install --yes golang
```

```sh
choco install --yes golang 
```

```sh
choco install --yes mingw
```

```sh
go version
```

```sh
make go_hello_ffi
```

### Windows

```sh
cd go; go build
```

```sh
go/hello_ffi
```

There is a failure with the latest go 1.19.4 on windows, so you can use the following instructions to install an rc1
see https://github.com/golang/go/issues/51007

```sh
go install golang.org/dl/go1.20rc1@latest
```

```sh
go1.20rc1 download
```

```sh
cd go; go1.20rc1 build
```

## Haskell

```sh
sudo apt-get install --yes ghc
```

```sh
choco install --yes ghc
```

```sh
choco install --yes llvm
```

```sh
ghc --version
```

```sh
make haskell_hello_ffi
```

```sh
ghc haskell/hello_ffi.hs pact_ffi.dll -o haskell/hello_ffi_haskell
```

```sh
$$env:LD_LIBRARY_PATH=$env:PWD.Path; ./haskell/hello_ffi_haskell
```

```sh
./haskell/hello_ffi_haskell
```

## Java

```sh
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz
sudo mkdir -p /usr/lib/jvm
cd /usr/lib/jvm
sudo tar -xvzf ~/hello_ffi/jdk-19_linux-x64_bin.tar.gz
jenv add "/usr/lib/jvm/jdk-19.0.1/bin"
jenv global 19
```

```sh
choco install --yes temurin19
```

```sh
java --version
```

```sh
make java_jna_hello_ffi
```

linux

```sh
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_linux-x64_bin.tar.gz
tar -xzf openjdk-19-jextract+2-3_linux-x64_bin.tar.gz -C java/panama
```

windows

```sh
wget -Headers @{'Cookie'='oraclelicense=accept-securebackup-cookie'} https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_windows-x64_bin.tar.gz -Outfile openjdk-19-jextract+2-3_windows-x64_bin.tar.gz
tar -xzf openjdk-19-jextract+2-3_windows-x64_bin.tar.gz -C java/panama
```

mac

wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_macos-x64_bin.tar.gz
tar -xzf openjdk-19-jextract+2-3_macos-x64_bin.tar.gz -C java/panama

```sh
make java_panama_ffi_gen
make java_panama_hello_ffi
```

## NodeJS

```sh
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.zshrc
```

```sh
source ~/.zshrc
nvm install 16
```

```sh
node -v
npm -v
```

```sh
make js_ffi_napi_hello_ffi
```

Below is for powershell, drop the first $ if copy/pasting into your own shell

```sh
$$env:LD_LIBRARY_PATH = $env:PWD.Path; node js/node-ffi-napi/index.js
```

```sh
node js/node-ffi-napi/index.js
```

```sh
make js_ffi_packager_hello_ffi
```

```sh
$$env:LD_LIBRARY_PATH = $env:PWD.Path; node js/node-ffi-packager/index.js
```

```sh
node js/node-ffi-packager/index.js
```

## Julia

```sh
sudo snap install julia --classic
```

```sh
choco install --yes julia
```

```sh
julia --version
```

```sh
make julia_hello_ffi
```

```sh
julia julia/hello_ffi.jl
```

```sh
$$env:LD_LIBRARY_PATH=$env:PWD.Path; julia julia/hello_ffi.jl
```

## Kotlin

```sh
curl -s https://get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdkman install kotlin
sdkman install gradle
```

```sh
kotlin -version
gradle -version
```

```sh
make kotlin_hello_ffi
```

## Lua

```sh
sudo apt-get install --yes luajit
```

```sh
luajit -v
```

```sh
make lua_hello_ffi
```

## Nim

```sh
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
export PATH=$HOME/.nimble/bin:$PATH
```

```sh
choco install --yes nim
```

```sh
nim --version
```

```sh
make nim_hello_ffi
```

```sh
nim c -r --hints:off nim/hello_ffi.nim
```

## OCaml

```sh
sudo apt-get install --yes ocaml opam
```

```sh
ocaml --version
```

```sh
opam init --auto
```

```sh
opam install ctypes ctypes-foreign utop
```

```sh
eval $(opam env)
```

```sh
make ocaml_hello_ffi
```

## Perl

```sh
perl -v
```

```sh
perl -e 'use FFI::Platypus;;'
```

## Pre-requisites

```sh
cpanm FFI::Platypus
```

```sh
cpanm Capture::Tiny ExtUtils::ParseXS ExtUtils::MakeMaker IPC::Cmd
```

### Windows

Strawberry perl comes with FFI:Platypus pre-installed

```sh
choco install --yes strawberryperl
```

### Hello Ffi - Perl

```sh
make perl_hello_ffi
```

```sh
perl perl/hello_ffi.pl
```

## PHP

### Ubuntu

```sh
sudo apt-get install --yes php
```

```sh
choco install --yes php
```

```sh
scoop bucket add php
scoop install php/php8.1
```

```sh
php -m
```

```sh
code $HOME\scoop\apps\php8.1\8.1.13\conf.d\extensions.ini
```

```sh
extension_dir = ext
extension = php_ffi.dll
```

```sh
php -m | grep -e FFI
```

```sh
make php_hello_ffi
```

## Python

```sh
python3 --version
```

### Ubuntu

```sh
sudo apt-get install --yes pip
```

### Windows

```sh
choco install --yes pip
```

```sh
make python_hello_ffi_ctypes
```

```sh
make python_install_deps
```

```sh
make python_hello_ffi_cffi
```

## Racket

```sh
sudo apt-get install --yes racket
```

```sh
choco install --yes racket
```

```sh
(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
```

```sh
$$env:Path -split ';'
```

```sh
$$Env:Path += [IO.Path]::PathSeparator + 'C:\Program Files\Racket\'
racket --version
```

```sh
racket --version
```

```sh
make racket_hello_ffi
```

## Raku (Perl 6)

```sh
sudo apt-get install --yes rakudo
```

```sh
choco install --yes rakudostar
```

```sh
rakudo --version
```

```sh
cd /usr/lib/perl6/site
sudo mkdir -p short; sudo chmod -R 777 short
cd /usr/lib/perl6/vendor
sudo mkdir -p short; sudo chmod -R 777 short
```

```sh
make raku_hello_ffi
```

```sh
$env:LD_LIBRARY_PATH = $env:PWD.Path; rakudo raku/hello_ffi.raku
```

## Ruby

### Ubuntu 20.04

```sh
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles
source ~/.rvm/scripts/rvm
rvm install 2.7.6
ruby --version
```

### Ubuntu 22.04

```sh
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
sudo usermod -a -G rvm $USER
source /etc/profile.d/rvm.sh
rvm pkg install openssl
rvm install 2.7.6 --with-openssl-dir=/usr/share/rvm/usr
gem install bundler
```

```sh
source /etc/profile.d/rvm.sh
rvm list
rvm --default use ruby-2.7.6
ruby --version
```

### Windows

```sh
scoop install ruby msys2
```

```sh
ridk install
```

```sh
ruby --version
```

```sh
make ruby_hello_ffi_fiddle
```

```sh
make ruby_hello_ffi_ffi_deps
```

```sh
make ruby_hello_ffi_ffi
```

## Scala-Native

```sh
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo -H gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
sudo chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
sudo apt update
sudo apt install --yes sbt clang
sbt --version
```

```sh
sbt --version
```

```sh
make scala_native_deps
make scala_native_hello_ffi
```

## Swift

### Ubuntu 20.04

```sh
wget https://swift.org/builds/swift-5.7.2-release/ubuntu2004/swift-5.7.2-RELEASE/swift-5.7.2-RELEASE-ubuntu20.04.tar.gz
tar xzf swift-5.7.2-RELEASE-ubuntu20.04.tar.gz
mv swift-5.7.2-RELEASE-ubuntu20.04 /usr/share/swift
export PATH=/usr/share/swift/usr/bin:$PATH
source ~/.bashrc
swift -v
swiftc -v
make swift_hello_ffi
```

### Ubuntu 22.04

```sh
# wget https://swift.org/builds/swift-5.7.2-release/ubuntu2204/swift-5.7.2-RELEASE/swift-5.7.2-RELEASE-ubuntu22.04.tar.gz
# tar xzf swift-5.7.2-RELEASE-ubuntu22.04.tar.gz
# sudo mv swift-5.7.2-RELEASE-ubuntu22.04 /usr/share/swift
export PATH=/usr/share/swift/usr/bin:$PATH
source ~/.zshrc
swift -v
swiftc -v
```

```sh
swift -v
swiftc -v
```

```sh
make swift_hello_ffi
```

## Visual Basic

```sh
sudo apt-get install --yes mono-vbnc
```

```sh
choco install --yes mono
```

```sh
choco install --yes dotnet
```

```sh
make visual_basic_hello_ffi
```

## Zig

```sh
sudo snap install zig --classic --beta
```

```sh
choco install --yes zig
```

```sh
zig version
```

```sh
make zig_hello_ffi
```
