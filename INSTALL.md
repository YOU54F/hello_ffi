# Hello FFI!

## Pre-requisities

### Clone the repo

```sh {"id":"01J3GK2B4RKTRQSBJMRP6PKSS0"}
git clone https://github.com/YOU54F/hello_ffi.git
cd hello_ffi

```

### Linux

- Assumed Ubuntu 20.04 / 22.04

```sh {"id":"01J3GK2B4RKTRQSBJMRS3ZSWWX"}
apt --version
```

```sh {"id":"01J3GK2B4RKTRQSBJMRSWZ06VX"}
snap --version 
```

### MacOS

- Assumed Homewbrew is installed

```sh {"id":"01J3GK2B4RKTRQSBJMRXF8ZDW0"}
brew --version
```

### Windows

```sh {"id":"01J3GK2B4RKTRQSBJMRXVKVR8D"}
choco --version

```

scoop --version

wsl users

```sh {"id":"01J3GK2B4RKTRQSBJMS1H6KS60"}
wget http://github.com/nullpo-head/WSL-Hello-sudo/releases/latest/download/release.tar.gz
tar xvf release.tar.gz
cd release
./install.sh
rm -rf release
```

### All Platforms

- `make`

```sh {"id":"01J3GK2B4RKTRQSBJMS37DGVEA"}
make --version

```

- `jq`

```sh {"id":"01J3GK2B4RKTRQSBJMS55Y3W2P"}
jq --version

```

```sh {"id":"01J3GK2B4RKTRQSBJMS85M9Z2Z"}
sudo apt-get install --yes jq

```

```sh {"id":"01J3GK2B4S15DPYW5R5PPM9B7X"}
choco install --yes jq

```

- `grep`

```sh {"id":"01J3GK2B4S15DPYW5R5S93EGXW"}
grep --version

```

```sh {"id":"01J3GK2B4S15DPYW5R5TKNTP84"}
choco install --yes grep

```

- `jenv`

```sh {"id":"01J3GK2B4S15DPYW5R5X3B2BM7"}
jenv --version

```

## Pact FFI

```sh {"id":"01J3GK2B4S15DPYW5R5YZ5SJFD"}
make get_pact_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5R61RK3419"}
deno run -A --unstable https://deno.land/x/pact/src/downloadFfi.ts --run
ls $HOME\.pact\ffi\v0.4.22 .

```

## Run - Hello FFI

```sh {"id":"01J3GK2B4S15DPYW5R64EZX7EK"}
make hello_ffi | grep -e INFO

```

```sh {"id":"01J3GK2B4S15DPYW5R66P9HTV5"}
make -i hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5R69QEY1RS"}
make -i hello_ffi | grep -e INFO

```

## Ada

```sh {"id":"01J3GK2B4S15DPYW5R6B630SYX"}
sudo apt-get update
```

```sh {"id":"01J3GK2B4S15DPYW5R6BND3B60"}
sudo apt-get --yes install gnat-10

```

```sh {"id":"01J3GK2B4S15DPYW5R6BP3DX3X"}
choco install --yes gnat-gpl

```

```sh {"id":"01J3GK2B4S15DPYW5R6C1S9ARQ"}
gnat --version
gnatmake --version

```

```sh {"id":"01J3GK2B4S15DPYW5R6ENSXNCE"}
make ada_hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5R6EVNVPJ4"}
cd ada && gnatmake helloffi.adb -largs -lpact_ffi -L../.

```

```sh {"id":"01J3GK2B4S15DPYW5R6J70R0B1"}
cd ada; gnatmake helloffi.adb -largs -lpact_ffi -L../.

```

```sh {"id":"01J3GK2B4S15DPYW5R6NA47XA8"}
./ada/helloffi

```

```sh {"id":"01J3GK2B4S15DPYW5R6PCBF5N9"}
LD_LIBRARY_PATH=$PWD ./ada/helloffi
```

## Bun

```sh {"id":"01J3GK2B4S15DPYW5R6QY2HS4Q"}
curl -fsSL https://bun.sh/install | bash
```

```sh {"id":"01J3GK2B4S15DPYW5R6TYX5NEM"}
source ~/.bashrc
```

```sh {"id":"01J3GK2B4S15DPYW5R6W6XA1NN"}
source ~/.zshrc
```

```sh {"id":"01J3GK2B4S15DPYW5R6XYT8EEV"}
bun --version

```

```sh {"id":"01J3GK2B4S15DPYW5R704KRCVA"}
make bun_hello_ffi
```

## C

```sh {"id":"01J3GK2B4S15DPYW5R71S5BWYE"}
sudo apt install --yes gcc

```

```sh {"id":"01J3GK2B4S15DPYW5R739W3HQM"}
choco install --yes mingw

```

```sh {"id":"01J3GK2B4S15DPYW5R770S3TWK"}
gcc --version

```

```sh {"id":"01J3GK2B4S15DPYW5R77TEGA27"}
make c_hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5R78THW9FJ"}
gcc c/hello_ffi.c -L./ -lpact_ffi -o c/hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5R7C7P693E"}
$$env:LD_LIBRARY_PATH=$env:PWD.Path; ./c/hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5R7F69KJPW"}
./c/hello_ffi

```

## C#

```sh {"id":"01J3GK2B4S15DPYW5R7GFV1F9R"}
sudo apt-get install --yes mono-mcs

```

```sh {"id":"01J3GK2B4S15DPYW5R7KWG3Z2E"}
make csharp_hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5R7M6TX1BE"}
cd csharp && mcs helloPact.cs
```

```sh {"id":"01J3GK2B4S15DPYW5R7P36SY3A"}
cd csharp; & 'C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\Roslyn\csc.exe' helloPact.cs; 

```

```sh {"id":"01J3GK2B4S15DPYW5R7P3V9B87"}
$$env:LD_LIBRARY_PATH=$env:PWD.Path; csharp/helloPact

```

```sh {"id":"01J3GK2B4S15DPYW5R7SAEYPZ6"}
csharp/helloPact

```

## Dart

```sh {"id":"01J3GK2B4S15DPYW5R7SB79MBT"}
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
sudo apt-get update
sudo apt-get install dart

```

```sh {"id":"01J3GK2B4S15DPYW5R7TQE105Z"}
choco install --yes dart-sdk

```

```sh {"id":"01J3GK2B4S15DPYW5R7WVZTBS7"}
dart --version

```

```sh {"id":"01J3GK2B4S15DPYW5R80QNH3A7"}
make dart_hello_ffi

```

## Deno

```sh {"id":"01J3GK2B4S15DPYW5R83Q1350S"}
curl -fsSL https://deno.land/x/install/install.sh | sh`
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"`

```

```sh {"id":"01J3GK2B4S15DPYW5R84088EMP"}
choco install --yes deno

```

```sh {"id":"01J3GK2B4S15DPYW5R86W6CXKF"}
deno --version

```

```sh {"id":"01J3GK2B4S15DPYW5R87Q2W229"}
make deno_hello_ffi

```

### Powershell

drop the first `$` if copy/pasting into a shell

```sh {"id":"01J3GK2B4S15DPYW5R88K3XB0V"}
$$env:LD_LIBRARY_PATH=$env:PWD.Path; deno run --allow-ffi --unstable deno/hello_ffi.ts

```

```sh {"id":"01J3GK2B4S15DPYW5R8BA76VJN"}
deno run --allow-ffi --unstable deno/hello_ffi.ts

```

## GoLang

```sh {"id":"01J3GK2B4S15DPYW5R8BGNNYJB"}
sudo apt-get install --yes golang

```

```sh {"id":"01J3GK2B4S15DPYW5R8BM9GXRS"}
choco install --yes golang 

```

```sh {"id":"01J3GK2B4S15DPYW5R8C2DW4HP"}
choco install --yes mingw

```

```sh {"id":"01J3GK2B4S15DPYW5R8FCH3M40"}
go version

```

```sh {"id":"01J3GK2B4S15DPYW5R8FDNS050"}
make go_hello_ffi

```

### Windows

```sh {"id":"01J3GK2B4S15DPYW5R8J455BYW"}
cd go; go build

```

```sh {"id":"01J3GK2B4S15DPYW5R8KTE3JY0"}
go/hello_ffi

```

There is a failure with the latest go 1.19.4 on windows, so you can use the following instructions to install an rc1
see https://github.com/golang/go/issues/51007

```sh {"id":"01J3GK2B4S15DPYW5R8KW0YHVT"}
go install golang.org/dl/go1.20rc1@latest

```

```sh {"id":"01J3GK2B4S15DPYW5R8Q5Z3530"}
go1.20rc1 download

```

```sh {"id":"01J3GK2B4S15DPYW5R8SWY2CZ0"}
cd go; go1.20rc1 build

```

## Haskell

```sh {"id":"01J3GK2B4S15DPYW5R8WF5ZD6J"}
sudo apt-get install --yes ghc

```

```sh {"id":"01J3GK2B4S15DPYW5R8WVPT2GK"}
choco install --yes ghc

```

```sh {"id":"01J3GK2B4S15DPYW5R8Z0ZDS0M"}
choco install --yes llvm

```

```sh {"id":"01J3GK2B4S15DPYW5R91A1WK9Z"}
ghc --version

```

```sh {"id":"01J3GK2B4S15DPYW5R92A9M834"}
make haskell_hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5R95D2ZDDJ"}
ghc haskell/hello_ffi.hs pact_ffi.dll -o haskell/hello_ffi_haskell

```

```sh {"id":"01J3GK2B4S15DPYW5R98362KA9"}
ghc haskell/hello_ffi.hs libpact_ffi.so -o haskell/hello_ffi_haskell
```

```sh {"id":"01J3GK2B4S15DPYW5R992P1B3B"}
$$env:LD_LIBRARY_PATH=$env:PWD.Path; ./haskell/hello_ffi_haskell

```

```sh {"id":"01J3GK2B4S15DPYW5R9CN6F0HV"}
./haskell/hello_ffi_haskell

```

## Java

```sh {"id":"01J3GK2B4S15DPYW5R9E2V8ARQ"}
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz
sudo mkdir -p /usr/lib/jvm
cd /usr/lib/jvm
sudo tar -xvzf ~/hello_ffi/jdk-19_linux-x64_bin.tar.gz
jenv add "/usr/lib/jvm/jdk-19.0.1/bin"
jenv global 19

```

```sh {"id":"01J3GK2B4S15DPYW5R9EVDVYTD"}
choco install --yes temurin19

```

```sh {"id":"01J3GK2B4S15DPYW5R9GXXFR37"}
java --version

```

```sh {"id":"01J3GK2B4S15DPYW5R9MHY29BX"}
make java_jna_hello_ffi

```

linux

```sh {"id":"01J3GK2B4S15DPYW5R9RG5966P"}
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_linux-x64_bin.tar.gz
tar -xzf openjdk-19-jextract+2-3_linux-x64_bin.tar.gz -C java/panama

```

windows

```sh {"id":"01J3GK2B4S15DPYW5R9RKME0XF"}
wget -Headers @{'Cookie'='oraclelicense=accept-securebackup-cookie'} https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_windows-x64_bin.tar.gz -Outfile openjdk-19-jextract+2-3_windows-x64_bin.tar.gz
tar -xzf openjdk-19-jextract+2-3_windows-x64_bin.tar.gz -C java/panama

```

mac

```sh {"id":"01J3GK2B4S15DPYW5R9VSPPQRY"}
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_macos-x64_bin.tar.gz
tar -xzf openjdk-19-jextract+2-3_macos-x64_bin.tar.gz -C java/panama
```

```sh {"id":"01J3GK2B4S15DPYW5R9XSPYEST"}
make java_panama_ffi_gen
make java_panama_hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5RA15H8VB6"}
make java_panama_hello_ffi
```

## NodeJS

```sh {"id":"01J3GK2B4S15DPYW5RA2S87QHW"}
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.zshrc

```

```sh {"id":"01J3GK2B4S15DPYW5RA4VKXN2J"}
source ~/.zshrc
nvm install 16

```

```sh {"id":"01J3GK2B4S15DPYW5RA7KHZ2DZ"}
node -v
npm -v

```

```sh {"id":"01J3GK2B4S15DPYW5RAA8Q6T78"}
make js_ffi_napi_hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5RACVC01B2"}
rm js/node-ffi-napi/node_modules; make js_ffi_napi_hello_ffi
```

```sh {"id":"01J3GK2B4S15DPYW5RACZJXBBA"}
rm -rf js/node-ffi-napi/node_modules && make js_ffi_napi_hello_ffi
```

Below is for powershell, drop the first $ if copy/pasting into your own shell

```sh {"id":"01J3GK2B4S15DPYW5RAEG76VZH"}
$$env:LD_LIBRARY_PATH = $env:PWD.Path; node js/node-ffi-napi/index.js

```

```sh {"id":"01J3GK2B4S15DPYW5RAF557N5J"}
node js/node-ffi-napi/index.js

```

```sh {"id":"01J3GK2B4S15DPYW5RAFMGEC2G"}
make js_ffi_packager_hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5RAKFFRTCA"}
$$env:LD_LIBRARY_PATH = $env:PWD.Path; node js/node-ffi-packager/index.js

```

```sh {"id":"01J3GK2B4S15DPYW5RAPTMMD7P"}
node js/node-ffi-packager/index.js

```

```sh {"id":"01J3GK2B4S15DPYW5RAR7NR541"}
rm -rf js/node-ffi-packager/node_modules && make js_ffi_packager_hello_ffi
```

## Julia

```sh {"id":"01J3GK2B4S15DPYW5RAS98GTNH"}
sudo snap install julia --classic

```

```sh {"id":"01J3GK2B4S15DPYW5RAV8HGQAZ"}
choco install --yes julia

```

```sh {"id":"01J3GK2B4S15DPYW5RAW23K50C"}
julia --version

```

```sh {"id":"01J3GK2B4S15DPYW5RAZGPXCC8"}
make julia_hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5RB2942XH8"}
julia julia/hello_ffi.jl

```

```sh {"id":"01J3GK2B4S15DPYW5RB4NV9E0E"}
$$env:LD_LIBRARY_PATH=$env:PWD.Path; julia julia/hello_ffi.jl

```

## Kotlin

```sh {"id":"01J3GK2B4S15DPYW5RB4X2VFTQ"}
curl -s https://get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

```sh {"id":"01J3GK2B4S15DPYW5RB537HJ53"}
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 19-tem
sdk install kotlin
sdk install gradle
```

```sh {"id":"01J3GK2B4S15DPYW5RB5VAVZT7"}
kotlin -version
gradle -version

```

```sh {"id":"01J3GK2B4S15DPYW5RB7RT0ZY7"}
make kotlin_hello_ffi

```

## Lua

```sh {"id":"01J3GK2B4S15DPYW5RB882VDEE"}
sudo apt-get install --yes luajit

```

```sh {"id":"01J3GK2B4S15DPYW5RBAAFFGB0"}
luajit -v

```

```sh {"id":"01J3GK2B4S15DPYW5RBB9WHMD1"}
make lua_hello_ffi

```

## Nim

```sh {"id":"01J3GK2B4S15DPYW5RBENN7XSA"}
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
```

```sh {"id":"01J3GK2B4S15DPYW5RBFTNS1V1"}
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
export PATH=$HOME/.nimble/bin:$PATH

```

```sh {"id":"01J3GK2B4S15DPYW5RBFXC90SH"}
choco install --yes nim

```

```sh {"id":"01J3GK2B4S15DPYW5RBK75H8YF"}
nim --version

```

```sh {"id":"01J3GK2B4S15DPYW5RBKPSB17Y"}
make nim_hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5RBQJEWPN6"}
nim c -r --hints:off nim/hello_ffi.nim

```

## OCaml

```sh {"id":"01J3GK2B4S15DPYW5RBR3PM8SW"}
sudo apt-get install --yes ocaml opam

```

```sh {"id":"01J3GK2B4S15DPYW5RBS15Q50Z"}
ocaml --version

```

```sh {"id":"01J3GK2B4S15DPYW5RBSPPJQ3M"}
opam init --auto

```

```sh {"id":"01J3GK2B4S15DPYW5RBVMVK8B7"}
opam install ctypes ctypes-foreign utop

```

```sh {"id":"01J3GK2B4S15DPYW5RBW2SAZYV"}
eval $(opam env)
```

```sh {"id":"01J3GK2B4S15DPYW5RBYDHEVGV"}
make ocaml_hello_ffi

```

## Perl

```sh {"id":"01J3GK2B4S15DPYW5RBZ0ZSERF"}
perl -v

```

```sh {"id":"01J3GK2B4S15DPYW5RC2QSYS4W"}
perl -e 'use FFI::Platypus;;'

```

## Pre-requisites

```sh {"id":"01J3GK2B4S15DPYW5RC5RZ0P9N"}
cpan FFI::Platypus

```

```sh {"id":"01J3GK2B4S15DPYW5RC81B33PW"}
cpanm Capture::Tiny ExtUtils::ParseXS ExtUtils::MakeMaker IPC::Cmd

```

### Windows

Strawberry perl comes with FFI:Platypus pre-installed

```sh {"id":"01J3GK2B4S15DPYW5RC8299PP7"}
choco install --yes strawberryperl

```

### Hello Ffi - Perl

```sh {"id":"01J3GK2B4S15DPYW5RCA38J2KG"}
make perl_hello_ffi

```

```sh {"id":"01J3GK2B4S15DPYW5RCDKPX5YM"}
perl perl/hello_ffi.pl

```

## PHP

### Ubuntu

```sh {"id":"01J3GK2B4S15DPYW5RCGKZSPNQ"}
sudo apt-get install --yes php

```

```sh {"id":"01J3GK2B4S15DPYW5RCJPSXKF8"}
choco install --yes php

```

```sh {"id":"01J3GK2B4S15DPYW5RCPEMQMPR"}
scoop bucket add php
scoop install php/php8.1

```

```sh {"id":"01J3GK2B4S15DPYW5RCQ7XJ78Q"}
php -m

```

```sh {"id":"01J3GK2B4S15DPYW5RCSTHE69Z"}
code $HOME\scoop\apps\php8.1\8.1.13\conf.d\extensions.ini

```

```sh {"id":"01J3GK2B4T50A2J81P4KNMXTHP"}
extension_dir = ext
extension = php_ffi.dll

```

```sh {"id":"01J3GK2B4T50A2J81P4NKKPWG5"}
php -m | grep -e FFI

```

```sh {"id":"01J3GK2B4T50A2J81P4SFP2TNE"}
make php_hello_ffi

```

## Python

```sh {"id":"01J3GK2B4T50A2J81P4T1B6QH0"}
python3 --version

```

### Ubuntu

```sh {"id":"01J3GK2B4T50A2J81P4XS0TKT1"}
sudo apt-get install --yes pip

```

### Windows

```sh {"id":"01J3GK2B4T50A2J81P50DW7J9K"}
choco install --yes pip

```

```sh {"id":"01J3GK2B4T50A2J81P516E0XA9"}
make python_hello_ffi_ctypes

```

```sh {"id":"01J3GK2B4T50A2J81P55176WYH"}
make python_install_deps

```

```sh {"id":"01J3GK2B4T50A2J81P57D8S0MM"}
make python_hello_ffi_cffi

```

## Racket

```sh {"id":"01J3GK2B4T50A2J81P58RYX992"}
sudo apt-get install --yes racket

```

```sh {"id":"01J3GK2B4T50A2J81P5C5CHRFQ"}
choco install --yes racket

```

```sh {"id":"01J3GK2B4T50A2J81P5D7BD0R9"}
(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

```

```sh {"id":"01J3GK2B4T50A2J81P5DVNV6GF"}
$$env:Path -split ';'

```

```sh {"id":"01J3GK2B4T50A2J81P5EB6QXAZ"}
$$Env:Path += [IO.Path]::PathSeparator + 'C:\Program Files\Racket\'
racket --version

```

```sh {"id":"01J3GK2B4T50A2J81P5EQ7BP8K"}
racket --version

```

```sh {"id":"01J3GK2B4T50A2J81P5HZ2WKSH"}
make racket_hello_ffi

```

## Raku (Perl 6)

```sh {"id":"01J3GK2B4T50A2J81P5JJW97XZ"}
sudo apt-get install --yes rakudo

```

```sh {"id":"01J3GK2B4T50A2J81P5JRTQAV6"}
choco install --yes rakudostar

```

```sh {"id":"01J3GK2B4T50A2J81P5KN88RVD"}
rakudo --version

```

```sh {"id":"01J3GK2B4T50A2J81P5MNZWP5A"}
cd /usr/lib/perl6/site
sudo mkdir -p short; sudo chmod -R 777 short
cd /usr/lib/perl6/vendor
sudo mkdir -p short; sudo chmod -R 777 short

```

```sh {"id":"01J3GK2B4T50A2J81P5N51X14F"}
make raku_hello_ffi

```

```sh {"id":"01J3GK2B4T50A2J81P5PMKBEWF"}
$env:LD_LIBRARY_PATH = $env:PWD.Path; rakudo raku/hello_ffi.raku

```

## Ruby

### Ubuntu 20.04

```sh {"id":"01J3GK2B4T50A2J81P5Q9ZZJZ8"}
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles
source ~/.rvm/scripts/rvm
rvm install 2.7.6
ruby --version

```

### Ubuntu 22.04

```sh {"id":"01J3GK2B4T50A2J81P5SWMCWNS"}
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
sudo usermod -a -G rvm $USER
source /etc/profile.d/rvm.sh
rvm pkg install openssl
rvm install 2.7.6 --with-openssl-dir=/usr/share/rvm/usr
gem install bundler

```

```sh {"id":"01J3GK2B4T50A2J81P5SX0W0RM"}
source ~/.rvm/scripts/rvm
rvm list
rvm --default use ruby-2.7.6
ruby --version

```

### Windows

```sh {"id":"01J3GK2B4T50A2J81P5WC61KKW"}
scoop install ruby msys2

```

```sh {"id":"01J3GK2B4T50A2J81P5YKW64T0"}
ridk install

```

```sh {"id":"01J3GK2B4T50A2J81P60ZN2JEM"}
ruby --version

```

```sh {"id":"01J3GK2B4T50A2J81P62FTMYVN"}
make ruby_hello_ffi_fiddle

```

```sh {"id":"01J3GK2B4T50A2J81P64V8M78K"}
make ruby_hello_ffi_ffi_deps

```

```sh {"id":"01J3GK2B4T50A2J81P65C281CQ"}
make ruby_hello_ffi_ffi

```

## Scala-Native

```sh {"id":"01J3GK2B4T50A2J81P69BQE4NA"}
echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo -H gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
sudo chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
sudo apt update
sudo apt install --yes sbt clang
sbt --version
```

```sh {"id":"01J3GK2B4T50A2J81P6ATPXXFQ"}
choco install --yes sbt
```

```sh {"id":"01J3GK2B4T50A2J81P6BHJG2J0"}
sbt --version

```

```sh {"id":"01J3GK2B4T50A2J81P6D1TQ0Q5"}
make scala_native_deps
make scala_native_hello_ffi

```

## Swift

### Ubuntu 20.04

```sh {"id":"01J3GK2B4T50A2J81P6DS6KAKV"}
#wget https://swift.org/builds/swift-5.7.2-release/ubuntu2004/swift-5.7.2-RELEASE/swift-5.7.2-RELEASE-ubuntu20.04.tar.gz
#tar xzf swift-5.7.2-RELEASE-ubuntu20.04.tar.gz
sudo mv swift-5.7.2-RELEASE-ubuntu20.04 /usr/share/swift
source ~/.bashrc
swift -v
swiftc -v
make swift_hello_ffi

```

### Ubuntu 22.04

```sh {"id":"01J3GK2B4T50A2J81P6GWZ4NJ6"}

```

```sh {"id":"01J3GK2B4T50A2J81P6MSE2W0P"}
# wget https://swift.org/builds/swift-5.7.2-release/ubuntu2204/swift-5.7.2-RELEASE/swift-5.7.2-RELEASE-ubuntu22.04.tar.gz
# tar xzf swift-5.7.2-RELEASE-ubuntu22.04.tar.gz
# sudo mv swift-5.7.2-RELEASE-ubuntu22.04 /usr/share/swift
export PATH=/usr/share/swift/usr/bin:$PATH
source ~/.zshrc
swift -v
swiftc -v

```

```sh {"id":"01J3GK2B4T50A2J81P6MYKS6MZ"}
swift -v
swiftc -v

```

```sh {"id":"01J3GK2B4T50A2J81P6NACSNT9"}
make swift_hello_ffi

```

```sh {"id":"01J3GK2B4T50A2J81P6QX32GFS"}
swiftc swift/hello_ffi.swift -import-objc-header pact.h -L${PWD} -lpact_ffi -o swift/hello_ffi
```

```sh {"id":"01J3GK2B4T50A2J81P6RSR1CJK"}
LD_LIBRARY_PATH=$PWD ./swift/hello_ffi
```

## Visual Basic

```sh {"id":"01J3GK2B4T50A2J81P6V1FVVMH"}
sudo apt-get install --yes mono-vbnc
```

```sh {"id":"01J3GK2B4T50A2J81P6WZYFS4B"}
choco install --yes mono

```

```sh {"id":"01J3GK2B4T50A2J81P6YJV7DF7"}
choco install --yes dotnet

```

```sh {"id":"01J3GK2B4T50A2J81P718WXA9H"}
make visual_basic_hello_ffi

```

## Zig

```sh {"id":"01J3GK2B4T50A2J81P742CHQ5M"}
sudo snap install zig --classic --beta

```

```sh {"id":"01J3GK2B4T50A2J81P77BE0T5J"}
choco install --yes zig

```

```sh {"id":"01J3GK2B4T50A2J81P79S3CFZ8"}
zig version

```

```sh {"id":"01J3GK2B4T50A2J81P7AHP0504"}
make zig_hello_ffi

```
