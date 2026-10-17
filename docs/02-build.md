# Сборка OpenWrt

Исходное дерево на workstation: `~/RMS7688A/openwrt-25.12.5`; target `ramips/mt76x8`, профиль `mediatek_linkit-smart-7688`. Это **совместимый исходный профиль**, не полноценное описание carrier-платы.

```sh
cd ~/RMS7688A/openwrt-25.12.5
make menuconfig
# Target System: MediaTek Ralink MIPS
# Subtarget: MT76x8
# Device: MediaTek LinkIt Smart 7688
make -j$(nproc) V=s
```

Собственная модификация **освобождает ttyS2 от kernel console**. Точный патч в этом репозитории пока отсутствует; при новой сборке обязательно повторно проверить kernel cmdline, DTS и getty, чтобы не вернуть консоль на ttyS2. Старый boot log содержал `console=ttyS2,57600`, но это не отражает уже выполненную кастомизацию.

В 25.12 используется пакетный менеджер `apk`. При копировании файлов на Dropbear, не поддерживающий SFTP, используйте `scp -O`.

Не перепрошивайте устройство только ради модулей: сначала убедитесь, что конфигурация ядра и ABI соответствуют установленной системе.
