# Hands-On ETL com PENTAHO PDI

## Download da ferramenta

```
https://sourceforge.net/projects/pentaho/files/latest/download
```

Windows:
* O PDI não requer instalação. Descompacte o arquivo em C:\Pentaho
* Copie o arquivo ojdbc6.jar para pasta C:\Pentaho\data-integration\lib
* Rode o arquivo C:\Pentaho\data-integration\set-pentaho-env.bat para configurar as variáveis de ambiente.
* Rode o arquivo C:\Pentaho\data-integration\Spoon.bat para iniciar a ferramenta gráfica.
* O PDI requer o Java Runtime Environment - Oracle Java 8 instalado.
* Spoon será executado.

Linux:
* Para executar basta descompatar o arquivo, na pasta data-integration executar o comando abaixo:
```
sh spoon.sh
```
* Lembrando que ele executará somente se a máquina tiver o Java 8 instalado.

## O Spoon

Spoon é uma aplicação desktop que nos permitirá criar transformações, agendar e disparar Jobs, para executar e orquestrar tarefas de um ETL. No Spoon, fazemos todo o desenho do processo e os demais componentes do PDI executam as tarefas, conforme desenhados.

!["Pentaho Engine"](/images/on-image-pentaho-di-engine.svg)

Se a equipe que trabalhará nos ETLs precisar de um ambiente colaborativo, o uso de um Repositório Pentaho é recomendado. Além de armazenar e gerenciar os trabalhos e transformações em um servidor Pentaho, o repositório fornece histórico para que o time acompanhe as alterações, compare as revisões e reverta para versões anteriores, quando necessário.

Esses recursos, juntamente com segurança corporativa e bloqueio de conteúdo, fazem do Repositório Pentaho a plataforma mais sugerida para colaboração.

## Configurando um repositório

Como não precisamos atender requisitos de colaboração, podemos optar por criar um repositório em um banco de dados relacional central ou um repositório de arquivos local; em ambas as formas, conseguimos armazenar os metadados de nossos ETLs.

O Pentaho suporta o armazenamento dos seus artefatos nos seguintes bancos de dados:

* MySQL 5.6 & 5.7 (SQL 92).
* Oracle 11.2 & 12.1 (SQL 92).
* MS SQL Server 2014, 2016.
* PostgreSQL 9.5 & 9.6*.

Quando escolhemos um repositório de arquivos local, o Pentaho armazena as transformações criadas em arquivos .ktr e os jobs em arquivos .kjb.

Para facilitar os requisitos de instalação, vamos optar por um repositório de arquivos local. No canto direito do Spoon, em Connect, clique em Repository Manager.