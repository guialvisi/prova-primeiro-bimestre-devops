# Relatório do Processo — Prova do Primeiro Bimestre de DevOps

**Aluno:** Guilherme Alvisi  
**Ferramenta de IA utilizada:** ChatGPT CodeX  
**Projeto:** API de Reservas  
**Tecnologias:** Git, GitHub, Node.js, Express, PostgreSQL, Docker, Docker Compose, Terraform e AWS

---

## Questão 1 — A Jornada Completa (Aulas 01 a 07)

O desenvolvimento da API de Reservas foi realizado de forma incremental, conectando os
conteúdos estudados durante o bimestre. O primeiro passo foi organizar o projeto utilizando
Git e GitHub, criando uma branch de feature para desenvolver a API sem trabalhar diretamente
na branch principal. Também foram realizados commits durante a evolução do projeto,
permitindo registrar as diferentes etapas da implementação.

Na Aula 01, o foco principal foi a containerização. A API foi desenvolvida utilizando
Node.js e Express e recebeu um Dockerfile para permitir sua execução dentro de um container.
Também foi criado um arquivo .dockerignore para impedir que arquivos desnecessários fossem
enviados para o contexto de build. O funcionamento foi validado executando a imagem e
testando a aplicação.

Na Aula 02, foi utilizado Docker Compose para executar a API juntamente com um banco de
dados PostgreSQL. O docker-compose.yml permitiu criar os dois serviços com um único comando.
Também foi configurado um volume nomeado para persistência dos dados, uma rede bridge
customizada, healthcheck para o PostgreSQL e depends_on para fazer a API aguardar o banco
estar disponível.

A aplicação possui um CRUD de reservas com as operações POST, GET, GET por ID, PUT e DELETE,
além da rota /health. Diferentemente de uma implementação apenas em memória, as informações
das reservas foram armazenadas no PostgreSQL, permitindo testar uma arquitetura mais próxima
de um ambiente real.

Nas aulas seguintes, o projeto passou para infraestrutura como código utilizando Terraform.
A infraestrutura foi dividida em módulos para VPC, Security Groups, EC2 e RDS. Essa
separação tornou o código mais organizado, reutilizável e mais fácil de validar. Os outputs
de um módulo foram utilizados como inputs de outros módulos, criando a composição necessária
entre os recursos.

Na AWS foi criada uma VPC com subnets públicas e privadas distribuídas em duas Availability
Zones. A instância EC2 foi posicionada em uma subnet pública, enquanto o PostgreSQL do
Amazon RDS foi colocado nas subnets privadas. Os Security Groups foram configurados para
permitir somente os acessos necessários entre os componentes.

Também foi trabalhado o conceito de Remote State, utilizando Amazon S3 para armazenamento
do estado do Terraform e DynamoDB para locking. O bucket foi configurado com versionamento
e criptografia. Por fim, o Terraform foi validado utilizando terraform fmt,
terraform validate e terraform plan antes do provisionamento. Assim, a evolução do projeto
seguiu uma sequência lógica: versionamento, aplicação, containers, composição de serviços,
infraestrutura como código, modularização, cloud e utilização de IA como apoio ao processo.

---

## Questão 2 — O Processo com IA como Copiloto

A ferramenta de Inteligência Artificial utilizada durante o projeto foi o ChatGPT. A IA
foi utilizada como copiloto durante diferentes etapas do desenvolvimento, principalmente
para auxiliar na criação, revisão e correção das configurações de Docker, Docker Compose
e Terraform. Não foi utilizado o Kiro Spec, pois o enunciado permitia utilizar outra LLM.

Um dos principais usos da IA aconteceu durante a configuração do Dockerfile e do
docker-compose.yml. Foram fornecidos requisitos como utilização de PostgreSQL, persistência
dos dados, healthcheck e comunicação entre os containers. A IA ajudou a sugerir estruturas
para esses arquivos, que posteriormente foram executadas e testadas no ambiente local.

Na etapa do Terraform, os prompts foram mais específicos. Foram informados requisitos como
criação de VPC, duas subnets públicas, duas privadas, Security Groups, EC2 t2.micro,
RDS PostgreSQL db.t3.micro, módulos Terraform e as limitações existentes no AWS Academy
Learner Lab. A IA auxiliou na estruturação dos módulos vpc, security-group, ec2 e rds e na
composição dos outputs e inputs entre eles.

A IA também foi utilizada principalmente para diagnóstico de erros. Durante o projeto
ocorreram problemas como atributos de módulos não encontrados, variáveis não declaradas,
blocos duplicados, argumentos não suportados e erros relacionados às permissões do
AWS Academy. As mensagens apresentadas pelo terminal eram analisadas e, a partir delas,
eram propostas correções que depois eram aplicadas e novamente validadas.

Nem todas as sugestões puderam ser utilizadas diretamente. Um exemplo importante ocorreu
na configuração do S3 para o Remote State, quando as políticas do Learner Lab impediram
determinadas operações relacionadas ao bucket. Também foi necessário trabalhar com
credenciais temporárias do laboratório e respeitar as restrições de IAM existentes no
ambiente.

Comparando com um desenvolvimento totalmente manual, a IA economizou tempo principalmente
na identificação de erros e na geração de estruturas iniciais. Entretanto, ela também
exigiu atenção, pois uma sugestão tecnicamente válida para uma conta AWS convencional
poderia não funcionar no Learner Lab. Por isso, o código gerado nunca foi considerado
automaticamente correto: ele foi executado, analisado e corrigido conforme os resultados
obtidos no ambiente real.

---

## Questão 3 — Infraestrutura, Segurança e o Learner Lab

A infraestrutura AWS foi projetada utilizando Terraform e dividida em módulos. A arquitetura
possui uma VPC contendo subnets públicas e privadas distribuídas entre duas Availability
Zones da região us-east-1. Essa organização permite separar os componentes que precisam
receber tráfego externo daqueles que devem permanecer protegidos dentro da rede.

A instância EC2 responsável pela API foi posicionada em uma subnet pública porque a porta
3000 precisa estar acessível para que seja possível consumir e testar a API. A infraestrutura
também considera acesso administrativo pela porta 22. O Security Group da EC2 foi criado
separadamente para controlar esse tráfego.

O Amazon RDS PostgreSQL foi colocado nas subnets privadas. O banco de dados não precisa
estar diretamente disponível na Internet, pois somente a aplicação executada na EC2 deve
se comunicar com ele. O RDS foi configurado com publicly_accessible igual a false e
storage_encrypted igual a true.

A porta 5432 do PostgreSQL não foi liberada para toda a Internet. O Security Group do RDS
permite o tráfego nessa porta somente quando a origem é o Security Group da EC2. Dessa
forma, mesmo que alguém conheça o endpoint do banco, não consegue estabelecer uma conexão
diretamente pela Internet.

A utilização de duas subnets privadas em Availability Zones diferentes também é necessária
para o DB Subnet Group utilizado pelo RDS. Dessa maneira, o banco permanece dentro da parte
privada da VPC e a arquitetura fica preparada de forma mais adequada para os recursos
gerenciados da AWS.

O AWS Academy Learner Lab exigiu algumas adaptações. Em vez de criar usuários, grupos ou
roles IAM próprios, foram utilizados os recursos disponibilizados pelo laboratório, como
LabRole e LabInstanceProfile quando necessário. Isso é importante porque a conta do
Learner Lab possui políticas e permissões controladas pela AWS Academy.

Outro ponto importante foi a autenticação. As credenciais fornecidas pelo Learner Lab são
temporárias e incluem Access Key, Secret Access Key e Session Token. Durante o desenvolvimento
foi necessário atualizar essas credenciais e validar o acesso utilizando o AWS CLI.
A região utilizada foi us-east-1, conforme especificado no projeto.

Também foram encontradas restrições de permissões no S3. Durante a criação do Remote State,
uma operação relacionada à configuração de Object Lock retornou AccessDenied por uma
Service Control Policy do ambiente. Esse problema mostrou na prática que o Learner Lab
não possui as mesmas permissões de uma conta administrativa comum e que a infraestrutura
precisou ser adaptada às permissões disponíveis.

---

## Questão 4 — Validação e Responsabilidade

Antes de executar terraform apply, foi realizado um processo de validação para diminuir
o risco de criar recursos incorretos ou inseguros. O primeiro passo foi utilizar
terraform fmt -recursive para padronizar a formatação dos arquivos Terraform. Depois foi
executado terraform validate para verificar erros de sintaxe, referências e configurações.

Em seguida, foi utilizado terraform plan. Essa etapa foi importante porque permitiu
visualizar antecipadamente quais recursos seriam criados e verificar se a infraestrutura
correspondia aos requisitos da atividade. Durante o desenvolvimento, diversos erros foram
encontrados justamente antes do apply, evitando provisionamentos incorretos.

Também foram revisadas as configurações de segurança. Foi verificado que o RDS utilizava
subnets privadas, publicly_accessible = false e storage_encrypted = true. Além disso, a
regra da porta 5432 foi configurada para aceitar conexões somente do Security Group da EC2,
em vez de utilizar uma regra aberta para 0.0.0.0/0.

Na EC2 foram verificados o tipo de instância, subnet utilizada, Security Group e integração
com os recursos permitidos pelo Learner Lab. Os outputs do Terraform também foram utilizados
para verificar informações como IP público da EC2, endpoint do RDS e URL da API.

Depois do provisionamento, a validação não terminou no Terraform. A API foi testada através
de suas rotas, verificando a comunicação entre aplicação e banco de dados. Isso é importante
porque um terraform apply concluído com sucesso comprova a criação dos recursos, mas não
garante sozinho que a aplicação está funcionando corretamente.

Aceitar código produzido por IA sem revisão poderia gerar diversos problemas. Um Security
Group poderia deixar o PostgreSQL acessível pela Internet, uma instância poderia ser criada
em uma subnet incorreta, recursos mais caros poderiam ser provisionados ou configurações
incompatíveis com o Learner Lab poderiam causar falhas e desperdício de tempo e orçamento.

A evolução Git → Docker → Docker Compose → Terraform → Modules foi importante para utilizar
a IA com mais responsabilidade. O conhecimento das tecnologias permite avaliar se aquilo
que a IA está sugerindo faz sentido. Dessa forma, a IA funciona como ferramenta de apoio,
mas a responsabilidade pela arquitetura, segurança, testes e validação continua sendo do
desenvolvedor.

O principal aprendizado foi que a IA pode acelerar bastante o desenvolvimento, mas não
substitui o entendimento técnico. Quanto mais crítica é a etapa, principalmente quando
envolve infraestrutura e segurança, maior deve ser a revisão antes de executar qualquer
código gerado automaticamente.
