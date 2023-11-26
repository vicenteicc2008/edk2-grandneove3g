#!/bin/bash
# based on the instructions from edk2-platform
set -e
. ./scripts/build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_ARM_PREFIX=arm-linux-gnueabi- build -j$(nproc) -s -n 0 -a ARM -t GCC5 -p EXYNOS7885Pkg/Devices/grandneoplus.dsc
./scripts/build_bootshim.sh
cat BootShim/BootShim.bin workspace/Build/EXYNOS7885Pkg/DEBUG_GCC5/FV/EXYNOS7885PKG_UEFI.fd > workspace/bootpayload.bin
./scripts/mkbootimg --kernel=workspace/bootpayload.bin --output=workspace/Y560.img --base=0x80000000