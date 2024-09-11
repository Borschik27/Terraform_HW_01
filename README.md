![image](https://github.com/user-attachments/assets/79f850d3-1bcc-4111-ae6e-950810b032fc)

Задание 1
1.3
"result": "9ZisODVyRV1e3941"
![image](https://github.com/user-attachments/assets/a2ebf736-9ceb-452d-bcdd-4ceadc037f54)

1.4
```
terraform validate
╷
│ Error: Missing name for resource
│
│   on main.tf line 24, in resource "docker_image":
│   24: resource "docker_image" {
│
│ All resource blocks must have 2 labels (type, name).
╵
╷
│ Error: Invalid resource name
│
│   on main.tf line 29, in resource "docker_container" "1nginx":
│   29: resource "docker_container" "1nginx" {
│
│ A name must start with a letter or underscore and may contain only letters, digits,
│ underscores, and dashes.
```
Ошибка заключается в том что в блоке ресурса отсутствует имя ресурса (в дальнейшем "docker_image" "nginx" "docker_container" "nginx")

```
docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
34dafd165ac1   39286ab8a5e1   "/docker-entrypoint.…"   18 seconds ago   Up 17 seconds   0.0.0.0:9090->80/tcp   example_9ZisODVyRV1e3941

terraform apply -auto-approve
docker_image.nginx: Refreshing state... [id=sha256:39286ab8a5e14aeaf5fdd6e2fac76e0c8d31a0c07224f0ee5e6be502f12e93f3nginx:latest]
random_password.random_string: Refreshing state... [id=none]
docker_container.nginx: Refreshing state... [id=cc15695b8c6b41cc044a068007dafe062329c0a5674483b9c08b9b39e9e7820a]
......
Plan: 1 to add, 0 to change, 1 to destroy.
docker_container.nginx: Destroying... [id=cc15695b8c6b41cc044a068007dafe062329c0a5674483b9c08b9b39e9e7820a]
docker_container.nginx: Destruction complete after 0s
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=1962ce7b5a0719335f502a7859b87baed17c392aa22457169463a3bce99ca68f]

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS
      NAMES
cc15695b8c6b   39286ab8a5e1   "/docker-entrypoint.…"   8 seconds ago   Up 7 seconds   0.0.0.0:9090->80/tcp   hello_world_9ZisODVyRV1e3941
```
terraform apply -auto-approve - Выполняет действие при выполнении изменений без запроса подтверждения

1.7
```
terraform destroy -auto-approve
docker_image.nginx: Refreshing state... [id=sha256:39286ab8a5e14aeaf5fdd6e2fac76e0c8d31a0c07224f0ee5e6be502f12e93f3nginx:latest]
random_password.random_string: Refreshing state... [id=none]
docker_container.nginx: Refreshing state... [id=1962ce7b5a0719335f502a7859b87baed17c392aa22457169463a3bce99ca68f]

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # docker_container.nginx will be destroyed
.......
Plan: 0 to add, 0 to change, 3 to destroy.
docker_container.nginx: Destroying... [id=1962ce7b5a0719335f502a7859b87baed17c392aa22457169463a3bce99ca68f]
docker_container.nginx: Destruction complete after 0s
docker_image.nginx: Destroying... [id=sha256:39286ab8a5e14aeaf5fdd6e2fac76e0c8d31a0c07224f0ee5e6be502f12e93f3nginx:latest]
random_password.random_string: Destroying... [id=none]
random_password.random_string: Destruction complete after 0s
docker_image.nginx: Destruction complete after 0s

Destroy complete! Resources: 3 destroyed.
sypchik@Mirror:/mnt/c/Users/Sypchik/Desktop/home work/terraform/answer-hw/clear/ter-homeworks/01/src$ d
ocker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
Вывод .tfstate
```
{
  "version": 4,
  "terraform_version": "1.9.5",
  "serial": 14,
  "lineage": "7fecf65c-0210-250a-3859-a98aa49e7722",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```
1.8
Удалению контейнера мешает флаг keep_locally = true
```
resource "docker_image" "nginx" {
  name = "nginx:latest"
  keep_locally = true
}
```
![Screenshot 2024-09-11 194754](https://github.com/user-attachments/assets/200c3734-05ae-4249-8dd6-32627155bab4)

Задача 2
Код представлен в репозитории
Виртуальная машина создавалась сразу в облаке 
```
sypchik@Mirror:~$ ssh ubuntu@84.201.134.224
ubuntu@fhm1o22373guf3t0l1o4:~$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                               NAMES
c73a07a97ae5   mysql:8   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   0.0.0.0:3306->3306/tcp, 33060/tcp   example_7sHdEJNCpFvfADXX
ubuntu@fhm1o22373guf3t0l1o4:~$ docker exec -it example_7sHdEJNCpFvfADXX bash
bash-5.1# mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.4.2 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> exit
Bye
bash-5.1# env
MYSQL_MAJOR=8.4
HOSTNAME=c73a07a97ae5
PWD=/
MYSQL_ROOT_PASSWORD=7sHdEJNCpFvfADXX
MYSQL_PASSWORD=#R3v8I+lZ76*a)Q=
MYSQL_USER=wordpress
HOME=/root
MYSQL_VERSION=8.4.2-1.el9
GOSU_VERSION=1.17
TERM=xterm
MYSQL_ROOT_HOST=127.0.0.1
SHLVL=1
MYSQL_DATABASE=wordpress
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
MYSQL_SHELL_VERSION=8.4.1-1.el9
_=/usr/bin/env
```
