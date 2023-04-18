FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install --yes make curl zip unzip wget gpg

RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/dart.gpg
RUN echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | tee /etc/apt/sources.list.d/dart_stable.list
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
RUN chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg

RUN apt-get update

RUN apt-get install --yes gnat-10 gcc mono-mcs dart golang ghc julia luajit nim ocaml opam mono-vbnc sbt clang rakudo racket python3 pip php

SHELL ["/bin/bash", "--login", "-c"]
ENV HOME=/root
RUN curl -fsSL https://bun.sh/install | bash
ENV BUN_INSTALL="$HOME/.bun"
ENV PATH="$BUN_INSTALL/bin:$PATH"
RUN curl -fsSL https://deno.land/x/install/install.sh | sh
ENV DENO_INSTALL="$HOME/.deno"
ENV PATH="$DENO_INSTALL/bin:$PATH"

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 16.19.0
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN curl -s https://get.sdkman.io | bash && \
     source "$HOME/.sdkman/bin/sdkman-init.sh" && \
     sdk install java 19-tem && \
     sdk install gradle && \
     sdk install kotlin

RUN wget https://swift.org/builds/swift-5.7.2-release/ubuntu2004/swift-5.7.2-RELEASE/swift-5.7.2-RELEASE-ubuntu20.04.tar.gz
RUN tar xzf swift-5.7.2-RELEASE-ubuntu20.04.tar.gz
RUN mv swift-5.7.2-RELEASE-ubuntu20.04 /usr/share/swift
ENV PATH=/usr/share/swift/usr/bin:$PATH
RUN swift -v
RUN swiftc -v

# RUN opam init --auto
# RUN opam install ctypes ctypes-foreign utop<<<yes
# RUN eval $(opam env)
WORKDIR /home/hello_ffi


RUN mkdir -p java/panama
RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_linux-x64_bin.tar.gz
RUN tar -xzf openjdk-19-jextract+2-3_linux-x64_bin.tar.gz -C java/panama
RUN cpan FFI:Platypus
# Add candidate path to $PATH environment variable
RUN pip install cffi
ENV SDKMAN_DIR=/root/.sdkman
ENV JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
ENV GRADLE_HOME="$SDKMAN_DIR/candidates/gradle/current"
ENV KOTLIN_HOME="$SDKMAN_DIR/candidates/kotlin/current"
ENV PATH="$JAVA_HOME/bin:$PATH"
ENV PATH="$GRADLE_HOME/bin:$PATH"
ENV PATH="$KOTLIN_HOME/bin:$PATH"
RUN curl -sS https://webi.sh/zig | sh
ENV PATH="/root/.local/opt/zig/:$PATH"
COPY . .
# RUN apt-get install cpanm
# RUN apt-get install cpanm
RUN ["make","get_pact_ffi"]

CMD ["make","-i", "hello_ffi"]