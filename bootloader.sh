#!/bin/bash

HW=$1
find /build/ -name "zuno_bootloader_HW${HW}.bin" -exec cat {} \;
