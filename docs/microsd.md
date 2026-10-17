# microSD — не работает в текущей конфигурации

При установленной карте не появились `/dev/mmc*`. Kernel сообщает ошибки `mtk-msdc 10130000.mmc`, включая `host->error=0x00000002`. Возможные причины: карта, контакты, питание, pinmux или несовпадение DTS с RMS7688A-DEMO. Другой карты для контрольного теста пока не было. Нельзя утверждать, что слот неисправен.

```sh
dmesg | grep -Ei 'mmc|msdc|sdcard'
ls -l /dev/mmc* 2>/dev/null
find /sys/bus/mmc -maxdepth 3 -type l 2>/dev/null
```

Практическое решение для хранения — USB extroot (см. `extroot.md`).
