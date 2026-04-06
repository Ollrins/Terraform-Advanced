# Terraform-Advanced
## Домашнее задание к занятию «Управляющие конструкции в коде Terraform»

### Задание 1
<p align="center">
  <img src="screenshots/S1-1.png" alt="скриншот консоли ВМ yandex cloud с метками" width="900"/>
  <br>
  <em>скриншот консоли ВМ yandex cloud с метками</em>
</p>
<p align="center">
  <img src="screenshots/S1-2.png" alt="скриншот подключения к консоли и вывод команды sudo nginx -t" width="900"/>
  <br>
  <em>скриншот подключения к консоли и вывод команды sudo nginx -t</em>
</p>
<p align="center">
  <img src="screenshots/S1-3-1.png" alt="terraform console вывод модуля" width="900"/>
  <br>
  <em>terraform console вывод модуля</em>
</p>
<p align="center">
  <img src="screenshots/S1-3-2.png" alt="terraform console вывод модуля - продолжение" width="900"/>
  <br>
  <em>terraform console вывод модуля - продолжение</em>
</p>

### Задание 2
<p align="center">
  <img src="screenshots/S2-2.png" alt="terraform console вывод модуля" width="800"/>
  <br>
  <em>terraform console вывод модуля</em>
</p> 

<p align="center">
  <img src="screenshots/S2-5.png" alt="документация к модулю с помощью terraform-docs" width="800"/>
  <br>
  <em>документация к модулю с помощью terraform-docs</em>
</p>

Код для заданий 1 и 2 https://github.com/Ollrins/Terraform-Advanced/tree/main/src1-2

### Задание 3
<p align="center">
  <img src="screenshots/S3-1.png" alt="список ресурсов в стейте,  удаление из стейта модулей  vpc и vm" width="800"/>
  <br>
  <em>список ресурсов в стейте,  удаление из стейта модулей  vpc и vm</em>
</p> 
<p align="center">
  <img src="screenshots/S3-2.png" alt="импортирт модуля  vpc" width="800"/>
  <br>
  <em>импортирт модуля  vpc</em>
</p> 
<p align="center">
  <img src="screenshots/S3-3.png" alt="импортирт модуля vm" width="800"/>
  <br>
  <em>импортирт модуля vm</em>
</p> 
<p align="center">
  <img src="screenshots/S3-4.png" alt="terraform plan" width="800"/>
  <br>
  <em>terraform plan</em>
</p> 

1. Просмотр текущего state
```bash
terraform state list
text
module.vpc_dev.yandex_vpc_network.dev-oll
module.vpc_dev.yandex_vpc_subnet.dev-oll
module.vpc_dev_b.yandex_vpc_network.dev-oll
module.vpc_dev_b.yandex_vpc_subnet.dev-oll
module.test-vm.yandex_compute_instance.vm[0]
module.test-vm.yandex_compute_instance.vm[1]
module.example-vm.yandex_compute_instance.vm[0]
```
2. Удаление модуля vpc из state
```bash
terraform state rm module.vpc_dev
terraform state rm module.vpc_dev_b
```
3. Удаление модуля vm из state
```bash
terraform state rm module.test-vm
terraform state rm module.example-vm
```
 Проверяем
```bash
terraform state list
```
4. Импорт ресурсов обратно
 4.1 Найдем ID ресурсов:
```bash
yc vpc network list
yc vpc subnet list
yc compute instance list
```
 4.2 Импортируем сети и подсети:
```bash
terraform import module.vpc_dev.yandex_vpc_network.dev-oll <network_id_develop_a>
terraform import module.vpc_dev_b.yandex_vpc_network.dev-oll <network_id_develop_b>
terraform import module.vpc_dev.yandex_vpc_subnet.dev-oll <subnet_id_develop_a>
terraform import module.vpc_dev_b.yandex_vpc_subnet.dev-oll <subnet_id_develop_b>
```
 4.3 Импортируем виртуальные машины:
```bash
terraform import 'module.test-vm.yandex_compute_instance.vm[0]' <vm_id_webs_0>
terraform import 'module.test-vm.yandex_compute_instance.vm[1]' <vm_id_webs_1>
terraform import 'module.example-vm.yandex_compute_instance.vm[0]' <vm_id_web_stage>
```
5. Проверка plan
   
### Задание 4
<p align="center">
  <img src="screenshots/S4.png" alt="модуль vpc для создания подсетей в трех зонах доступности, результат из консоли YC" width="800"/>
  <br>
  <em>модуль vpc для создания подсетей в трех зонах доступности, результат из консоли YC</em>
</p> 

Код для задания 4 https://github.com/Ollrins/Terraform-Advanced/tree/main/src4

### Задание 7
<p align="center">
  <img src="screenshots/S7.png" alt=" секрет с помощью terraform vault, вывод в output" width="800"/>
  <br>
  <em>секрет с помощью terraform vault, вывод в output</em>
</p> 

<p align="center">
  <img src="screenshots/S7-5.png" alt="новый секрет в vault с помощью terraform" width="800"/>
  <br>
  <em>новый секрет в vault с помощью terraform</em>
</p> 

Код для задания 7 https://github.com/Ollrins/Terraform-Advanced/tree/main/src7



Локальная установка Terraform провайдера Vault

Решение: Установка провайдера из исходного кода
1. Скачать исходный код провайдера
```bash
wget https://github.com/hashicorp/terraform-provider-vault/archive/refs/tags/v5.8.0.tar.gz
tar -xzf v5.8.0.tar.gz
cd terraform-provider-vault-5.8.0
```
2. Установить Go (если требуется более новая версия)
```bash
# Проверка текущей версии
go version

# Если версия ниже 1.26, установить новую
wget https://go.dev/dl/go1.26.0.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.26.0.linux-amd64.tar.gz
echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.```bashrc
source ~/.
```
3. Собрать провайдер из исходного кода
```bash
go build -o terraform-provider-vault
```
4. Создать правильную структуру директорий
```bash
# Создать директории для плагина
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/hashicorp/vault/5.8.0/linux_amd64

# Скопировать бинарник с правильным именем (без версии в конце)
cp terraform-provider-vault ~/.terraform.d/plugins/registry.terraform.io/hashicorp/vault/5.8.0/linux_amd64/terraform-provider-vault

# Сделать исполняемым
chmod +x ~/.terraform.d/plugins/registry.terraform.io/hashicorp/vault/5.8.0/linux_amd64/terraform-provider-vault
5. Создать конфигурационный файл Terraform
```bash
cat > main.tf << 'EOF'
terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "5.8.0"
    }
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "education"
}

data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data)
}
EOF
```
6. Инициализировать Terraform
```bash
terraform init -plugin-dir=/home/Ollrins/.terraform.d/plugins
```
