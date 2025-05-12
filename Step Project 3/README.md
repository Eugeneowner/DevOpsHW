# Step Project 3 — Assignments

## SP 3 Задания

- ### 1. Set Up AWS Infrastructure with Terraform

- **Create S3 Bucket:**
  - Создайте S3-бакет для хранения Terraform state-файлов.

- **Define VPC and Networking:**
  - Используйте Terraform для создания Virtual Private Cloud (VPC) с:
    - одной публичной подсетью (для Jenkins master)
    - одной приватной подсетью (для Jenkins worker)
  - Настройте Internet Gateway и NAT Gateway.

- **Launch EC2 Instances:**
  - Добавьте ваш SSH-ключ для доступа к EC2 в публичной подсети.
  - Создайте Security Group с разрешением для SSH и HTTP.
  - Запустите:
    - On-demand EC2 instance для Jenkins master
    - Spot EC2 instance для Jenkins worker
  - Используйте `user-data` в Terraform для добавления публичного ключа.
  - Примените переменные и `output` для управления конфигурацией.

---

- ### 2. Set Up Jenkins Master with Ansible

- Напишите Ansible playbook для установки Jenkins на EC2-инстанс.
- Установите **nginx** и настройте его как **reverse proxy** для Jenkins через Ansible.

---

- ### 3. Set Up Jenkins

- Добавьте Jenkins worker к Jenkins master.
- Разверните тот же pipeline, что был в **Step Project 2**, и проверьте, работает ли он как ожидается.

---

- ### 4. Destroy all resources

- После завершения всех шагов удалите все созданные ресурсы с помощью `terraform destroy`.

---

> **💡 Примечание:** Весь код развёртывания (Terraform, Ansible, Jenkinsfile и т.д.) должен быть размещён в GitHub-репозитории.

---

- ## 📦 Формат сдачи:

1. Код создания S3 бакета
2. Код создания инфраструктуры
3. Скриншоты создания инфраструктуры (всё пошагово, как в задании)
4. Код Ansible playbook (YAML файл)
5. Код конфигурации nginx
6. Скриншоты всех ручных действий
7. Код Jenkins pipeline и скриншоты его выполнения
8. Скриншоты удаления всех ресурсов

---

## 🔧 Основные команды Terraform:

- **Инициализация проекта:**
  terraform init

- **Показывает, какие изменения будут применены:**
  terraform plan

- **Удаляет все ресурсы, описанные в конфигурации:**
  terraform destroy

- **Проверка синтаксиса и структуры конфигурации:**
  terraform validate

- **Форматирует код Terraform:**
  terraform fmt

- **Который вносит реальные изменения в инфраструктуру на основе твоих .tf файлов:**
  terraform apply

- **В терминале можно посмотреть структуру проекта (дерево каталогов и файлов) с помощью команды:**
  tree