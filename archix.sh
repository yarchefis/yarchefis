#!/bin/bash

# Функция для обновления системы и установки пакетов
update_system() {
    echo "Обновление системы и установка пакетов..."
    sudo pacman -Syu --noconfirm

    # Проверяем удаленные пакеты
    removed_packages=$(pacman -Qdtq)
    if [[ -n $removed_packages ]]; then
        echo "Удаление удаленных пакетов: $removed_packages"
        sudo pacman -Rs --noconfirm $removed_packages
    else
        echo "Нет удаленных пакетов для удаления."
    fi

    # Установка новых пакетов из файла конфигурации
    source pkg.conf
    for pkg in "${PACKAGES[@]}"; do
        echo "Установка пакета: $pkg"
        sudo pacman -S --noconfirm "$pkg"
    done

    echo "Установка завершена."
}

# Проверяем аргументы командной строки
if [[ $1 == "update" ]]; then
    update_system
else
    echo "Используйте: $0 update для обновления системы и установки пакетов."
    exit 1
fi