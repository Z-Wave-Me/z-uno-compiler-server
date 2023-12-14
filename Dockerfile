FROM debian:latest
MAINTAINER "Poltorak Serguei" <ps@z-wave.me>
ENV DEBIAN_FRONTEND noninteractive

# Settings
ENV PACKAGE_JSON="https://z-uno.z-wave.me/files/z-uno2/package_z-wave2.me_index.json"
ENV TOOL_ARCH="x86_64-pc-linux-gnu"

# Environment
ENV BUILD_DIR="/build"

# Install and download
RUN apt-get update && apt-get install -y make unzip wget jq libncurses5 && \
    mkdir ${BUILD_DIR} && \
    TMP_DIR=$(mktemp -d) && cd ${TMP_DIR} && \
    echo "Downloading Package JSON" && wget -q ${PACKAGE_JSON} -O package.json && \
    CORE_URL=$(jq -r '.packages[-1].platforms[-1].url' package.json) && \
    echo "Downloading Cores" && wget ${CORE_URL} -qO tmp.zip && unzip -qq tmp.zip -d ${BUILD_DIR} && \
    for _TOOL in $(jq -r '.packages[-1].platforms[-1].toolsDependencies|map(.name + ";" + .version)[]' package.json); do \
        TOOL_NAME=${_TOOL%%;*} && TOOL_VERSION=${_TOOL##*;} && \
        TOOL_URL=$(jq -r '.packages[-1].tools[]|select(.name=="'${TOOL_NAME}'" and .version=="'${TOOL_VERSION}'")|.systems[]|select(.host=="'${TOOL_ARCH}'")|.url' package.json) && \
        echo "Downloading ${TOOL_NAME}" && wget ${TOOL_URL} -qO - | tar -zx -C ${BUILD_DIR}; \
    done && \
    rm -R ${TMP_DIR} && \
    chmod 755 ${BUILD_DIR}/zme_make/zme_make

# Copy scripts
COPY compile.sh ${BUILD_DIR}/compile.sh
COPY bootloader.sh ${BUILD_DIR}/bootloader.sh
COPY bootloaders.sh ${BUILD_DIR}/bootloaders.sh
