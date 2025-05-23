# HomeWork AWS - 6

## Описание проекта

Данный проект разворачивает 2 EC2-инстанса в AWS с помощью **Terraform** и настраивает на них **Docker** и **Nginx** с помощью **Ansible**.

---

## Структура проекта

```
HomeWork AWS - 6/
├── README.md                         # ← Данный файл
├── Screen                            # ← Лог работы (Скриншоты)
├── src/
│   ├── ansible/
│   │   ├── inventory                 # ← Генерируется Terraform
│   │   ├── private.key               # ← Генерируется Terraform
│   │   └── playbook-docker-nginx.yml # ← Ansible Playbook
│   ├── inventory.tpl                 # ← Щаблон для ansible/inventory
│   ├── main.tf                       # ← Подключение модуля и resources
│   ├── outputs.tf                    # ← Публичные IP EC2
│   ├── providers.tf                  # ← AWS provider 
│   ├── terraform.tfvars              # ← Значения переменных
│   ├── variables.tf                  # ← Значения переменных
│   └── modules/
│       └── compute/
│           ├── ec2.tf                # ← EC2, SG, SSH
│           ├── outputs.tf            # ← Вывод IP и ключа
│           └── variables.tf          # ← Переменные модуля
```

---

## Шаги запуска

### 1. Инициализация Terraform

```bash
cd src
terraform init
```

### 2. Планирование и применение инфраструктуры

```bash
terraform plan
terraform apply
```

### 3. Проверка вывода

После `terraform apply` в `outputs` будут отображены публичные IP:

```
instance_public_ips = [
  "3.72.68.22",
  "35.159.139.83"
]
```

---

## Шаги настройки с Ansible

### 1. Перейти в директорию

```bash
cd src/ansible
```

### 2. Запустить playbook

```bash
ansible-playbook -i inventory playbook-docker-nginx.yml
```

---

## Проверка

### Подключение по SSH:

```bash
ssh -i private.key ec2-user@3.72.68.22
# или
ssh -i private.key ec2-user@35.159.139.83
```

### Проверка Nginx внутри:

```bash
docker-compose ps
```

### Проверка Nginx в браузере:

Открыть в браузере:

- http://3.72.68.22
- http://35.159.139.83

---

## Готово!
