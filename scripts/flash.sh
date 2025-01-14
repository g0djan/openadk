#!/bin/bash

OUTPUT_DIR=$1
BOARD_NAME=${2:-stm32f429disc1}

if ! test -d "${OUTPUT_DIR}" ; then
    echo "ERROR: no output directory specified."
    echo "Usage: $0 OUTPUT_DIR BOARD_NAME"
    echo ""
    echo "Arguments:"
    echo "    OUTPUT_DIR    The Buildroot output directory."
    echo "    BOARD_NAME    One of the available boards among:"
    echo "                  stm32f429discovery, stm32f429disc1"
    exit 1
fi

./host_x86_64-linux-gnu/usr/bin/openocd -f board/${BOARD_NAME}.cfg \
  -c "init" \
  -c "reset init" \
  -c "flash probe 0" \
  -c "flash info 0" \
  -c "flash write_image erase ${OUTPUT_DIR}/stm32f429i-disco.bin 0x08000000" \
  -c "flash write_image erase ${OUTPUT_DIR}/stm32f429-disco.dtb 0x08004000" \
  -c "flash write_image erase ${OUTPUT_DIR}/st-stm32f429-initramfspiggyback-kernel 0x08008000" \
  -c "reset run" \
  -c "shutdown"
