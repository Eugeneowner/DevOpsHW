# Kubernetes HW 24 — Python + DockerHub + K8s Secrets

## Цель

Развернуть Python-приложение, возвращающее случайную строку, в локальном `kind`-кластере Kubernetes, используя приватный образ из DockerHub и `imagePullSecrets`. Проверить, что сервис маршрутизирует трафик к разным pod'ам.


---

## Структура проекта

<pre>
<code>
```
Kubernetes HW 24/
├── src/
│   ├── python-random.py        # Скрипт, возвращающий случайную строку
│   │── Dockerfile              # Образ для сборки
│   ├── deployment-hw24.yml     # K8s Deployment с imagePullSecrets
│   ├── service-hw24.yml        # K8s Service
│   ├── cluster.yml             # Kind cluster config
│── .gitignore
└── README.md
```
</code>
</pre>

## Команды:

### 1. Сборка и публикация образа
cd src/
docker build -t eugeneowner/hw24-app:latest .
docker push eugeneowner/hw24-app:latest

### 2. Запуск kind-кластера
kind create cluster --config cluster.yml
Проверка:
kubectl get nodes

### 3. Создание imagePullSecre
kubectl create secret docker-registry regcred \
  --docker-username=eugeneowner \
  --docker-password=ТВОЙ_ПАРОЛЬ_ИЛИ_TOKEN \
  --docker-email=ownereugene@gmail.com

### 4. Применение Deployment и Service
kubectl apply -f deployment-hw24.yml
kubectl apply -f service-hw24.yml

Проверка:

kubectl get pods
kubectl get svc python-random-service
    
### 5. Проверка сервиса
kubectl port-forward service/python-random-service 8080:80
curl http://localhost:8080

### 6. Узнать имена pod’ов
kubectl get pods -o wide

Пример:

kubectl port-forward pod/python-random-deployment-7897ddbb85-abcde 8081:8082
curl http://localhost:8081

kubectl port-forward pod/python-random-deployment-7897ddbb85-fghij 8082:8082
curl http://localhost:8082

### 7. Удаление кластера
kind delete cluster --name cluster