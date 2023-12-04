
# Controle de Estoque em Protheus

Este projeto consiste em um sistema de controle de estoque desenvolvido em Protheus, uma linguagem de programação específica para o ERP TOTVS Protheus. O sistema oferece funcionalidades para o cadastro, atualização, verificação e exclusão de produtos no estoque.

### Estrutura do Projeto

O código está organizado em duas funções principais: `MENU` e `MENUCAD`. 

#### 1. **`MENU`**

- **Objetivo:** Controlar o estoque, permitindo a inclusão, verificação e exclusão de produtos.

- **Funcionalidades:**
  - **Inclusão de Produtos:** Atualiza a quantidade em estoque.
  - **Verificação de Estoque:** Exibe informações do produto com base no código.
  - **Verificação de Estoque Mínimo:** Lista produtos abaixo da quantidade mínima.
  - **Cadastro de Produto:** Redireciona para a tela de cadastro (`U_MENUCAD`).
  - **Exclusão de Produto:** Remove um produto com base no código.

#### 2. **`MENUCAD`**

- **Objetivo:** Cadastrar novos produtos no estoque.

- **Campos:**
  - Código do Produto
  - Quantidade Atual
  - Descrição
  - Quantidade Mínima
  - Unidade de Medida
  - Armazém

- **Operações:**
  - **Salvar:** Executa a função `fsalvar` para salvar os dados no banco de dados.

### Funções Estáticas

- **`fsalvar(cCod, cQuantAT, cDesc, cQuantMIN, cUNID, cARMAZ)`**
  - Objetivo: Salvar dados do novo produto no banco de dados.

- **`fInclui(cCod, cQuantAT)`**
  - Objetivo: Atualizar a quantidade em estoque com base no código do produto.

- **`fVerifEs(cCod)`**
  - Objetivo: Verificar o estoque atual de um produto com base no código.

- **`fverifMin(cCod)`**
  - Objetivo: Verificar produtos abaixo da quantidade mínima.

- **`fcad()`**
  - Objetivo: Redirecionar para a tela de cadastro (`U_MENUCAD`).

- **`fExclCod(cCod)`**
  - Objetivo: Excluir um produto do estoque com base no código.

### Observações Importantes

- **Interface Gráfica:** Utiliza objetos gráficos da biblioteca MSDialog para criar interfaces de usuário.

- **Validação de Campos:** Garante a integridade dos dados com validações para campos vazios no momento do cadastro.

### Melhorias Futuras

- **Tratamento de Erros:** Implementar tratamento mais robusto de erros.

- **Interface Gráfica:** Aprimorar a interface para proporcionar melhor experiência do usuário.

- **Segurança:** Avaliar implementação de medidas de segurança para proteção dos dados.

- **Refatoração:** Avaliar oportunidades de refatoração para otimização e simplificação do código.

Este redmi fornece uma visão geral do projeto, destacando suas funcionalidades, estrutura e possíveis melhorias futuras.
