# Базовый образ Python
FROM python:3.13.1-slim-bullseye

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем файлы проекта в контейнер
COPY . .

# Устанавливаем зависимости
RUN python3 -m pip install --no-cache-dir -r requirements.txt

# Открываем порт 8000
EXPOSE 8000

# Запускаем Gunicorn с 4 воркерами и прослушиванием на 0.0.0.0:8000
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "main:app"]