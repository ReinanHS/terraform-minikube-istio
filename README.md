<div align="center">

 <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/Istio-bluelogo-nobackground-unframed.svg/512px-Istio-bluelogo-nobackground-unframed.svg.png" alt="Logo do Istio" width="15%" />

 
 # Terraform with Istio
 
</div>

Os arquivos neste repositório constituem o esqueleto (modelo) para iniciar experimentos com o Terraform, aproveitando os provedores do Kubernetes e Helm. Além disso, o propósito deste repositório é facilitar a configuração de um ambiente destinado ao desenvolvimento de um service mesh com o uso do Istio.

## Requisitos

Antes de começar, certifique-se de que você tenha os seguintes requisitos instalados:

- Docker: Siga as etapas mencionadas na documentação oficial para [instalar o Docker](https://docs.docker.com/get-docker/).

- Minikube: Siga as etapas mencionadas na documentação oficial para [instalar o Minikube](https://minikube.sigs.k8s.io/docs/start/).

- CLI do Terraform: Siga as etapas mencionadas na documentação oficial para [instalar a CLI do Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

## Etapas

Aqui estão as principais etapas para iniciar e realizar experimentos com as configurações no Kubernetes usando Terraform e Helm:

### Passo 1: Iniciar o Cluster Minikube

Use o seguinte comando para iniciar o cluster Minikube localmente:

```shell
minikube start
```

### Etapa 2: Código no Terraform

O código Terraform usado nesta demonstração está organizado em vários arquivos para seguir as melhores práticas:

- `providers.tf`: Este arquivo contém detalhes sobre os módulos do provedor HashiCorp Terraform que usaremos. Você pode personalizar os provedores necessários aqui.
- `versions.tf`: Este arquivo controla as versões específicas do Terraform e de outros módulos que estamos utilizando.
- `variables.tf`: Aqui, estão definidas as variáveis necessárias para configurar e personalizar o ambiente de infraestrutura.
- `modules.tf`: Aqui, estão definidas as variáveis necessárias para configurar e personalizar o ambiente de infraestrutura.

Abaixo, destacamos os principais módulos que estão sendo utilizados:

- **Istio**: Este módulo é responsável pela configuração do Istio, um popular service mesh para gerenciar o tráfego de rede entre os serviços.
- **Jaeger**: O módulo Jaeger é usado para configurar uma plataforma de rastreamento de solicitações e monitoramento.
- **Prometheus**: O módulo Prometheus é utilizado para configurar um sistema de monitoramento e alerta que ajuda a coletar métricas e dados sobre os serviços em execução.

### Etapa 3: Executar o código do Terraform para criar recursos

Nesta etapa, estaremos executando os seguintes comandos Terraform para criar os recursos no cluster Minikube:

```shell
terraform init
terraform plan
terraform apply
```

> Atenção: lembre-se de definir a variável `manifest_run` na primeira execução com o valor de `false`. Após a segunda execução você deve definir o valor dessa variável para `true`.

### Etapa 4: Verificar os recursos no Kubernetes

Após a execução bem-sucedida do código Terraform, você pode verificar os recursos criados no Kubernetes usando os comandos Kubernetes padrão, como `kubectl get pods`, `kubectl get services`.

### Etapa 5: Limpar recursos de demonstração

Quando você terminar seus experimentos e quiser limpar os recursos implantados, você pode executar o seguinte comando Terraform:

```shell
terraform destroy
```

Isso removerá todos os recursos criados na etapa 3. Lembre-se de personalizar e adaptar os arquivos Terraform de acordo com seus requisitos específicos antes de executar as etapas acima.

## Changelog

Por favor, veja [CHANGELOG](CHANGELOG.md) para obter mais informações sobre o que mudou recentemente.

## Seja um dos contribuidores

Sinta-se à vontade para contribuir com melhorias, correções de bugs ou adicionar recursos a este repositório. Basta criar um fork do projeto, fazer as alterações e enviar um pull request. Suas contribuições serão bem-vindas!

Quer fazer parte desse projeto? leia [como contribuir](CONTRIBUTING.md).

## Licença

Este projeto é licenciado sob a Licença MIT. Veja o arquivo [LICENÇA](LICENSE) para mais detalhes.