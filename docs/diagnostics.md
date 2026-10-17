# Диагностика

```sh
ubus call system board
uname -a
cat /proc/cmdline
cat /proc/mtd
cat /proc/meminfo | head
ip link
lsusb
lsmod
mount
df -h
ls -l /dev/ttyS* /dev/i2c* /dev/rtc* /dev/mmc* 2>/dev/null
i2cdetect -l
dmesg | grep -Ei 'i2c|rtc|mmc|msdc|usb|ttyS'
```

Дамп DT без изменения устройства:

```sh
find /sys/firmware/devicetree/base -iname '*i2c*' -o -iname '*rtc*'
ls -l /sys/bus/platform/devices/10000900.i2c
```

Выводы могут содержать MAC-адреса, серийные номера и данные сети; очищайте перед публикацией.
