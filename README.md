# infraestrutura

Repositório destinado para infraestrutura como código utilizando Terraform.

## Recursos Criados

Este workspace do Terraform irá criar os seguintes recursos na AWS:

- **VPC**: Uma Virtual Private Cloud com sub-redes dedicadas para API Gateway, banco de dados e EKS.
- **Sub-redes**: Três sub-redes para EKS, uma para API Gateway e uma para banco de dados.
- **EKS Cluster**: Um cluster Amazon EKS com configuração de grupos de nós, políticas de acesso e roles.
- **Security Group**: Grupo de segurança para o EKS permitindo tráfego HTTP e saída irrestrita.
- **Associação de Políticas de Acesso**: Permissões de acesso ao cluster EKS para roles e usuários especificados.

## Pré-requisitos

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configurado com credenciais válidas
- Permissões para criar recursos EKS, VPC, Subnets, Security Groups, IAM Roles e Policies

## Como executar

1. **Clone o repositório:**
   ```sh
   git clone <url-do-repositorio>
   cd infra
   ```
2. **Inicialize o Terraform:**
    ```sh
    terraform init
    ```

3. **Valide a configuração:**
    ```sh
    terraform validate
    ```

4. **Visualize o plano de execução:**
    ```sh
    terraform plan
    ```

5. **Aplique as mudanças para criar a infraestrutura:**
    ```sh
    terraform apply
    ```

## Estrutura dos Arquivos

- `main.tf`: Arquivo principal com definição dos recursos.
- `variables.tf`: Definição das variáveis de entrada.
- `outputs.tf`: Saídas dos recursos criados.
- `provider.tf`: Configuração do provedor AWS.

## Observações

- Certifique-se de que suas credenciais AWS estejam corretamente configuradas antes de executar os comandos.
- Para destruir todos os recursos criados, utilize:
  ```sh
  terraform destroy
  ```