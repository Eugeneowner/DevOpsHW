# Kubernetes HW 23 — Развёртывание NGINX в kind-кластере

Создать локальный кластер Kubernetes с помощью `kind`, запустить в нём Pod с `nginx`, настроить Service и получить доступ к веб-интерфейсу nginx через браузер на `localhost:30080`.

---

## Структура проекта

KUBERNETES HW 23/
├── .gitignore
├── Screen/              # возможно для скриншотов результата
└── src/
    ├── cluster.yml
    ├── nginx-pod.yml
    └── nginx-service.yml


    ---

## Команды:

### 1. Создание кластера
kind create cluster --config src/cluster.yml

### 2. Запуск pod и сервиса
kubectl apply -f src/nginx-pod.yml
kubectl apply -f src/nginx-service.yml

### 3. Проверка статуса
kubectl get pods -o wide
kubectl get svc nginx-service

### 4. Доступ к nginx
	•	Через браузер: http://localhost:30080
	•	curl http://localhost:30080
    
### 5. Удаление кластера
kind delete cluster --name cluster