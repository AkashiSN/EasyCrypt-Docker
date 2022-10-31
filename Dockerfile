# syntax = docker/dockerfile:1.4
FROM ocaml/opam:ubuntu-22.04-ocaml-4.08

SHELL ["/bin/bash", "-e", "-c"]
ENV DEBIAN_FRONTEND noninteractive

RUN <<EOT
opam pin -yn add easycrypt https://github.com/EasyCrypt/easycrypt.git

sudo apt-get update
sudo apt-get install -y autoconf
opam depext easycrypt -y

opam install --deps-only easycrypt
opam install alt-ergo

sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

opam install easycrypt
eval $(opam env)
easycrypt why3config
EOT

WORKDIR /workdir