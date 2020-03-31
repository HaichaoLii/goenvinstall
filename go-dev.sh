#!/bin/bash
set -ex
ARCH=`uname -m`
#golang sdk
case ${ARCH} in
  x86_64)
    wget -q https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.13.5.linux-amd64.tar.gz
    ;;
  aarch64)
    wget -q https://dl.google.com/go/go1.13.5.linux-arm64.tar.gz
    sudo tar -C /usr/local -xzf go1.13.5.linux-arm64.tar.gz
    ;;
  *)
    echo "[ERROR] Unsupported build ARCH ${ARCH}"
    exit 1
    ;;
esac
rm -f go1.13.5.linux*
cat >> ~/.bashrc <<EOF
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=~/go
EOF
source ~/.bashrc
#golang
sudo apt install -y docker.io
sudo chmod 666 /var/run/docker.sock
#rook code
go get -d github.com/rook/rook
#kubernetes
./kubeadm.sh up

echo "install successful"
