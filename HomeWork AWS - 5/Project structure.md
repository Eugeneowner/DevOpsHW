.
├── main.tf                    ✅ Root логика — подключение модуля
├── data.tf                    ✅ Data sources вынесены правильно
├── variables.tf               ✅ Переменные root-модуля
├── provider.tf                ✅ Провайдер и backend (S3 + MFA)
├── output.tf                  ✅ Вывод данных из модуля
├── Формат_здачі_ДЗ.txt        ✅ Требования по ДЗ
├── Project structure.md       ✅ Можно удалить или перенести в .github/docs
├── Screen                     ✅ Screenshots
│
├── modules/
│   ├── nginx_instance/
│   │   ├── main.tf            ✅ Модуль EC2 + SG
│   │   ├── outputs.tf         ✅ Public IP output
│   │   └── variables.tf       ✅ vpc_id, instance_type и др.
│   └── └── userdata.tpl       ✅ Правильный startup-скрипт

HW20:
1. Код з створенням модуля й всього необхідного для підняття інфраструктури
2. Скрін з підняттям інфраструктури
3. Скрін з EC2 й його IP
4. Cкрін з працюючим nginx
5. Скрін з змістом бакета, де ваш стейт файл