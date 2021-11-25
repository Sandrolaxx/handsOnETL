# Hands-On ETL com PENTAHO PDI

## A Suíte Pentaho

O Pentaho é uma solução open source desenvolvida em Java, composta por um conjunto de ferramentas visuais para análise de dados. Capaz de combinar a integração de dados com o processamento analítico, o Pentaho acelera significativamente o processo de obtenção, transformação, carga, predição e análise de informações.

O Pentaho é customizável e possui uma interface amigável que ajuda os usuários a visualizar os dados, e permite que eles tomem decisões comerciais inteligentes. O Pentaho é projetado para assegurar que cada membro de sua equipe, desenvolvedores ou usuários conhecedores do negócio, possam facilmente converter dados em valor;

A suíte é composta por um conjunto de ferramentas e funcionalidades que podem ser usadas para os seguintes propósitos:

* Integrações de dados.
* Internet of Things.
* Business Analytics.
* Big Data.
* Cloud Analytics.
* Ad Hoc Analysis.
* On-line Analytical Processing (OLAP).
* Predictive Analysis.
* Ad Hoc Reporting.
* Performance Measurements.

---

## Download da ferramenta

```
https://sourceforge.net/projects/pentaho/files/latest/download
```

Windows:
* O PDI não requer instalação. Descompacte o arquivo em C:\Pentaho
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

Iremos subir uma instância local de postgres, há inúmeros tutoriais de como executar o postgres em sua máquina, mas prefiro a abordagem utilizando docker, abaixo deixo dois links de tutoriais de como executar uma instância do postgres, uma sem o docker e outra com:

Sem docker: https://www.devmedia.com.br/instalando-postgresql/23364
<br>Com docker: https://felixgilioli.medium.com/como-rodar-um-banco-de-dados-postgres-com-docker-6aecf67995e1

---

## O Spoon

Spoon é uma aplicação desktop que nos permitirá criar transformações, agendar e disparar Jobs, para executar e orquestrar tarefas de um ETL. No Spoon, fazemos todo o desenho do processo e os demais componentes do PDI executam as tarefas, conforme desenhados.

!["Pentaho Engine"](/images/on-image-pentaho-di-engine.svg) - Pentaho Engine

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

Passo-a-passo da instalação:

* Na primeira tela clique no botão "Add".
* Na próxima tela clique em Other Repositories".
* Selecionar "File Repository" e clique em Get Started.
* Adicionar um nome e uma localização para os arquivos e então clique em Finish.
* Aparcera a tela escrita "Congratulations!" e então clique em Finish.
* O Spoon será apresentado, agora conectado ao repositório local, onde armazenamos todos os ETLs que criarmos.

---

## Conceitos básicos do PDI

O PDI usa workflows desenhados em transformações no Spoon, para obter, transformar e carregar dados. Os fluxos de trabalho são criados arrastando e soltando steps, dentro de uma transformação. Figura 01.

!["Figura 01"](/images/figura01.jpg) - Figura 01

Os steps são unidos por hops, que são responsáveis por passar o fluxo de dados de um step para o próximo. Figura 02.

!["Figura 02"](/images/figura02.svg) - Figura 02

Quando a execução do fluxo ocorre com sucesso, cada step recebe um check verde.

---

## Transformações

Podemos dizer que uma transformação é uma rede de tarefas lógicas executadas por steps. No exemplo a seguir, apresentamos uma transformação que lê um arquivo csv simples, seleciona as colunas do arquivo e carrega os dados contidos nas colunas selecionadas, em uma tabela de banco de dados relacional.

A transformação no Spoon é, em essência, um gráfico que representa um conjunto lógico de configurações para extração, transformação e carga de dados, salvo em um arquivo de extensão .ktr, quando usamos um repositório local, ou no repositório de um Servidor Pentaho, ou em um repositório em tabelas de um banco de dados central. Figura 03.

!["Figura 03"](/images/figura03.svg) - Figura 03

---

## Steps

Steps são os blocos de construção de uma transformação. Existem mais de 140 steps disponíveis na aba Design do Pentaho PDI, para que você construa suas transformações.

Os steps são agrupados de acordo com a sua função. Por exemplo, entrada de dados, saída de dados, transformações, validações e assim por diante. Cada etapa de uma transformação deve ser projetada para executar uma tarefa específica, como ler os dados de um arquivo csv, depois selecionar os campos e, por fim, gravá-los em uma tabela de um banco de dados relacional. Figura 04.

!["Figura 04"](/images/figura04.svg) - Figura 04

---

## Hops

Os hops são representados como setas, criam caminhos que conectam step e, assim, permitem que dados passem de um step para outro.

O hop determina o fluxo de dados através dos steps e não necessariamente a sequência em que eles passam. Quando você executa uma transformação, cada step se inicia em uma thread própria, empurrando e passando dados.

A direção do fluxo de dados é indicada por uma seta. Para criar o hop, clique no step de origem, depois pressione <SHIFT> e arraste uma linha para o step de destino. Alternativamente, você pode criar o hop, pairando o mouse sobre um step, até aparecer o menu suspenso. Figura 05.

!["Figura 05"](/images/figura05.svg) - Figura 05

---

## Jobs

Os jobs agregam funcionalidades individuais para implementar um processo inteiro.

Exemplos de tarefas realizadas em um job incluem a execução de transformações para extração de dados sobre funcionários e departamentos de um banco relacional, depois, para desnormalização dos dados dentro da staging area, na sequência, para executar transformações nos dados e, como penúltimo passo, para a carga em uma tabela dimensional.

No final do processo, para a execução de um fluxo condicional, enviando um e-mail de OK, caso tudo dê certo, ou um log completo de erro, se uma das transformações falhar. Figura 06.

!["Figura 06"](/images/figura06.svg) - Figura 06

---

## Entries

As entradas de trabalho são peças individuais que fornecem uma ampla gama de funcionalidades, indo desde a execução de transformações até a obtenção de arquivos de um servidor Web.

---

## Job Hop

Além da ordem de execução, um hop também especifica a condição em que o próximo step será executado. Um job hop é apenas um fluxo de controle, por exemplo, se Ok envia e-mail de confirmação, e se NOK envia log de erro. Figura 07

!["Figura 07"](/images/figura07.svg) - Figura 07

---

## Estudo de Caso

Para exercitarmos os nossos conhecimentos, faremos um estudo de caso com o Pentaho e com a base de dados postgres que acabamos de popular, extraindo dados de um arquivo csv, de uma planilha Excel e de um DER, transformando-os em tabelas de uma Staging Area e carregando os dados em um modelo dimensional sobre vendas.

## O Cenário

Uma rede de unidades de lojas com departamentos, espalhadas em quatro regiões pelo país, cada loja possui diversos produtos disponíveis e face a crise, a gerência está preocupada em aumentar as vendas e maximizar o lucro. A rede de lojas se utiliza de promoções que ofertam descontos, publicadas divulgadas em panfletos, nos sistemas de som das lojas e nas rádios locais.

Saber o que está dando certo é muito importante, e nesse momento, deve ser potencializado. A questão mais crítica identificada nos tomadores de decisão foi um melhor entendimento das compras dos clientes. Sendo assim, o processo de negócio que será modelado é a transação de vendas, possibilitando a análise de quais produtos estão vendendo mais, em quais lojas, em períodos e em quais condições promocionais.

---

## Indicadores de Desempenho

1. Entender o comportamento de vendas por produto, cliente, loja, promoção, vendedor e datas relevantes para o negócio.

2. É necessário acompanhar a evolução do valor total de venda realizada em nível de loja, cidade, estado e região.

3. Compreender o perfil dos clientes que realizam as compras;

4. Quer-se avaliar ao longo do tempo, quais períodos do ano geram mais vendas.

5. Avaliar as vendas realizadas pelos funcionários, faixas de bonificação e relação com descontos concedidos.

6. Analisar a faixa etária dos clientes, os tipos de clientes e o perfil de compras por sexo.

---

## Fontes de Dados

O ETL para análise de vendas fará extração de três fontes distintas de dados:

* Dados das transações de vendas: Sistema legado OLTP de vendas, dados no SGBD postgres criado.

* Dados das promoções: Arquivo csv enviado pela empresa de marketing contratada. Nome do arquivo: promocoes.csv. Diretório: presente neste repositorio na pasta arquivosETL.

* Observações sobre as promoções: Planilha do excel enviada pelo departamento interno de qualidade. Nome do arquivo: promocoes_obs.xlsx. Diretório: presente neste repositorio na pasta arquivosETL.

---

## Ferramentas, Modelagem e Ambientes

* ETL:	Pentaho Data Integration (PDI)	pdi-ce-9.2.0.0-290
* DWH:	Kimball Star Schema
* Arquivos Fonte:	xlsx e csv
* Database Fonte:	DER SV - PostgreSQL
* Staging Area:	TABLES STG - PostgreSQL
* Database Alvo:	MD VENDAS - PostgreSQL
* OS:	Linux-Ubuntu

---

## Arquitetura e Abordagem

!["Figura 08"](/images/figura08.svg) - Figura 08 - Arquitetura e Abordagem

!["Figura 09"](/images/figura09.svg) - Figura 09 - ETL Vendas

## Abordagem

Criar tabelas na Staging Area e no Data Mart via script .sql;

Nomes das tabelas:
* No DER do sistema SV são precedidos por T_SV
* Copiadas na Staging serão procedidos por STG_T_SV
* Após transformadas na Staging serão procedidos, apenas por STG_
* No Modelo Dimensional são precedidos por DIM_VENDA_ ou FATO_

Obter dados dos arquivos csv e xlsx com Pentaho PDI, avaliar qualidade, gravar na Staging Area, juntar os dados e carregar na dimensão de promoções.

Obter dados do sistema SV com o Pentaho PDI, gravar na Staging Area, transformar os dados e carregar nas dimensões e fato correspondentes, sobre:
* Clientes;
* Produtos;
* Lojas;
* Vendedores;
* Promoção;
* Vendas;

O grão(nível de detalhe) sobre Vendas será o Item da Nota Fiscal.

A dimensão DATA será criada e carregada por script .sql próprio.

As dimensões receberão sempre cargas totais e a fato, cargas incrementais executadas pelo Pentaho PDI.

As rotinas de extração serão disparadas por jobs do Pentaho PDI, agendados para iniciar a partir das 01:00 da manhã depois que o jenkins rodou, após o término das rotinas contábeis e do backup da base da dados do sistema SV.

As rotinas de transformação de dados e carga serão processadas durante a madrugada pelo Pentaho PDI.

O Modelo Dimensional de vendas deve estar populado pelo Pentaho PDI e disponível para análise na área de apresentação do DW, até às 08:30 da manhã.

---

## DER do Sistema SV

!["Figura 10 - DER - SV"](/images/figura10.svg) - Figura 10 - DER - SV

---

## Modelagem Dimensional - Data Mart

!["Figura 11 - Modelagem Dimensional"](/images/figura11.svg) - Figura 11 - Modelagem Dimensional

---

## Tabelas na Staging Area para armazenamento dos dados

O primeiro estágio do ETL (Extract) será a cópia dos dados dos arquivos csv e xlsx.

Para tanto, criaremos as tabelas abaixo na Staging Area, com os atributos que comportem os dados vindos dos arquivos.

* STG_ARQ_PROMOCOES receberá os dados de promocoes.csv

* STG_ARQ_PROMOCOES_OBS receberá os dados de promocoes_obs.xlsx

!["Figura 12"](/images/figura12.svg) - Figura 12

---

## Tabelas na Staging Area para armazenar os dados de cópia do SV

O segundo estágio do ETL (Extract) será a cópia dos dados do DER do sistema SV.

Para tanto, criaremos as seguintes tabelas na Staging Area, com os mesmos atributos do DER, mas sem os relacionamentos.

* STG_T_SV_UNIDADE_MEDIDA
* STG_T_SV_PRODUTO
* STG_T_SV_NOTA_FISCAL
* STG_T_SV_ITEM_NOTA_FISCAL
* STG_T_SV_CLASSIFICACAO_FISCAL
* STG_T_SV_FUNCIONARIO
* STG_T_SV_CLIENTE
* STG_T_SV_TIPO_CLIENTE
* STG_T_SV_LOJA
* STG_T_SV_UF
* STG_T_SV_CIDADE
* STG_T_SV_LOGRADOURO
* STG_T_SV_ENDERECO

---

## Tabelas para receber transformações da Staging Area

O terceiro estágio do ETL (Transform) será a transformação (seleção, desnormalização, decodificação e concatenação) dos dados, preparando-os para carga nas dimensões e na tabela fato.

Para tanto, criaremos as tabelas abaixo na Staging Area, com os atributos físicos alinhados ao modelo dimensional.

!["Figura 13"](/images/figura13.svg) - Figura 13

STG_PRODUTO: Será criada para receber os dados da junção(desnormalização) entre as tabelas STG_T_SV_PRODUTO e STG_T_SV_PRODUTO;

STG_FUNCIONARIO: Receberá dados da tabela STG_T_SV_FUNCIONARIO;

STG_LOJA: Será criada para receber os dados da junção das tabelas STG_T_SV_LOJA e STG_T_SV_UF, STG_T_SV_CIDADE, SGT_T_SV_LOGRADOURO e STG_T_SV_ENDERECO;

STG_CLIENTE: Será criada para receber os dados da junção das tabelas STG_T_SV_CLIENTE e STG_T_SV_TIPO_CLIENTE;

STG_VENDA: Será criada para receber os dados da junção das tabelas STG_T_SV_NOTA_FISCAL, STG_T_SV_ITEM_NOTA_FISCAL e STG_T_SV_CLASSIFICACAO_FISCAL;

STG_PROMOCOES: Será criada para receber os dados da junção de STG_ARQ_PROMOCOES e STG_ARQ_PROMOCOES_OBS.

---

## Tabelas Modelos Dimensional e Cargas

O quarto estágio do ETL (Load) será a carga dos dados transformados na Staging, nas tabelas dimensões e na tabela fato na Área de Apresentação do DW.

!["Figura 14"](/images/figura14.svg) - Figura 14

Para tanto, criaremos as tabelas DIM e FATO, no Data Mart de Vendas:

* DIM_VENDA_PROMOCAO com carga a partir da tabela STG_PROMOCOES;
* DIM_VENDA_PRODUTO com carga a partir da tabela STG_PRODUTO;
* DIM_VENDA_LOJA com carga a partir da tabela STG_LOJA;
* DIM_VENDA_CLIENTE com carga a partir da tabela STG_CLIENTE;
* DIM_VENDA_VENDEDOR com carga a partir da tabela STG_FUNCIONARIO;
* DIM_VENDA_DATA com carga por rotina própria;
* FATO_VENDAS com carga a partir da tabela STG_VENDAS.

---

## Criando e carregando a base de dados do Sistema SV

A criação e a carga da base de dados de um sistema OLTP, origem comum dos dados de um DW, nem de longe faz parte do escopo de um projeto ETL. Os sistemas OLTP existem para armazenar dados do dia a dia de um negócio, geralmente processam enormes quantidades de operações CRUD realizadas pelos usuários.

Em nosso exemplo, o sistema SV é responsável por armazenar as informações sobre as vendas, por meio dos registros de Nota Fiscal, Item da Nota Fiscal e de todos os demais que são necessários para se registrar uma venda.

**Realizando a criação da base de dados:**
Utilizando uma ferramemnta como DBeaver(https://dbeaver.io/) podemos nos conectar na instância postegreSQL que criamos e criar uma base de dados de teste ou utilizar a default public, então vamos realizar a criação das tabelas do Sistema SV com base em nosso DER, podemos executar o script [queryCriacaoSistemaSV.sql](/arquivosETL/queryCriacaoSistemaSV.sql), que está presente em arquivosETL.

---

## Criando tabelas na Staging Area para cópia dos dados do Sistema SV e arquivos CSV e XLSX

Para criar as tabelas que receberão a extração dos dados do Sistema SV e dos arquivos CSV e XLSX, conecte-se no PostgreSQL utilizando o DBeaver e execute o seguinte script [queryCriacaoStagingArea.sql](/arquivosETL/queryCriacaoStagingArea.sql).