#!/bin/bash

# Функція для перевірки та встановлення пакету через apt
install_if_missing() {
    if ! command -v $1 &> /dev/null; then
        echo "$1 не знайдено. Встановлюємо..."
        sudo apt update
        sudo apt install -y $2
    else
        echo "$1 вже встановлений."
    fi
}

# 1. Docker
if ! command -v docker &> /dev/null; then
    echo "Встановлюємо Docker..."
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
        sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) \
      signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
    echo "Docker вже встановлений."
fi

# 2. Docker Compose (окрема утиліта)
if ! command -v docker-compose &> /dev/null; then
    echo "Встановлюємо Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
      -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo "Docker Compose вже встановлений."
fi

# 3. Python 3.9+
PYTHON_VERSION=$(python3 --version 2>/dev/null | awk '{print $2}')
REQUIRED_VERSION="3.9"

if [[ -z "$PYTHON_VERSION" || "$(printf '%s\n' "$REQUIRED_VERSION" "$PYTHON_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]]; then
    echo "Встановлюємо Python 3.9..."
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt update
    sudo apt install -y python3.9 python3.9-venv python3.9-dev
    sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
else
    echo "Python 3.9 або новіший вже встановлений."
fi

# 4. Django через pip
if ! python3 -m django --version &> /dev/null; then
    echo "Встановлюємо Django..."
    sudo apt install -y python3-pip
    pip3 install Django
else
    echo "Django вже встановлений."
fi

echo "✅ Усі необхідні інструменти встановлено або вже були встановлені."
