# Сборка OpenWrt

Рабочее дерево пользователя: `~/RMS7688A/openwrt-25.12.5` (полное дерево исходников). Профиль: `Target System: MediaTek Ralink MIPS`, `Subtarget: MT76x8`, `Device: MediaTek LinkIt Smart 7688`.

```sh
cd ~/RMS7688A/openwrt-25.12.5
make menuconfig
# Сохранить конфигурацию
make -j"$(nproc)" V=s
```

**Не считать команды воспроизводимой сборкой без фиксации исходного commit, feeds и пользовательских патчей.** Сохраните `./scripts/diffconfig.sh > config.build` (если скрипт есть), `git diff` и `git status` локального OpenWrt. Не копируйте исходное дерево OpenWrt в этот репозиторий.

## Освобождение ttyS2

Заводской kernel cmdline содержал `console=ttyS2,57600`. В пользовательской прошивке консоль на `ttyS2` отключена специально для приложения. **Точный патч и метод изменения пока не предоставлены**, поэтому здесь нет выдуманной инструкции. При следующей сборке обязательно сохраните это изменение и проверьте `cat /proc/cmdline`, `cat /proc/consoles`, `dmesg | grep -i tty` и фактическую работу UART.

## Перед прошивкой

Сохраните backup, сравните DTS/MTD и проверьте, что образ предназначен для выбранного профиля. На данной плате официальная прошивка LinkIt Smart 7688 запустилась, Ethernet/Wi-Fi работают, но это не гарантия совместимости всех интерфейсов. Обновление через `sysupgrade` делайте только после проверки формата и board compatibility; точная команда зависит от имени образа и состояния устройства.

## Пакеты I²C

В OpenWrt `.config` выбирались `CONFIG_PACKAGE_kmod-i2c-core=m` и `CONFIG_PACKAGE_kmod-i2c-mt7628=m`. Созданные `kmod-i2c-core-6.12.94-r1.apk` и `kmod-i2c-mt7628-6.12.94-r1.apk` устанавливались, но `.ko` отсутствовали. В kernel `.config`, `.config.set`, `.config.override` сохранялось `# CONFIG_I2C is not set`, `# CONFIG_I2C_CHARDEV is not set`, `# CONFIG_I2C_MT7621 is not set`. **Задача не решена.** Не публикуйте эти APK как работающие.

`scp` с современным SFTP по умолчанию не работал с Dropbear (`subsystem request failed`); для передачи применялся `scp -O ... root@<board-ip>:/tmp/`.
