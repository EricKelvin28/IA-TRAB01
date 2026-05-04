# Planejamento no Mundo dos Blocos de Tamanho Variável
**Disciplina:** Inteligência Artificial - ICOMP/UFAM
**Autor:** [Teu Nome]

## 1. Descrição do Problema
O trabalho consiste em adaptar o clássico "Mundo dos Blocos" para um cenário onde os blocos possuem larguras diferentes (1, 2 ou 3 unidades) e a mesa é limitada por uma régua (0 a 6). 

## 2. Representação do Conhecimento
Diferente da lógica simbólica tradicional, implementámos uma **delimitação geométrica**:
- **Predicados:** `largura(Bloco, L)` e `no_chao(Bloco, X)`.
- **Colisão:** Um bloco só pode ser colocado na posição `X` se o intervalo `[X, X + Largura]` não sobrepuser nenhum outro bloco já existente na mesa.
- **Suporte:** O bloco `d` na Situação 1 requer dois apoios (`a` e `b`) devido à sua dimensão.

## 3. Análise da Situação 1 (S0 -> Sf1)
- **Estado Inicial ($S_0$):** Blocos C, A e B ocupam as posições 0 a 6. O bloco D está no topo.
- **Conflito de Espaço:** A soma das larguras (C=3, A=2, B=2, D=2) é **9**, enquanto a régua visual do PDF é de **7** unidades. 
- **Solução da IA:** O planejador identificou que para colocar o bloco D no chão, é necessário expandir a fronteira horizontal ou realizar movimentos laterais para compactar os blocos.

## 4. Como Executar
Utilizando o SWI-Prolog:
1. Carregue o arquivo: `[planejador].`
2. Execute a busca: `once((estado_inicial(S), resolver(S, Plano, F))).`
