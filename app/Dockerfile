FROM python:3.11-slim-bullseye

# Переменные окружения для Python
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /usr/src/app

# Системные зависимости (минимум; добавьте при необходимости)
# build-essential и libpq-dev полезны, если psycopg2 или др. нативные пакеты
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Установим зависимости Python по requirements.txt
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Копируем весь код проекта
COPY . .

# Создадим непривилегированного пользователя
RUN useradd -m django && chown -R django:django /usr/src/app
USER django

# Порт, на котором слушает gunicorn
EXPOSE 8000

# ВАЖНО: DJANGO_SETTINGS_MODULE и другие env вы передаёте через Kubernetes ConfigMap!
# Поэтому здесь они не жёстко заданы.

# Запуск
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "config.wsgi:application"]
