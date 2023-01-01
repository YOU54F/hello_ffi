```sh
sudo apt-get update
```

```sh
make get_pact_ffi
```

```sh
sudo apt-get --yes install gnat-10
gnat --version
gnatmake --version
```

```sh
make ada_hello_ffi
```

```sh
curl -fsSL https://bun.sh/install | bash
source ~/.zshrc
```

```sh
bun --version
make bun_hello_ffi
```

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

```sh
sudo apt-get install --yes golang
```

```sh
go version
```

```sh
make go_hello_ffi
```

```sh
sudo apt-get install --yes ghc
```

```sh
ghc --version
```

```sh
make haskell_hello_ffi
```

```sh
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz
sudo mkdir -p /usr/lib/jvm
cd /usr/lib/jvm
sudo tar -xvzf ~/hello_ffi/jdk-19_linux-x64_bin.tar.gz
export JAVA_HOME="/usr/lib/jvm/jdk-19.0.1"
export PATH="/usr/lib/jvm/jdk-19.0.1/bin:$PATH"
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

```sh
sudo snap install julia --classic
```

```sh
julia --version
```

```sh
make julia_hello_ffi
```

```sh
sudo apt-get install --yes luajit
```

```sh
luajit -v
```

```sh
make lua_hello_ffi
```

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

```sh
perl -v
```

```sh
cpan FFI::Platypus
```

```sh
make perl_hello_ffi
```

```sh
python3 --version
```

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

```sh
sudo apt-get install --yes racket
```

```sh
racket --version
```

```sh
make racket_hello_ffi
```

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
