# USB extroot — проверено

microSD на экземпляре не заработала: в `dmesg` ошибки `mtk-msdc 10130000.mmc`; устройства `/dev/mmc*` нет. Рабочий обход — USB flash через встроенный hub.

USB-накопитель Phison 13fe:4300, 15,5 GB; раздел `/dev/sda1`, ext4, метка `extroot`, UUID `1ffe24bb-5a61-426f-af4b-6f69b25391e2`.

Установлены `kmod-usb-storage`, `block-mount`, `kmod-fs-ext4`, `e2fsprogs`. Данные overlay скопированы на ext4-раздел; в `/etc/config/fstab` задан mount target `/overlay`. Проверено:

```text
/dev/sda1 on /overlay type ext4 (rw,relatime)
overlayfs:/overlay on / type overlay
```

Свободно около 13,4 GiB. **Не отключать USB-накопитель во время работы.** Перед разметкой всегда перепроверяйте `lsblk` — форматирование удаляет данные.
