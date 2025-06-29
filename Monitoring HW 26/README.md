# Gathering logs with fluentd, send to Elasticsearch and visualize in Kibana

## Задание

1. Build docker image for nodejs app located here:
`https://gitlab.com/dan-it/groups/devops_soft/-/tree/main/Monitoring-2?ref_type=heads`.
2. Prepare docker-compose file and run EFK stack using it.
3. Run nodejs app in docker and configure it to send logs to EFK stack.
4. Make sure that you can see logs in Kibana

Формат здачі ДЗ:1. Код Dockerfile
2. Код docker-compose.yaml
3. Код файлів конфігурації
4. Скріни запуску й роботи EFK
5. Скріни роботи Kibana

## Цель

Развернуть на VPS стек логирования на базе `EFK` и запустить `Node.js` приложение в контейнере, настроив его на отправку логов в `Fluentd → Elasticsearch → визуализацию в Kibana`.

1. Install Docker and Docker Compose
2. Clone the Node.js app from GitLab and write Dockerfile
3. Create a docker-compose.yml with services:
   - elasticsearch
   - kibana
   - fluentd (with custom config and volume)
   - nodejs-app
4. Write Fluentd config to collect stdout logs from Node.js container
5. Make sure Elasticsearch and Kibana are up
6. Configure app container to log to Fluentd
7. Validate log flow — log in to Kibana and see logs from Node.js

---

## Структура проекта Node.js + EFK Stack Logging Setup

<pre>
<code>
```
📁 Структура проекта Logging HW 26/
/src
├── docker-compose.yml              # Главный docker-compose файл для EFK + Node.js
├── Dockerfile                      # Dockerfile для Node.js приложения
├── index.js                        # Основной сервер Express
├── logger.js                       # Winston логгер, отправляющий логи во Fluentd
├── package.json                    # Зависимости Node.js
├── fluentd/
│   ├── fluent.conf                 # Конфигурация Fluentd
│   └── Dockerfile                  # Dockerfile с установкой fluent-plugin-elasticsearch
│── .gitignore
└── README.md
```
</code>
</pre>

## Команды:

### Шаг 1. Установка Docker и Docker Compose (если не установлены)
apt update
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release git unzip

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io

# Docker Compose
curl -L "https://github.com/docker/compose/releases/download/v2.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

### Шаг 2. Подготовка проекта
1.Создай директорию:
mkdir -p /opt/node-efk-app && cd /opt/node-efk-app

2.Склонируй или скопируй содержимое Node.js приложения (index.js, logger.js, package.json).

3.Создай Dockerfile:
FROM node:18
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 10000
CMD ["npm", "start"]

4.Создай docker-compose.yml

5.Создай папку fluentd и добавь туда:

fluentd/Dockerfile

FROM fluent/fluentd:v1.16-1
USER root
RUN gem install fluent-plugin-elasticsearch --no-document
USER fluent

fluentd/Dockerfile

FROM fluent/fluentd:v1.16-1
USER root
RUN gem install fluent-plugin-elasticsearch --no-document
USER fluent

fluentd/fluent.conf
<source>
  @type forward
  port 24224
  bind 0.0.0.0
</source>

<match **>
  @type elasticsearch
  host elasticsearch
  port 9200
  logstash_format true
  logstash_prefix fluentd
  include_tag_key true
  type_name access_log
  flush_interval 5s
</match>

###  Шаг 3. docker-compose.yml
version: '3.7'

services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.17.10
    container_name: elasticsearch
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
      - bootstrap.memory_lock=true
      - ES_JAVA_OPTS=-Xms512m -Xmx512m
    ulimits:
      memlock:
        soft: -1
        hard: -1
    ports:
      - "9200:9200"
    networks:
      - efk

  kibana:
    image: docker.elastic.co/kibana/kibana:7.17.10
    container_name: kibana
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch
    networks:
      - efk

  fluentd:
    build: ./fluentd
    container_name: fluentd
    volumes:
      - ./fluentd:/fluentd
    command: fluentd -c /fluentd/fluent.conf -v
    ports:
      - "24224:24224"
      - "24224:24224/udp"
    networks:
      - efk

  node-app:
    build: .
    container_name: node-app
    depends_on:
      - fluentd
    ports:
      - "10000:10000"
    networks:
      - efk

networks:
  efk:

### Шаг 4. Логгер в Node.js (logger.js)

const winston = require('winston');
const fluentLogger = require('fluent-logger');

const fluent = fluentLogger.createFluentSender('js_app', {
  host: 'fluentd',
  port: 24224,
  timeout: 3.0
});

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.Console(),
    new winston.transports.Stream({
      stream: {
        write: (msg) => {
          const json = JSON.parse(msg);
          fluent.emit('winston', {
            level: json.level,
            message: json.message,
            path: json.path || null,
            timestamp: new Date().toISOString()
          });
        }
      }
    })
  ]
});

module.exports = logger;
    
###  Шаг 5. Запуск

docker-compose up -d --build

Проверь, что все контейнеры работают:

docker ps


### Шаг 6. Kibana


1.Зайди в Kibana: http://:5601

2.Создай Index Pattern: fluentd-*

3.Выбери поле времени: @timestamp

4.Перейди в Discover — убедись, что приходят логи

5.Создай визуализации через Visualize → Lens:

  - Логи по времени (timestamp)

  - Разбиение по level, message, path

Добавь их в Dashboard

### Полезные команды

curl http://localhost:10000/
curl http://localhost:10000/error

curl -X GET 'localhost:9200/_cat/indices?v'
curl -X GET 'localhost:9200/fluentd-*/_search?pretty'