#!/bin/sh
set -eux

case ${TARGETARCH} in
	"amd64")  ARCH=64
    ;;
	"arm64")  ARCH=ARM64
    ;;
esac
curl -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/115.0" -LO ${LABONE_BASE_URL}/LabOneLinux${ARCH}-${LABONE_VERSION}.tar.gz
tar -xvf LabOneLinux*
rm -f LabOneLinux${ARCH}-${LABONE_VERSION}.tar.gz
