#!/bin/sh
set -eux

case ${TARGETARCH} in
	"amd64")  WHEEL_PLATFORM_SUFFIX=manylinux1_x86_64
    ;;
	"arm64")  WHEEL_PLATFORM_SUFFIX=manylinux2014_aarch64
    ;;
esac

PYTHON_VERSION_NODOT=$(python3 -c 'import sysconfig; print(sysconfig.get_config_var("py_version_nodot"))')
LABONE_VERSION_NOLEADINGZEROS=$(echo ${LABONE_VERSION} | sed 's/\.0*/\./')

WHEEL_FILENAME=zhinst_core-${LABONE_VERSION_NOLEADINGZEROS}-cp${PYTHON_VERSION_NODOT}-cp${PYTHON_VERSION_NODOT}-${WHEEL_PLATFORM_SUFFIX}.whl

curl -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/115.0" -LO ${LABONE_BASE_URL}/${WHEEL_FILENAME}
pip install --no-index ${WHEEL_FILENAME}
rm -f ${WHEEL_FILENAME}
