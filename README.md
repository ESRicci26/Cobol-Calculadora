# Calculadora COBOL

Uma calculadora desenvolvida em COBOL que oferece funcionalidades para operações matemáticas básicas e avaliação de expressões complexas.

## 📋 Índice

- [Sobre o Projeto](#sobre-o-projeto)
- [Funcionalidades](#funcionalidades)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Como Usar](#como-usar)
- [Configuração para Execução Fora da IDE](#configuração-para-execução-fora-da-ide)
- [Exemplos de Uso](#exemplos-de-uso)
- [Estrutura do Código](#estrutura-do-código)
- [Contribuição](#contribuição)
- [Licença](#licença)

## 🎯 Sobre o Projeto

Este projeto é uma implementação de uma calculadora em linguagem COBOL, desenvolvida para demonstrar conceitos fundamentais da linguagem como estruturas de dados, processamento de expressões matemáticas e interface com o usuário via terminal.

A calculadora foi originalmente baseada em uma versão Java Swing e adaptada para COBOL, mantendo as principais funcionalidades de cálculo.

## ✨ Funcionalidades

- **Operações Básicas**: Adição (+), Subtração (-), Multiplicação (*), Divisão (/)
- **Operações Simples**: Cálculo direto entre dois números
- **Expressões Complexas**: Avaliação de expressões matemáticas com múltiplas operações
- **Precedência de Operadores**: Respeita a ordem matemática (*, / antes de +, -)
- **Tratamento de Erros**: 
  - Divisão por zero
  - Operadores inválidos
  - Caracteres inválidos
  - Expressões mal formadas
- **Interface Interativa**: Menu em modo texto com opções claras

## 📋 Pré-requisitos

- **Sistema Operacional**: Windows (testado no Windows 10/11)
- **IDE**: OpenCobolIDE 4.7.6 ou superior
- **Compilador**: GnuCOBOL (incluído na IDE)

## 🔧 Instalação

### 1. Download da IDE OpenCobolIDE

Baixe a IDE OpenCobolIDE no link oficial:
```
https://launchpad.net/cobcide/+milestone/4.7.6
```

### 2. Instalação da IDE

1. Execute o instalador baixado
2. Siga as instruções de instalação
3. Mantenha as configurações padrão recomendadas

### 3. Clone ou Download do Projeto

```bash
git clone https://github.com/seu-usuario/calculadora-cobol.git
```

Ou baixe o arquivo ZIP e extraia para uma pasta de sua preferência.

## 🚀 Como Usar

### Compilação na IDE

1. Abra o OpenCobolIDE
2. Abra o arquivo `calculadora.cob`
3. Pressione `F8` ou vá em `Run > Run` para compilar e executar
4. Ou use `Ctrl+F8` para apenas compilar

### Execução

Após a compilação, o programa apresentará um menu com as seguintes opções:

```
=========================================
           CALCULADORA COBOL            
=========================================

1 - Operacao Simples (+ - * /)
2 - Expressao Matematica
3 - Sair

Escolha uma opcao:
```

#### Opção 1 - Operação Simples
Permite calcular operações entre dois números:
- Digite o primeiro número
- Digite o operador (+, -, *, /)
- Digite o segundo número
- Veja o resultado

#### Opção 2 - Expressão Matemática
Permite avaliar expressões complexas:
- Digite uma expressão como: `2+3*4-1`
- O programa calculará respeitando a precedência dos operadores
- Veja o resultado

## ⚙️ Configuração para Execução Fora da IDE

Para executar o arquivo `.exe` gerado fora do OpenCobolIDE, é necessário configurar o PATH do sistema para incluir as DLLs necessárias.

### Solução: Adicionar o caminho ao PATH do sistema

#### Passo 1: Encontre o diretório das DLLs
Localize onde estão as DLLs do OpenCobolIDE (geralmente em):
```
C:\Program Files\OpenCobolIDE\GnuCOBOL\bin
```
ou
```
C:\Program Files (x86)\OpenCobolIDE\GnuCOBOL\bin
```

#### Passo 2: Adicione ao PATH

1. Pressione `Windows + R`, digite `sysdm.cpl` e pressione Enter
2. Vá para a aba "**Avançado**"
3. Clique em "**Variáveis de Ambiente**"
4. Na seção "**Variáveis do sistema**", encontre e selecione "**Path**"
5. Clique em "**Editar**"
6. Clique em "**Novo**" e adicione o caminho completo para a pasta das DLLs
7. Exemplo: `C:\Program Files\OpenCobolIDE\GnuCOBOL\bin`
8. Clique em "**OK**" em todas as janelas para salvar

#### Passo 3: Teste a execução
1. Abra um novo Prompt de Comando
2. Navegue até a pasta onde está o `calculadora.exe`
3. Execute: `calculadora.exe`

## 💡 Exemplos de Uso

### Operação Simples
```
Escolha uma opcao: 1
Digite o primeiro numero: 15.5
Digite o operador (+, -, *, /): *
Digite o segundo numero: 2.5

Calculo: 15.50 * 2.50 = 38.75
```

### Expressão Matemática
```
Escolha uma opcao: 2
Digite a expressao (ex: 2+3*4-1): 10+2*5-3
Resultado: 17.00
```

### Tratamento de Erro
```
Escolha uma opcao: 1
Digite o primeiro numero: 10
Digite o operador (+, -, *, /): /
Digite o segundo numero: 0
ERRO: Nao e possivel dividir por zero!
```

## 🏗️ Estrutura do Código

```
calculadora.cob
├── IDENTIFICATION DIVISION     # Identificação do programa
├── ENVIRONMENT DIVISION        # Configuração do ambiente
├── DATA DIVISION              # Definição de variáveis
│   └── WORKING-STORAGE SECTION # Variáveis de trabalho
│       ├── Variáveis de controle
│       ├── Variáveis numéricas
│       ├── Pilhas para cálculos
│       └── Campos de formatação
└── PROCEDURE DIVISION         # Lógica do programa
    ├── MAIN-PROGRAM           # Programa principal
    ├── EXIBIR-CABECALHO      # Interface do usuário
    ├── EXIBIR-MENU           # Menu de opções
    ├── OPERACAO-SIMPLES      # Cálculos básicos
    ├── AVALIAR-EXPRESSAO-COMPLETA # Expressões complexas
    ├── PROCESSAR-EXPRESSAO    # Parser de expressões
    ├── Funções auxiliares     # Pilhas e precedência
    └── Tratamento de erros    # Validações
```

## 🔍 Algoritmos Implementados

### Avaliação de Expressões
O programa utiliza o algoritmo de **Shunting Yard** simplificado com duas pilhas:
- **Pilha de Números**: Armazena operandos
- **Pilha de Operadores**: Armazena operadores matemáticos

### Precedência de Operadores
- **Alta precedência**: `*` (multiplicação), `/` (divisão)
- **Baixa precedência**: `+` (adição), `-` (subtração)

## 🤝 Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### Ideias para Contribuições
- Suporte para parênteses em expressões
- Funções matemáticas avançadas (potência, raiz quadrada)
- Interface gráfica simples
- Histórico de cálculos
- Suporte para números negativos
- Validação mais robusta de entrada

## 🐛 Problemas Conhecidos

- O programa não suporta parênteses em expressões
- Números negativos devem ser tratados com cuidado
- A formatação de saída pode variar dependendo da implementação COBOL

## 📝 Notas Técnicas

- **Versão COBOL**: Compatível com GnuCOBOL 3.x
- **Codificação**: Os comentários estão em português para facilitar o aprendizado
- **Portabilidade**: Testado no Windows, pode necessitar ajustes em outros sistemas
- **Limitações numéricas**: Números com até 10 dígitos inteiros e 2 decimais

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

---

## 📞 Suporte

**Desenvolvido com 💙 em COBOL**
