# Публикация и обновление

Репозиторий: `git@github.com:DanilVDV/RMS7688A-OpenWrt.git`.

```sh
git clone git@github.com:DanilVDV/RMS7688A-OpenWrt.git
cd RMS7688A-OpenWrt
# Если репозиторий пуст, скопируйте файлы из архива проекта сюда.
git add README.md docs scripts .gitignore
git commit -m "Документация RMS7688A-DEMO и OpenWrt 25.12.5"
git push -u origin HEAD
```

Перед публикацией проверьте `git status`, `git diff --cached` и отсутствие конфиденциальных данных.
