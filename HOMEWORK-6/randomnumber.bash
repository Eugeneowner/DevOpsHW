#!/bin/bash

# Random number generator from 1 to 100
target=$(( RANDOM % 100 + 1 ))
attempts=0
max_attempts=5

echo "Я згенерував випадкове число від 1 до 100. Спробуйте його вгадати!"
echo "У вас є $max_attempts спроб."

while [[ $attempts -lt $max_attempts ]]; do
    ((attempts++))
    echo -n "Спроба $attempts: Введіть ваше припущення: "
    read guess
    if ! [[ $guess =~ ^[0-9]+$ ]]; then
        echo "Будь ласка, введіть дійсне число."
        ((attempts--)) 
        continue
    fi
    if [[ $guess -eq $target ]]; then
        echo "Вітаємо! Ви вгадали правильне число!"
        exit 0
    elif [[ $guess -lt $target ]]; then
        echo "Ваше число занадто маленьке!"
    else
        echo "Ваше число занадто велике!"
    fi
done
echo "Вибачте, у вас закінчилися спроби. Правильним числом було $target."
exit 0
