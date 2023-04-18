## Tutorial Prerequisites

- Nothing! Just you and a bit of time

1. `git clone https://github.com/YOU54F/hello_ffi.git`{{exec}}
2. `cd hello_ffi`{{exec}}
3. `git checkout killercoda`{{exec}}
4. `make get_pact_ffi`{{exec}}

## Ada

<https://www.adacore.com/download>

1. `apt-cache search gnat-10`{{exec}}
1. `apt --yes install gnat-10`{{exec}}
1. `gnat --version`{{exec}}
2. `make ada_hello_ffi`{{exec}}

## Bun

<https://bun.sh/>

1. `curl -fsSL https://bun.sh/install | bash`{{exec}}
2. `source /root/.bashrc`{{exec}}
3. `bun --version`{{exec}}
4. `make bun_hello_ffi`{{exec}}

## C

1. `gcc --version`{{exec}}
2. `make c_hello_ffi`{{exec}}

## C

<https://www.mono-project.com/docs/about-mono/languages/csharp/>
<https://www.mono-project.com/docs/getting-started/install/>

1. `apt install --yes mono-mcs`{{exec}}
2. `make csharp_hello_ffi`{{exec}}

## Dart

<https://dart.dev/get-dart>

1. `wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg`{{exec}}
2. `echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list`{{exec}}
3. `apt update`{{exec}}
4. `apt install dart`{{exec}}
2. `dart --version`{{exec}}
3. `make dart_hello_ffi`{{exec}}

## Deno

<https://deno.land/manual@v1.29.1/getting_started/installation>

1. `curl -fsSL https://deno.land/x/install/install.sh | sh`{{exec}}
2. `export DENO_INSTALL="/root/.deno"`{{exec}}
3. `export PATH="$DENO_INSTALL/bin:$PATH"`{{exec}}
4. `source /root/.bashrc`{{exec}}
5. `deno --version`{{exec}}
6. `make deno_hello_ffi`{{exec}}

## GoLang

<https://go.dev/doc/install>

1. `go version`{{exec}}
2. `make go_hello_ffi`{{exec}}

## Haskell

<https://www.haskell.org/downloads/>

1. `apt install --yes ghc`{{exec}}
2. `ghc --version`{{exec}}
3. `make haskell_hello_ffi`{{exec}}

## Java

1. `wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz`{{exec}}
2. `mkdir /usr/lib/jvm`{{exec}}
3. `cd /usr/lib/jvm`{{exec}}
4. `tar -xvzf ~/hello_ffi/jdk-19_linux-x64_bin.tar.gz`{{exec}}
5. `export JAVA_HOME="/usr/lib/jvm/jdk-19.0.1"`{{exec}}
6. `export PATH="/usr/lib/jvm/jdk-19.0.1/bin:$PATH"`{{exec}}
7. `cd ~/hello_ffi`{{exec}}

### Java Native Access

1. `make java_jna_hello_ffi`{{exec}}

### Java Panama

<https://openjdk.org/projects/panama/>
<https://jdk.java.net/jextract/>

1. `wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_linux-x64_bin.tar.gz`{{exec}}
2. `tar -xzf openjdk-19-jextract+2-3_linux-x64_bin.tar.gz -C java/panama`{{exec}}
3. `make java_panama_ffi_gen`{{exec}}
4. `make java_panama_hello_ffi`{{exec}}

## JavaScript

1. `wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash`{{exec}}
2. `source ~/.bashrc`{{exec}}
3. `nvm install 16`{{exec}}

### node-addon-api

### node-ffi-napi

3. `make js_ffi_napi_hello_ffi`{{exec}}

### node-ffi-packager

<https://github.com/node-ffi-packager/node-ffi-generate>

<!-- 1. `apt install clang`
1. `apt install llvm`
2. `ln -s /usr/lib/llvm-10/lib/libclang.so.1 /usr/lib/llvm-10/lib/libclang.so`
3. `apt install -y libclang-dev`
4. `LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu` -->
5. `make js_ffi_packager_hello_ffi`{{exec}}

## Julia

<https://julialang.org/downloads/>

1. `apt install --yes julia`{{exec}}
2. `julia --version`{{exec}}
3. `make julia_hello_ffi`{{exec}}

## Kotlin

https://kotlinlang.org/docs/native-c-interop.htm

1. `snap install --classic kotlin`{{exec}}
2. `sdk install gradle 7.6`{{exec}}
3. `make kotlin_hello_ffi`{{exec}}

## Lua

<https://luajit.org/install.html>

1. `apt install --yes luajit`{{exec}}
2. `luajit -v`{{exec}}
3. `make lua_hello_ffi`{{exec}}

## Nim

<https://nim-lang.org/install.html>

1. `apt install --yes nim`{{exec}}
2. `nim --version`{{exec}}
3. `make nim_hello_ffi`{{exec}}

## OCaml

1. `apt install --yes ocaml opam`{{exec}}
2. `ocaml --version`{{exec}}
3. `opam init --auto-setup`{{exec}}
4. `opam install --yes ctypes ctypes-foreign utop`{{exec}}
5. `eval $(opam env)`{{exec}}
6. `make ocaml_hello_ffi`{{exec}}

## Perl

https://metacpan.org/pod/FFI::Platypus

1. `cpan FFI::Platypus<<<yes`{{exec}} or `make perl_install_deps`{{exec}}
   1. press `yes` at the install prompt
2. `make perl_hello_ffi`{{exec}}

## PHP

https://www.php.net/manual/en/book.ffi.php

1. `php -v`{{exec}}
2. `make php_hello_ffi`{{exec}}

## Python

1. `python --version`{{exec}}

### CTypes

https://docs.python.org/3/library/ctypes.html

1. `make python_hello_ffi_ctypes`{{exec}}

### CFfi

https://cffi.readthedocs.io/en/latest/

1. `make python_install_deps`{{exec}}
2. `make python_hello_ffi_cffi`{{exec}}

## Racket

1. `apt install --yes racket`{{exec}}
2. `racket --version`{{exec}}
3. `make racket_hello_ffi`{{exec}}

## Raku

https://course.raku.org/essentials/how-to-install-rakudo/

1. `apt install --yes rakudo`{{exec}}
2. `rakudo --version`{{exec}}
3. `make raku_hello_ffi`{{exec}}

## Ruby

1. `curl -sSL https://rvm.io/mpapis.asc | gpg --import -`{{exec}}
2. `curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -`{{exec}}
3. `curl -sSL https://get.rvm.io | bash -s stable`{{exec}}
4. `source /etc/profile.d/rvm.sh`{{exec}}
5. `rvm install 2.7.6`{{exec}}
6. `ruby --version`{{exec}}

### Fiddle

1. `make ruby_hello_ffi_fiddle`{{exec}}

### CFfi

1. `make ruby_hello_ffi_ffi_deps`{{exec}}
2. `make ruby_hello_ffi_ffi`{{exec}}

## Scala-Native

https://www.scala-sbt.org/release/docs/Setup.html

1. `echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list`{{exec}}
1. `echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list`{{exec}}
1. `curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo -H gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import`{{exec}}
1. `chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg`{{exec}}
1. `apt update`{{exec}}
1. `apt install --yes sbt clang`{{exec}}
1. `sbt --version`{{exec}}
1. `make scala_native_deps`{{exec}}
1. `make scala_native_hello_ffi`{{exec}}

## Swift

https://www.swift.org/download/

1. `wget https://swift.org/builds/swift-5.7.2-release/ubuntu2004/swift-5.7.2-RELEASE/swift-5.7.2-RELEASE-ubuntu20.04.tar.gz`{{exec}}
2. `tar xzf swift-5.7.2-RELEASE-ubuntu20.04.tar.gz`{{exec}}
3. `mv swift-5.7.2-RELEASE-ubuntu20.04 /usr/share/swift`{{exec}}
4. `export PATH=/usr/share/swift/usr/bin:$PATH`{{exec}}
5. `source ~/.bashrc`{{exec}}
6. `swift -v`{{exec}}
7. `swiftc -v`{{exec}}
8. `make swift_hello_ffi`{{exec}}

## Visual Basic

https://learn.microsoft.com/en-us/dotnet/visual-basic/reference/command-line-compiler/

_Note:_ the VB compiler is called `vbnc` on ubuntu, but `vbc` on windows/macosx

https://manpages.ubuntu.com/manpages/trusty/man1/vbnc.1.html

1. `apt install --yes mono-vbnc`{{exec}}
2. `vbnc --version`{{exec}}
3. `make visual_basic_hello_ffi`{{exec}}
   
## Zig

https://github.com/ziglang/zig/wiki/Install-Zig-from-a-Package-Manager

1. `snap install zig --classic --beta`{{exec}}
2. `zig version`{{exec}}
3. `make zig_hello_ffi`{{exec}}
<!-- ## Install Deno

1. `curl -fsSL https://deno.land/x/install/install.sh | sh`{{exec}}
2. `echo 'export DENO_INSTALL="/root/.deno"' >> ~/.bashrc`{{exec}}
3. `echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc`{{exec}}
4. `source ~/.bashrc`{{exec}}

## Get the Pact FFI

5. `deno run -A --unstable https://deno.land/x/pact/src/downloadFfi.ts --run`{{exec}}
6. `touch helloPactDeno.ts`{{exec}}

```ts
import { DenoPact, Pact } from "https://deno.land/x/pact/src/mod.ts";
const denoPact = new DenoPact();
console.log(denoPact.getPactFfiVersion());
```{{copy}}

7. `deno run -A --unstable helloPactDeno.ts`{{exec}}

## Run the Examples

2. `git clone https://github.com/YOU54F/deno-pact`{{exec}}
3. `cd deno-pact`{{exec}}
4. `./run get_pact_ffi`{{exec}}
7. `./run get_pact_plugin_cli`{{exec}}
8. `PATH_TO_CLI=/root/bin/ ./run get_protobuf_plugin`{{exec}}

## gRPC AreaCalculator

8. `./run test_grpc_area_client`{{exec}}
9. `./run test_grpc_area_provider`{{exec}}
10. `./run start_area_calculator_provider`{{exec}}
11. `./run run_area_calculator`{{exec}}

## gRPC Greeter

12. `./run run_grpc_greeter`{{exec}}
13. `./run test_grpc_greeter_client`{{exec}}

## HTTP Service

14. `./run run_product_api_provider`{{exec}}
15. `./run test_product_api_provider`{{exec}}

## HTTP Service

16. `./run run_smv_service`{{exec}}
17. `./run test_smv_service_provider_integration`{{exec}}
18. `./run test_smv_service_consumer_pact`{{exec}}
19. `./run test_smv_service_provider_pact`{{exec}}

##  Pact Verifier

20. `./run test_verifier_pact`{{exec}}

## Pact Broker

25. `curl pact.saf.dev -Lso - | bash -s -- broker deploy mybroker 8000`{{exec}}
    1. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents.
    2. You can check the Docker logs for the Pact Broker, `docker logs mybroker_pact_broker_1`{{exec}}
    3. Restart the container if there was any issues `docker restart mybroker_pact_broker_1`{{exec}}

5. `./run get_broker`{{exec}}
6. Open the [Pact Broker]({{TRAFFIC_HOST1_9292}}) -->


## Pre-requisities

### Clone the repo

```sh
git clone 
```
### Linux

- Assumed Ubuntu 20.04 / 22.04

```sh
apt --version
```{{exec}}

```sh
snap --version
```{{exec}}

### MacOS

- Assumed Homewbrew is installed

```sh
brew --version
```{{exec}}

### Windows

TODO

### All Platforms

- `make`

```sh
make --version
```{{exec}}

- `jq`

```sh
jq --version
```{{exec}}

```sh
sudo apt-get install --yes jq
```{{exec}}

- `grep`

```sh
grep --version
```{{exec}}

- `jenv`

```sh
jenv --version
```{{exec}}

## Pact FFI

```sh
make get_pact_ffi
```{{exec}}

## Run - Hello FFI

```sh
make hello_ffi | grep -e INFO
```{{exec}}

```sh
make -i hello_ffi
```{{exec}}

```sh
make -i hello_ffi | grep -e INFO

```{{exec}}

## Ada

```sh
sudo apt-get --yes install gnat-10
gnat --version
gnatmake --version
```{{exec}}

```sh
make ada_hello_ffi
```{{exec}}

## Bun

```sh
curl -fsSL https://bun.sh/install | bash
source ~/.zshrc
```{{exec}}

```sh
bun --version
make bun_hello_ffi
```{{exec}}

## C#

```sh
sudo apt install --yes gcc
```{{exec}}

```sh
make c_hello_ffi
```{{exec}}

```sh
sudo apt-get install --yes mono-mcs
```{{exec}}

```sh
make csharp_hello_ffi
```{{exec}}

## Dart

```sh
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
sudo apt-get update
sudo apt-get install dart
```{{exec}}

```sh
dart --version
```{{exec}}

```sh
make dart_hello_ffi
```{{exec}}

## Deno

```sh
curl -fsSL https://deno.land/x/install/install.sh | sh`
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"`
```{{exec}}

```sh
deno --version
```{{exec}}

```sh
make deno_hello_ffi
```{{exec}}

## GoLang

```sh
sudo apt-get install --yes golang
```{{exec}}

```sh
go version
```{{exec}}

```sh
make go_hello_ffi
```{{exec}}

## Haskell

```sh
sudo apt-get install --yes ghc
```{{exec}}

```sh
ghc --version
```{{exec}}

```sh
make haskell_hello_ffi
```{{exec}}

## Java

```sh
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz
sudo mkdir -p /usr/lib/jvm
cd /usr/lib/jvm
sudo tar -xvzf ~/hello_ffi/jdk-19_linux-x64_bin.tar.gz
jenv add "/usr/lib/jvm/jdk-19.0.1/bin"
jenv global 19
```{{exec}}

```sh
make java_jna_hello_ffi
```{{exec}}

```sh
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_linux-x64_bin.tar.gz
tar -xzf openjdk-19-jextract+2-3_linux-x64_bin.tar.gz -C java/panama
```{{exec}}

```sh
make java_panama_ffi_gen
make java_panama_hello_ffi
```{{exec}}

## NodeJS

```sh
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.zshrc
```{{exec}}

```sh
source ~/.zshrc
nvm install 16
```{{exec}}

```sh
make js_ffi_napi_hello_ffi
```{{exec}}

```sh
make js_ffi_packager_hello_ffi
```{{exec}}

## Julia

```sh
sudo snap install julia --classic
```{{exec}}

```sh
julia --version
```{{exec}}

```sh
make julia_hello_ffi
```{{exec}}

## Kotlin

```sh
curl -s https://get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdkman install kotlin
sdkman install gradle
```{{exec}}

```sh
kotlin -version
gradle -version
```{{exec}}

```sh
make kotlin_hello_ffi
```{{exec}}

## Lua

```sh
sudo apt-get install --yes luajit
```{{exec}}

```sh
luajit -v
```{{exec}}

```sh
make lua_hello_ffi
```{{exec}}

## Nim

```sh
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
export PATH=$HOME/.nimble/bin:$PATH
```{{exec}}

```sh
nim --version
```{{exec}}

```sh
make nim_hello_ffi
```{{exec}}

## OCaml

```sh
sudo apt-get install --yes ocaml opam
```{{exec}}

```sh
ocaml --version
```{{exec}}

```sh
opam init --auto
```{{exec}}

```sh
opam install ctypes ctypes-foreign utop
```{{exec}}

```sh
eval $(opam env)
```{{exec}}

```sh
make ocaml_hello_ffi
```{{exec}}

## Perl

```sh
perl -v
```{{exec}}

```sh
cpan FFI::Platypus
```{{exec}}

```sh
make perl_hello_ffi
```{{exec}}

## PHP

### Ubuntu

```sh
sudo apt-get install --yes php
```{{exec}}

## Python

```sh
python3 --version
```{{exec}}

### Ubuntu

```sh
sudo apt-get install --yes pip
```{{exec}}

```sh
make python_hello_ffi_ctypes
```{{exec}}

```sh
make python_install_deps
```{{exec}}

```sh
make python_hello_ffi_cffi
```{{exec}}

## Racket

```sh
sudo apt-get install --yes racket
```{{exec}}

```sh
racket --version
```{{exec}}

```sh
make racket_hello_ffi
```{{exec}}

## Raku (Perl 6)

```sh
sudo apt-get install --yes rakudo
```{{exec}}

```sh
rakudo --version
```{{exec}}

```sh
cd /usr/lib/perl6/site
sudo mkdir -p short; sudo chmod -R 777 short
cd /usr/lib/perl6/vendor
sudo mkdir -p short; sudo chmod -R 777 short
```{{exec}}

```sh
make raku_hello_ffi
```{{exec}}

## Ruby

### Ubuntu 20.04

```sh
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles
source ~/.rvm/scripts/rvm
rvm install 2.7.6
ruby --version
```{{exec}}

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
```{{exec}}

```sh
source /etc/profile.d/rvm.sh
rvm list
rvm --default use ruby-2.7.6
ruby --version
```{{exec}}

```sh
make ruby_hello_ffi_fiddle
```{{exec}}

```sh
make ruby_hello_ffi_ffi_deps
```{{exec}}

```sh
make ruby_hello_ffi_ffi
```{{exec}}

## Scala-Native

```sh
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo -H gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
sudo chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
sudo apt update
sudo apt install --yes sbt clang
sbt --version
```{{exec}}

```sh
sbt --version
```{{exec}}

```sh
make scala_native_deps
make scala_native_hello_ffi
```{{exec}}

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
```{{exec}}

### Ubuntu 22.04

```sh
# wget https://swift.org/builds/swift-5.7.2-release/ubuntu2204/swift-5.7.2-RELEASE/swift-5.7.2-RELEASE-ubuntu22.04.tar.gz
# tar xzf swift-5.7.2-RELEASE-ubuntu22.04.tar.gz
# sudo mv swift-5.7.2-RELEASE-ubuntu22.04 /usr/share/swift
export PATH=/usr/share/swift/usr/bin:$PATH
source ~/.zshrc
swift -v
swiftc -v
```{{exec}}

```sh
swift -v
swiftc -v
```{{exec}}

```sh
make swift_hello_ffi
```{{exec}}

## Visual Basic

```sh
sudo apt-get install --yes mono-vbnc
```{{exec}}

```sh
make visual_basic_hello_ffi
```{{exec}}

## Zig

```sh
sudo snap install zig --classic --beta
```{{exec}}

```sh
zig version
```{{exec}}

```sh
make zig_hello_ffi
```{{exec}}
