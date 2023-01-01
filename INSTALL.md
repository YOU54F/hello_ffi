# Pre-requisities

### Clone the repo

```sh
git clone https://github.com/YOU54F/hello_ffi.git
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

TODO

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

- `grep`

```sh
grep --version
```

- `jenv`

```sh
jenv --version
```

## Pact FFI

```sh
make get_pact_ffi
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
gnat --version
gnatmake --version
```

```sh
make ada_hello_ffi
```

## Bun

```sh
curl -fsSL https://bun.sh/install | bash
source ~/.zshrc
```

```sh
bun --version
make bun_hello_ffi
```

## C#

```sh
sudo apt install --yes gcc
```

```sh
make c_hello_ffi
```

```sh
sudo apt-get install --yes mono-mcs
```

```sh
make csharp_hello_ffi
```

## Dart

```sh
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
sudo apt-get update
sudo apt-get install dart
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
deno --version
```

```sh
make deno_hello_ffi
```

## GoLang

```sh
sudo apt-get install --yes golang
```

```sh
go version
```

```sh
make go_hello_ffi
```

## Haskell

```sh
sudo apt-get install --yes ghc
```

```sh
ghc --version
```

```sh
make haskell_hello_ffi
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
make java_jna_hello_ffi
```

```sh
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_linux-x64_bin.tar.gz
tar -xzf openjdk-19-jextract+2-3_linux-x64_bin.tar.gz -C java/panama
```

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
make js_ffi_napi_hello_ffi
```

```sh
make js_ffi_packager_hello_ffi
```

## Julia

```sh
sudo snap install julia --classic
```

```sh
julia --version
```

```sh
make julia_hello_ffi
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
nim --version
```

```sh
make nim_hello_ffi
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
cpan FFI::Platypus
```

```sh
make perl_hello_ffi
```

## PHP

### Ubuntu

```sh
sudo apt-get install --yes php
```

## Python

```sh
python3 --version
```

### Ubuntu

```sh
sudo apt-get install --yes pip
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
make visual_basic_hello_ffi
```

## Zig

```sh
sudo snap install zig --classic --beta
```

```sh
zig version
```

```sh
make zig_hello_ffi
```