#!/bin/bash

${BUILD_DIR}/zme_make/zme_make build /sketch/tmp/tmp.ino \
	-S $(find ${BUILD_DIR} -name cores) \
	-S $(find ${BUILD_DIR} -name libraries) \
	-S $(find ${BUILD_DIR} -name include | grep -E "lib/gcc/arm-none-eabi/[^/]*/include") \
	-T $(find ${BUILD_DIR} -maxdepth 2 -name bin) \
	-lc $(find ${BUILD_DIR} -name libclang.so -exec dirname {} \;) \
	-B /sketch/ \
	-O make_listing \
	-O BO:-DARDUINO=152 \
	-O BO:-DARDUINO_ARCH_ZUNOG2
