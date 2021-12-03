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

Os arquivos CSV e XLSX são respectivamente o [promocoes.csv](/arquivosETL/promocoes.csv) e o [promocoes_obs.xlsx](/arquivosETL/promocoes_obs.xlsx).

Para criar as tabelas que receberão a extração dos dados do Sistema SV e dos arquivos CSV e XLSX, conecte-se no PostgreSQL utilizando o DBeaver e execute o seguinte script [queryCriacaoStagingArea.sql](/arquivosETL/queryCriacaoStagingArea.sql).

---

## Criando as tabelas Dimensionais e Fato

O modelo dimensional receberá a carga dos dados, após as transformações do processo ETL. Em projetos de porte, a criação destas tabelas ocorre em servidores específicos para o DW. Em nosso estudo de caso, criaremos em nossa área do Oracle FIAP, onde a Staging Area foi criada. Conecte-se utilizando o SQL Developer e execute o script [queryCriacaoTabelasDimensionais.sql](/arquivosETL/queryCriacaoTabelasDimensionais.sql).

---

## Carregando a Dimensão Data

A dimensão Data é a única dimensão que possui carga própria. Ela é um grande calendário, com os detalhes de todos os dias de um determinado período. O script [queryCarregarDimensaoData.sql](/arquivosETL/queryCarregarDimensaoData.sql) popula a tabela com todos os dias, entre os anos de 2000 e 2020.

Através desta dimensão, os tomadores de decisão poderão filtrar as vendas por dia da semana, feriados, véspera de feriados, dias pós feriado, mês, bimestre, semestre, ano, entre outros.

---

## Criando as tabelas na Staging Area para armazenar transformações

Entre os dados extraídos das fontes e a carga nas dimensões e fato, em nosso estudo de caso, criaremos tabelas que receberão as transformações do terceiro estágio do ETL, seleções, desnormalizações, decodificações e concatenações dos dados são tarefas comuns dessa etapa, preparando-os para carga nas dimensões e na tabela fato.

Script de criação da tabela Stagin Area que vai armazenar as transformações é o [queryCriacaoStgTransformacao.sql](/arquivosETL/queryCriacaoStgTransformacao.sql).

---

## Estudo de Caso

Pentaho PDI - Extração de dados dos arquivos CSV E XLSX.

O primeiro estágio do ETL (Extract) será a extração dos dados dos arquivos csv e xlsx para gravação em tabelas na Staging Area.

* No Spoon, crie uma transformação

!["Figura 15"](/images/figura15.jpg) - Figura 15

* CTRL + S e salve com o nome de TRANS_EXTRACT_CSV.

!["Figura 16"](/images/figura16.jpg) - Figura 16

* Na aba Design \ input selecione, arraste e solte a transformação o step CSV file input.

!["Figura 17"](/images/figura17.jpg) - Figura 17

* De um duplo clique no step e configure-o. Nome, filename e delimitardor, no caso, nosso arquivo utiliza ';'. **Importante: deixar selecionado a opção de cabeçalhho (Header row present).**

!["Figura 18"](/images/figura18.jpg) - Figura 18

* Clique em Obtem campos e, em seguida, em Fechar. O PDI buscará os dados e fará sugestões do tipo de dados e tamanho.

!["Figura 19"](/images/figura19.jpg) - Figura 19

* Clique em Preview, depois OK para até 100 linhas e visualize para testar a extração. Clique em Fechar e retorne para a transformação.

!["Figura 20"](/images/figura20.jpg) - Figura 20

* Na aba Desing \ Transform selecione, arraste e solte na transformação o step Select values. Sempre use o filtro Steps, caso queira encontrar um componente mais rápido.

!["Figura 21"](/images/figura21.jpg) - Figura 21

* Crie um hop entre eles, clique no step CSV file input, depois mantenha pressionanda a tecla SHIFT e arraste um hop para o Select Values, selecione Main ouput of select.

!["Figura 22"](/images/figura22.jpg) - Figura 22

* Dê um duplo clique no Select values e acione o botão Get Fields to select. Os campos extraídos do CSV serão obtidos para serem mapeados. Clique em OK.

!["Figura 23"](/images/figura23.jpg) - Figura 23

* Na aba Desing \ Output selecione, arrase e solte o step Table output na transformação. Crie um hop entre o Select values e o Table output.

!["Figura 24"](/images/figura24.jpg) - Figura 24

* Na aba Desing \ Output selecione, arrase e solte o step Table output na transformação. Crie um hop entre o Select values e o Table output.

!["Figura 24"](/images/figura24.jpg) - Figura 24

* Dê um duplo clique no Table output e configure-o, altere o nome, selecione a conexão com o Postgres, clique em Navega... de Target table e selecione a tabela STG_ARQ_PROMOCOES, deixe um commit a cada 1000 linhas inseridas e trunque a tabela para apagar todos os dados, antes de qualquer insert.

!["Figura 25"](/images/figura25.jpg) - Figura 25

* Clique em Ok e novamente em OK.

!["Figura 26"](/images/figura26.jpg) - Figura 26

*  Dê um duplo clique, novamente, no Select values e acione o botão Edit Mapping, clique OK para continuar.

!["Figura 27"](/images/figura27.jpg) - Figura 27

*  Os campos extraídos do csv serão listados em Source Fields e as colunas da tabela de destino, em Target Fields. Cabe a nós selecionarmos os pares correspondentes e adicionar par por par.

!["Figura 28"](/images/figura28.jpg) - Figura 28

*  Selecionados os pares, clique em OK.

!["Figura 29"](/images/figura29.jpg) - Figura 29

*  Novamente em OK.

!["Figura 30"](/images/figura30.jpg) - Figura 30

*  Salve a transformação de extração csv e execute-a, selecione Log detalhado e clique em Run.

!["Figura 31"](/images/figura31.jpg) - Figura 31

*  Resultado positivo, o log é apresentado.

!["Figura 32"](/images/figura32.jpg) - Figura 32

*  As métricas quantitativas são apresentadas na aba Step Metrics, três linhas lidas e três escritas.

!["Figura 33"](/images/figura33.jpg) - Figura 33

*  As métricas em milissegundos por step são apresentadas na aba Metrics.

!["Figura 34"](/images/figura34.jpg) - Figura 34

*  Os dados podem ser vistos na aba Preview data.

!["Figura 35"](/images/figura35.jpg) - Figura 35

---

## Arquivos XLSX

* Crie uma transformação de nome TRANS_EXTRACT_XLSX. Na aba Design \ input selecione, arraste e solte o step Microsoft Excel Input. Faça o mesmo com um Select values e com um Table output. Crie os hops entre eles.

!["Figura 36"](/images/figura36.svg) - Figura 36

* Dê um duplo clique em Microsoft Excel Input e configure nome, selecione Excel 2007 XLSX, navegue até o arquivo em File or directory e clique em Add. O arquivo será adicionado em Selected files.

!["Figura 37"](/images/figura37.jpg) - Figura 37

* Na aba Sheets, clique em Get sheetname(s) e selecione OBS, ela será adicionada na coluna Sheet name. Só um OBS deve ficar na coluna.

!["Figura 38"](/images/figura38.jpg) - Figura 38

* Na aba Content, mantenha Header e marque Stop on empty row.

!["Figura 39"](/images/figura39.jpg) - Figura 39

* Na aba Fields, clique em Get Fields from header row... e as colunas de cabeçalho serão obtidas.

!["Figura 40"](/images/figura40.jpg) - Figura 40

* Clique em Preview rows e em Ok, para até 1000 linhas. Os dados do Excel serão exibidos para visualização e teste.

!["Figura 41"](/images/figura41.jpg) - Figura 41

* Configure o Table output (Nome, conexão, target table e truncate), conforme imagem.

!["Figura 42"](/images/figura42.jpg) - Figura 42

* No Select Values, clique em Get fields to select e, depois, faça o Edit Mapping, igual ao processo de mapeamento que fizemos na extração do csv.

!["Figura 43"](/images/figura43.jpg) - Figura 43

* Execute a transformação e, caso tudo tenha sido feito e configurado conforme as instruções, o log não trará erros e extração será feita com sucesso.

!["Figura 44"](/images/figura44.jpg) - Figura 44

---

## Pentaho PDI - Extração de dados da base SV para Staging

O segundo estágio do ETL (Extract) será a extração dos dados das tabelas do sistema SV para gravação em tabelas cópias na Staging Area. Esse processo geralmente é executado após todas as rotinas de negócio e backups, para não concorrer e degradar o ambiente de produção.

---

## Extração dos dados sobre cliente.

Crie uma nova transformação de nome TRANS_EXTRACT_CLIENTE, nosso objetivo será extrair os dados de Cliente e Tipo de Cliente para as tabelas correspondentes na Staging.

* Na transformação, inclua os steps Table input, Select values e Table output. Crie os hops entre eles. Dê um duplo clique no Table input, configure o nome e clique em Get SQL select statement (Aguarde enquanto Getting information from the database), depois selecione T_SV_Cliente e clique em OK).

!["Figura 45"](/images/figura45.jpg) - Figura 45

* Clique em Sim para incluir os nomes dos atributos na query, o comando SQL será gerado pelo PDI.

!["Figura 46"](/images/figura46.jpg) - Figura 46

* Clique em Preview e os dados extraídos da tabela serão apresentados.

!["Figura 47"](/images/figura47.jpg) - Figura 47

* Configure o Table output (Nome, conexão, target table e truncate), conforme imagem.

!["Figura 48"](/images/figura48.jpg) - Figura 48

* No Select Values, clique em Get fields to select e depois, faça o Edit Mapping, igual ao processo de mapeamento que fizemos nos arquivos, mas desta vez, como os atributos de ambas as tabelas possuem o mesmo nome, o PDI já trará todo o mapeamento feito. Cabe a nós, apenas conferir.

!["Figura 49"](/images/figura49.jpg) - Figura 49

* Execute a transformação e, novamente, caso tudo tenha sido feito e configurado conforme as instruções, o log não trará erros e a extração entre tabelas será realizada com sucesso.

!["Figura 50"](/images/figura50.jpg) - Figura 50

* Na transformação, inclua mais três steps para a extração de Tipo Cliente, um Table input, um Select values e outro Table output. Crie os hops entre eles.

!["Figura 51"](/images/figura51.svg) - Figura 51

* Configure o Table input e depois o Table output.

!["Figura 52"](/images/figura52.jpg) - Figura 52

* Por último, faça o Get Fields e o Edit Mapping, no Select values.

!["Figura 53"](/images/figura53.jpg) - Figura 53

* Execute a transformação, o log não trará erros e a aba Step Metrics apresentará a contagem de leitura e gravação dos dois fluxos da transformação.

!["Figura 54"](/images/figura54.jpg) - Figura 54

---

## Praticando a Extração de dados no PDI

Agora, que você já conhece o mecanismo de extração, seleção e gravação entre tabelas, crie as demais transformações para praticar e importar os dados necessários para as próximas etapas do ETL (Transform e Load).

* TRANS_EXTRACT_PRODUTO:<br/> T_SV_UNIDADE_MEDIDA para STG_T_SV_UNIDADE_MEDIDA <br/> T_SV_PRODUTO para STG_T_SV_PRODUTO

!["Figura 55"](/images/figura55.svg) - Figura 55

* TRANS_EXTRACT_NF:<br/> T_SV_NOTA_FISCAL para STG_T_SV_NOTA_FISCAL <br/> T_SV_ITEM_NOTA_FISCAL para STG_T_SV_ITEM_NOTA_FISCAL <br/> T_SV_CLASSIFICACAO_FISCAL para STG_T_SV_CLASSIFICACAO_FISCAL

!["Figura 56"](/images/figura56.svg) - Figura 56

* TRANS_EXTRACT_FUNCIONARIO:<br/> T_SV_FUNCIONARIO para STG_T_SV_FUNCIONARIO

!["Figura 57"](/images/figura57.svg) - Figura 57

* TRANS_EXTRACT_LOJA:<br/> T_SV_LOJA  para STG_T_SV_LOJA <br/> T_SV_UF  para STG_T_SV_UF <br/> T_SV_CIDADE para STG_T_SV_CIDADE <br/> T_SV_LOGRADOURO para STG_T_SV_LOGRADOURO <br/> T_SV_ENDERECO para STG_T_SV_ENDERECO

!["Figura 58"](/images/figura58.svg) - Figura 58

---

## Pentaho PDI - Transformação de dados na Staging

**Junções:** O objetivo desta etapa do ETL é implementar junções dentro da staging area, após a extração dos dados do sistema SV. A junções que implementaremos serão desnormalizações, muito comum em ETLs para preparar a carga em dimensões de modelos Estrela. A primeira desnormalização será empregada para facilitar as pesquisas que serão feitas no Data Mart através da dimensão Cliente.

---

## Transformação de Cliente

* Crie uma transformação chamada TRANS_TRANSFORM_CLIENTE, adicione um step Table Input. Em Lookup, arraste um Database lookup, depois um Select values e um Table Input. Crie os hops entre eles.

!["Figura 59"](/images/figura59.svg) - Figura 59

* Configure o Table Input para obter os dados da tabela STG_T_SV_CLIENTE.

!["Figura 60"](/images/figura60.jpg) - Figura 60

* Configure o Database lookup para obter os dados da tabela STG_T_SV_TIPO_CLIENTE. Clique em Obtem campos e deixe apenas o CD_TIPO (selecione as demais linhas e clique em Del) e, depois, clique em Obtem campos lookup, o resultado deve ficar conforme a Figura 61.

!["Figura 61"](/images/figura61.jpg) - Figura 61

* Duplo clique em Table output e configure-o, conforme a Figura 62.

!["Figura 62"](/images/figura62.jpg) - Figura 62

* O resultado do mapeamento será apresentado.

!["Figura 64"](/images/figura64.jpg) - Figura 64

* Execute a transformação, o log não trará erros e a aba Preview data apresentará os dados juntados pelo fluxo e armazenados na tabela STG_CLIENTE, sem uma linha de código.

!["Figura 65"](/images/figura65.jpg) - Figura 65

---

## Transformação de Produto

* A segunda junção será entre Produto e Unidade de Medida. Para implementá-la, crie uma transformação chamada TRANS_TRANSFORM_PRODUTO, adicione um step Table Input. Em Lookup, arraste um Database lookup para Unidade de Medida, depois um Select values e um Table Input. Renomeie os componentes e crie os hops entre eles.

!["Figura 66"](/images/figura66.svg) - Figura 66

* Configure o Table Input para obter os dados da tabela STG_T_SV_PRODUTO

!["Figura 67"](/images/figura67.jpg) - Figura 67

* Configure o Database lookup para obter os dados da tabela STG_T_SV_UNIDADE_MEDIDA. Clique em Obtem campos e deixe apenas o CD_UNIDADE_MEDIDA (selecione as demais linhas e clique em Del) e, depois, clique em Obtem campos lookup, o resultado deve ficar conforme a Figura 68.

!["Figura 68"](/images/figura68.jpg) - Figura 68

* Duplo clique em Table output e configure-o, conforme imagem. Para evitar erros na Transformação, configure Target table através do botão Navega...

!["Figura 69"](/images/figura69.jpg) - Figura 69

* Duplo clique em Select values e configure-o com Get Fields e Edit Mapping, conforme imagens. O campo CD_PRODUTO será associado duas vezes, uma com SK_PRODUTO e a segunda com NK_PRODUTO. Para que você possa fazer isso, desmarque as duas opções Hide assigned.

!["Figura 70.1"](/images/figura70.1.jpg) - Figura 70.1
!["Figura 70.2"](/images/figura70.2.jpg) - Figura 70.2

* O resultado do mapeamento será apresentado.

!["Figura 71"](/images/figura71.jpg) - Figura 71

* Execute a transformação, o log não trará erros e a aba Step Metrics apresentará a quantidade de linhas juntadas pelo fluxo e armazenadas na tabela STG_PRODUTO.

!["Figura 72"](/images/figura72.jpg) - Figura 72

---

## Transformação de Promoção

* A terceira junção será entre Promoções, vindas do arquivo csv e Observações de promoções, obtidas no arquivo xlsx. Para implementá-la, crie uma transformação chamada TRANS_TRANSFORM_PROMOCAO, adicione um step Table Input. Em Lookup, arraste um Database lookup, depois, um Select values e um Table Input. Renomeie os componentes e crie os hops entre eles.

!["Figura 73"](/images/figura73.svg) - Figura 73

* Configure o Table Input para obter os dados da tabela STG_ARQ_PROMOCOES.

!["Figura 74"](/images/figura74.jpg) - Figura 74

* Configure o Database lookup para obter os dados da tabela STG_ARQ_PROMOCOES_OBS. Clique em Obtem campos e deixe apenas o CD_PROMOCAO e, depois, clique em Obtem campos lookup, o resultado deve ficar conforme a Figura 75.

!["Figura 75"](/images/figura75.jpg) - Figura 75

* Duplo clique em Table output e configure-o, conforme imagem. Para evitar erros na Transformação, configure Target table através do botão Navega.

!["Figura 76"](/images/figura76.jpg) - Figura 76

* Duplo clique em Select values e configure-o com Get Fields e Edit Mapping, conforme a Figura 77.

!["Figura 77"](/images/figura77.jpg) - Figura 77

* O campo CD_PROMOCAO será associado duas vezes, uma com SK_PROMOCAO e a segunda com NK_PROMOCAO. **Lembre-se: para que você possa fazer isso, de desmarcar a opção Hide assigned.**

!["Figura 78"](/images/figura78.jpg) - Figura 78

* O resultado do mapeamento será apresentado.

!["Figura 79"](/images/figura79.jpg) - Figura 79

* Execute a transformação, o log não trará erros e a aba Step Metrics apresentará a quantidade de linhas juntadas pelo fluxo e armazenadas na tabela STG_PRODUTO.

!["Figura 80"](/images/figura80.jpg) - Figura 80

---

## Transformação de Loja

* A terceira junção será mais complexa. Em alguns casos, teremos de realizar a desnormalização envolvendo mais de duas tabelas. A transformação de Loja é um bom exemplo disso. Nesta transformação, faremos Lookups para Loja, Endereço, Logradouro, Cidade e UF.

!["Figura 81"](/images/figura81.svg) - Figura 81

* Crie uma transformação chamada TRANS_TRANSFORM_LOJA, adicione um step Table Input. Em Lookup, arraste um Database lookup para cada tabela (conforme a Figura 82), depois um Select values e um Table Input. Renomeie os componentes e crie os hops entre eles.

!["Figura 82"](/images/figura82.svg) - Figura 82

* Configure o Table input para obter os dados da tabela STG_T_SV_LOJA.

!["Figura 83"](/images/figura83.jpg) - Figura 83

* Configure o Database lookup para obter os dados da tabela STG_T_SV_ENDERECO. Clique em Obtem campos e deixe apenas o CD_ENDERECO (selecione as demais linhas e clique em Del) e, depois, clique em Obtem campos lookup e deixe todos os campos obtidos, o resultado deve ficar conforme a Figura 84.

!["Figura 84"](/images/figura84.jpg) - Figura 84

* Configure o Database lookup para obter os dados da tabela STG_T_SV_LOGRADOURO. Clique em Obtem campos e deixe apenas o CD_LOGRADOURO (selecione as demais linhas e clique em Del) e, depois, clique em Obtem campos lookup e deixe todos os campos obtidos, o resultado deve ficar conforme a Figura 85.

!["Figura 85"](/images/figura85.jpg) - Figura 85

* Configure o Database lookup para obter os dados da tabela STG_T_SV_CIDADE. Clique em Obtem campos e deixe apenas o CD_CIDADE e depois, clique em Obtem campos lookup e deixe todos os campos obtidos, o resultado deve ficar conforme a Figura 86.

!["Figura 86"](/images/figura86.jpg) - Figura 86

* Configure o Database lookup para obter os dados da tabela STG_T_SV_UF. Clique em Obtem campos e deixe apenas o CD_UF e, depois, clique em Obtem campos lookup e deixe todos os campos obtidos, o resultado deve ficar conforme a Figura 87.

!["Figura 87"](/images/figura87.jpg) - Figura 87

* Duplo clique em Table output e configure-o, conforme a Figura 88. Para evitar erros na Transformação, configure Target table através do botão Navega... 

!["Figura 88"](/images/figura88.jpg) - Figura 88

* Duplo clique em Select values e configure-o com Get Fields e Edit Mapping, conforme imagens. Perceba que o Get Fields trouxe os campos de todos os Lookups.

!["Figura 89"](/images/figura89.jpg) - Figura 89

* O campo CD_LOJA será associado duas vezes, uma com SK_LOJA e a segunda com NK_LOJA, para que você possa fazer isso, desmarque as duas opções Hide assigned.

!["Figura 90"](/images/figura90.jpg) - Figura 90

* O resultado do mapeamento será apresentado.

!["Figura 91"](/images/figura91.jpg) - Figura 91

* Execute a transformação, o log não trará erros e a aba Preview Data apresentará os dados juntados pelo fluxo e armazenados na tabela STG_LOJA.

!["Figura 92"](/images/figura92.jpg) - Figura 92

---

## Transformação de Funcionário

Antes da carga dos dados de funcionários, na dimensão vendedor, precisamos transformá-los para disponibilizar melhores filtros aos usuários do nosso modelo estrela. A extração para a STG_SV_FUNCIONARIO trouxe um código que será de difícil entendimento para o usuário utilizar como filtro, o cd_faixa_bonificação.

Para o usuário do nosso dimensional fica complicado compreender o que representa um funcionário de código de bonificação 3, sendo assim, precisamos criar uma legenda que decodifique este campo e apresente uma descrição clara, conforme a regra de negócios da empresa. Com componentes do Pentaho, vamos criar uma decodificação para tratar essa necessidade.

Imagine que a área de negócio gostaria de ter um filtro com a descrição da bonificação com o código dela, algo do tipo: Faixa A – até 5.000 – 1 e Faixa B de 5001 até 10.000 – 2.

* Como podemos fazer essa concatenação no ETL com o PDI? Vamos lá! Crie uma transformação chamada TRANS_TRANSFORM_FUNCIONARIO. Adicione um Table input, da aba Transform, adicione os steps Value Mapper e Concat Fields, depois um Select values e por fim, um Table output.

!["Figura 93"](/images/figura93.jpg) - Figura 93

* Duplo clique em Table input e configure-o, conforme a Figura 94.

!["Figura 94"](/images/figura94.jpg) - Figura 94

* Duplo clique em Table input e configure-o, conforme a Figura 95.

!["Figura 95"](/images/figura95.jpg) - Figura 95

* Duplo clique em Table input e configure-o, conforme a Figura 96.

!["Figura 96"](/images/figura96.jpg) - Figura 96

* Duplo clique em Select values e configure-o com Get Fields e Edit Mapping, conforme a Figura 97.

!["Figura 97"](/images/figura97.jpg) - Figura 97

* Execute a transformação, o log não trará erros e a aba Preview data apresentará os dados juntados pela transformação e armazenados na tabela STG_FUNCIONARIO, sem uma linha de código.

!["Figura 98"](/images/figura98.jpg) - Figura 98

* Na aba Preview data podemos ver na coluna DS_FAIXA_BONIFICACAO o resultado de duas transformações muito comuns: a decodificação e a concatenação de valores.

!["Figura 99"](/images/figura99.jpg) - Figura 99

* Importante lembrarmos que, mais um tipo de transformação foi utilizado: a seleção, pois nem todos os atributos obtidos no Table Input foram gravados na tabela de destino. Veja na Figura 100.

!["Figura 100"](/images/figura100.jpg) - Figura 100

---

## Transformação de Vendas
