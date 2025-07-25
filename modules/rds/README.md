# RDS Terraform Module

Цей модуль створює базу даних у AWS. Залежно від значення `use_aurora` буде піднято або окремий інстанс RDS, або Aurora‑кластер з одним writer‑інстансом. У будь-якому випадку створюється група підмереж, security group та parameter group з базовими параметрами.

## Приклад використання

```hcl
module "rds" {
  source = "./modules/rds"

  name       = "demo"
  db_name    = "demo"
  username   = "dbadmin"
  password   = "verysecret"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  use_aurora     = true
  engine         = "aurora-postgresql"
  engine_version = "15.3"
  instance_class = "db.t3.medium"
  multi_az       = false
}
```

## Змінні

| Змінна | Опис | Тип | Значення за замовчуванням |
|--------|------|-----|---------------------------|
| `name` | Базова назва ресурсів | `string` | `"db"` |
| `use_aurora` | `true` – створюється Aurora, `false` – звичайна RDS | `bool` | `false` |
| `engine` | Тип рушія БД (`postgres`, `mysql`, `aurora-postgresql`, `aurora-mysql`) | `string` | `"postgres"` |
| `engine_version` | Версія рушія | `string` | `"15.3"` |
| `instance_class` | Клас інстансу БД | `string` | `"db.t3.micro"` |
| `multi_az` | Увімкнути Multi‑AZ (лише для звичайної RDS) | `bool` | `false` |
| `db_name` | Назва початкової бази | `string` | `"exampledb"` |
| `username` | Користувач БД | `string` | `"admin"` |
| `password` | Пароль користувача | `string` | — |
| `vpc_id` | ID VPC для security group | `string` | — |
| `subnet_ids` | Список ID підмереж | `list(string)` | — |
| `port` | Порт БД | `number` | `5432` |

### Зміна типу БД

Щоб переключитися між Aurora та звичайною RDS, встановіть `use_aurora` у потрібне значення та вкажіть відповідні `engine`, `engine_version` і `instance_class`.