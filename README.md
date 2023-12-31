## Descrição

O DBIP é um projeto que visa identificar através do IP a origem da requisição.

## Requisitos

- Docker >= 24
- Docker compose >= 2.3

## Configuração

Descomente o arquivo `.env.example` para `.env` e adicione seus valores as variáveis conforme preferir.

## Executando os containers

Ao executar o comando abaixo, os containers: api e mysql serão criados.

```bash
$ docker compose up
```

## DBIP
1 - Faça o download da base de dados [aqui](https://vturb-labs.s3.amazonaws.com/challenges/dbip.csv.gz).

2 - Faça o download do [DBeaver](https://dbeaver.io/download/).

3 - Conecte-se ao `mysql` usando o `DBeaver` e crie a tabela conforme instrução sql abaixo:

```
CREATE TABLE `dbip_lookup` (
  `addr_type` enum('ipv4','ipv6') NOT NULL,
  `ip_start` varbinary(16) NOT NULL,
  `ip_end` varbinary(16) NOT NULL,
  `continent` char(2) NOT NULL,
  `country` char(2) NOT NULL,
  `stateprov_code` varchar(15) DEFAULT NULL,
  `stateprov` varchar(80) NOT NULL,
  `district` varchar(80) NOT NULL,
  `city` varchar(80) NOT NULL,
  `zipcode` varchar(20) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `geoname_id` int(10) unsigned DEFAULT NULL,
  `timezone_offset` float NOT NULL,
  `timezone_name` varchar(64) NOT NULL,
  `weather_code` varchar(10) NOT NULL,
  `isp_name` varchar(128) NOT NULL,
  `as_number` int(10) unsigned DEFAULT NULL,
  `usage_type` enum('corporate','consumer','hosting') DEFAULT NULL,
  `connection_type` enum('dialup','isdn','cable','dsl','fttx','wireless') DEFAULT NULL,
  `organization_name` varchar(128) NOT NULL,
  PRIMARY KEY (`addr_type`,`ip_start`)
) DEFAULT CHARSET=utf8mb4;
```

5 - Importando a base de dados DBIP

```bash
$ docker cp ./local/do/arquivo/dbip.csv.gz dbip-phpsrc-app-1:/tmp
$ docker exec -it dbip-phpsrc-app-1 ./import.php -f "/tmp/dbip.csv.gz" -d full
```
