# I²C / RTC — в диагностике

DT содержит `palmbus@10000000/i2c@900` со `status=okay`, `compatible=mediatek,mt7621-i2c`; pinctrl содержит `i2c_pins` с function/group `i2c`. Platform device `10000900.i2c` присутствует. Но `/sys/class/i2c-adapter/` пуст, `/dev/i2c*` отсутствует, `i2cdetect -l` пуст, драйвер не привязан.

В исходниках `target/linux/ramips/modules.mk` пакет `kmod-i2c-mt7628` использует `CONFIG_I2C_MT7621:drivers/i2c/busses/i2c-mt7621`. `package/kernel/linux/modules/i2c.mk` для `kmod-i2c-core` использует `CONFIG_I2C` и `CONFIG_I2C_CHARDEV`.

Сборка двух APK и их установка **не помогли**: `.ko` не было ни в `build_dir`, ни в `/lib/modules/$(uname -r)`. Kernel `.config.set` и `.config.override` содержали `# CONFIG_I2C is not set`, `# CONFIG_I2C_CHARDEV is not set`, `# CONFIG_I2C_MT7621 is not set`, хотя OpenWrt `.config` содержал `CONFIG_PACKAGE_kmod-i2c-core=m`, `CONFIG_PACKAGE_kmod-i2c-mt7628=m`.

Следующий шаг: выяснить, почему конфигурация пакетов не попадает в kernel Kconfig; проверить макрос `i2c_defaults`, пересборку kernel config и содержимое APK. **Не считать I²C работающим**, пока не появится adapter. После появления `/dev/i2c-0` можно осторожно сканировать шину (`i2cdetect -y 0`), учитывая риски опроса неизвестных устройств. RTC-чип и его адрес пока неизвестны; наличие батарейки не определяет модель микросхемы. Для RTC может понадобиться отдельный kernel driver и child node в DTS.
