#!/bin/bash
set -ex
ARCH=`uname -m`
PROJECT="github.com/rook/rook"
#golang
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
export PATH=\$PATH:\$GOROOT/bin
export GOPATH=~/go
export KUBECONFIG=~/admin.conf
EOF
source ~/.bashrc
#docker
sudo apt install -y docker.io
sudo chmod 666 /var/run/docker.sock
#project code
go get -d $PROJECT
#kubernetes
./kubeadm.sh up

echo "install successful"
