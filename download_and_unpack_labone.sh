#!/bin/sh
set -eux

case ${TARGETARCH} in
	"amd64")  ARCH=64
    ;;
	"arm64")  ARCH=ARM64
    ;;
esac
curl -LO ${LABONE_BASE_URL}/LabOneLinux${ARCH}-${LABONE_VERSION}.tar.gz
tar -xvf LabOneLinux*
rm -f LabOneLinux${ARCH}-${LABONE_VERSION}.tar.gz