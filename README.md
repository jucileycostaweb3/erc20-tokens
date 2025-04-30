
# ✨ ERC20 Tokens com Foundry

Bem-vindo ao repositório **ERC20 Tokens**, um projeto desenvolvido por [@jucileycostaweb3](https://github.com/jucileycostaweb3) que explora a criação e o gerenciamento de tokens ERC20 utilizando o poderoso toolkit [Foundry](https://book.getfoundry.sh/). Este projeto serve como uma base sólida para desenvolvedores que desejam entender e implementar contratos inteligentes de tokens fungíveis na blockchain Ethereum.

## 🚀 Sobre o Projeto

Este repositório demonstra como construir e implantar contratos inteligentes que seguem o padrão ERC20, utilizando as ferramentas oferecidas pelo Foundry:

- **Forge**: Framework de testes Ethereum.
- **Cast**: Ferramenta para interagir com contratos inteligentes EVM.
- **Anvil**: Nó local Ethereum para desenvolvimento e testes.

## 🛠️ Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [Foundry](https://book.getfoundry.sh/getting-started/installation)  
- [Node.js](https://nodejs.org/)  
- [Git](https://git-scm.com/)

## 📦 Instalação

Clone o repositório e instale as dependências:

```bash
git clone https://github.com/jucileycostaweb3/erc20-tokens.git
cd erc20-tokens
forge install
```

## ⚙️ Uso

### Compilar os Contratos

```bash
forge build
```

### Formatar o Código

```bash
forge fmt
```

### Implantar na Rede Local

Inicie o nó local:

```bash
anvil
```

Em outro terminal, execute o script de implantação:

```bash
forge script script/deploy.local.s.sol:LocalScript --rpc-url $RPC_URL --account $MY_ACCOUNT --broadcast
```

## 📁 Estrutura do Projeto

- `src/`: Contém os contratos inteligentes escritos em Solidity.
- `script/`: Scripts para implantação dos contratos.
- `lib/`: Dependências externas utilizadas no projeto.
- `.github/workflows/`: Configurações de integração contínua.

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

## 📄 Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
