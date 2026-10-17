# USB extroot — работает

На внутреннем overlay было около 25.8 МБ, свободно около 20 МБ. USB-накопитель Phison `13fe:4300`, около 15.5 GB, стал `/dev/sda`; раздел `/dev/sda1` отформатирован в ext4, метка `extroot`, UUID `1ffe24bb-5a61-426f-af4b-6f69b25391e2` (UUID индивидуален).

Установлены `kmod-usb-storage`, `block-mount`, `kmod-fs-ext4`, `e2fsprogs`; содержимое прежнего overlay скопировано на USB и настроен fstab mount target `/overlay`. После перезагрузки:

```text
/dev/sda1 on /overlay type ext4 (rw,relatime)
overlayfs:/overlay on / type overlay (...)
```

Доступно около 13.4 GB. Проверка:

```sh
block info
cat /etc/config/fstab
mount | grep -E '/overlay|overlayfs'
df -h /
```

Не извлекайте USB во время работы: на нём находится корневой writable overlay. Перед повторением процедуры сделайте backup конфигурации и используйте UUID **своего** носителя, а не указанный выше.
