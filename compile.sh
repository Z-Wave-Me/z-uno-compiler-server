#!/bin/bash

CHIP=$1
NAME=$2

${BUILD_DIR}/zme_make/zme_make build /sketch/tmp/tmp.ino \
	-S $(find ${BUILD_DIR} -name cores) \
	-S $(find ${BUILD_DIR} -name libraries) \
	-S $(find ${BUILD_DIR} -name include | grep -E "lib/gcc/arm-none-eabi/[^/]*/include") \
	-T $(find ${BUILD_DIR} -maxdepth 2 -name bin) \
	-lc $(find ${BUILD_DIR} -name libclang.so -exec dirname {} \;) \
	-B /sketch/ \
	-O make_listing \
	-O "BO:-DZUNO_SKETCH_NAME=\"${NAME}\"" \
	-C ${CHIP} > /sketch/tmp/log.txt

echo $? > /sketch/tmp/status.txt
