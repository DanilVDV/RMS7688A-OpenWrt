# I²C / RTC — текущая проблема и диагностика

DTS: `palmbus@10000000/i2c@900`, `compatible = "mediatek,mt7621-i2c"`, `status = "okay"`; pinmux i2c присутствует. Platform device: `10000900.i2c`.

Но в Linux нет I²C-драйвера, `/sys/class/i2c-adapter` пуст, `/dev/i2c-*` отсутствует. Пользовательские `i2c-tools` установлены.

В OpenWrt выбраны:
```text
CONFIG_PACKAGE_kmod-i2c-core=m
CONFIG_PACKAGE_kmod-i2c-mt7628=m
```
Пакеты `kmod-i2c-core-6.12.94-r1.apk` и `kmod-i2c-mt7628-6.12.94-r1.apk` собирались и устанавливались, но файлов `.ko` не обнаружено ни в build_dir, ни на плате. Реальный kernel `.config` и даже `.config.set` содержат:
```text
# CONFIG_I2C is not set
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MT7621 is not set
```

Определения: `package/kernel/linux/modules/i2c.mk` и `target/linux/ramips/modules.mk`; драйвер `drivers/i2c/busses/i2c-mt7621`. **Проблема не решена**. Следующий шаг — разобраться, почему package selection не попадает в kernel config, затем получить реальные `.ko`, проверить ABI и загрузить модули.

После появления `/dev/i2c-0`: `i2cdetect -l`, затем осторожное `i2cdetect -y 0`. Модель RTC неизвестна: адрес сам по себе не идентифицирует чип. Не добавлять произвольный RTC compatible в DTS.
