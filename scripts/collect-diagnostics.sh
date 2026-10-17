#!/bin/sh
# Contains device-specific information; review before sharing.
set -u
printf '%s\n' '=== system ==='
ubus call system board 2>/dev/null || true
uname -a
printf '%s\n' '=== cmdline ==='
cat /proc/cmdline
printf '%s\n' '=== mtd ==='
cat /proc/mtd
printf '%s\n' '=== usb ==='
lsusb 2>/dev/null || true
printf '%s\n' '=== mounts ==='
mount
printf '%s\n' '=== devices ==='
ls -l /dev/ttyS* /dev/i2c* /dev/rtc* /dev/mmc* 2>/dev/null || true
printf '%s\n' '=== i2c ==='
i2cdetect -l 2>/dev/null || true
