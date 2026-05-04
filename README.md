# 🧠 Planejador de Mundo dos Blocos em Prolog

## 📌 Descrição

Este projeto implementa um **planejador automático** para o problema clássico do *Mundo dos Blocos*, utilizando a linguagem **Prolog**.

O sistema é capaz de encontrar uma sequência de ações que transforma um **estado inicial** em um **estado objetivo**, respeitando restrições físicas como:

* Não sobreposição de blocos
* Suporte válido (modelo do PDF – suporte parcial permitido)
* Movimentação apenas de blocos livres
* Limites do espaço de trabalho

---

## ⚙️ Modelo Utilizado

Cada bloco é representado por:

```
b(Nome, Inicio, Fim, Altura)
```

### Exemplo:

```
b(c,0,1,0)
```

Significa:

* Bloco `c`
* Ocupa posições de 0 a 1
* Está no nível do chão (altura 0)

---

## 📦 Tamanhos dos Blocos

| Bloco | Tamanho |
| ----- | ------- |
| a     | 1       |
| b     | 1       |
| c     | 2       |
| d     | 3       |

---

## 🌍 Estados

### 🔹 Estado Inicial (s0)

```
c ocupa 0–1 no chão
a ocupa 3
b ocupa 5
d ocupa 3–5 acima (altura 1)
```

---

### 🎯 Estado Objetivo (sf1)

```
d no chão (3–5)
a e b acima
c no topo
```

*(mantido exatamente como definido no enunciado)*

---

## 🔁 Ações

A única ação possível é:

```
move(Bloco, Origem, Destino)
```

### Exemplo:

```
move(c,0,4)
```

Significa:

* mover bloco `c`
* da posição 0
* para posição 4

---

## 🧩 Restrições Implementadas

✔ Bloco deve estar no topo (livre)
✔ Espaço destino deve estar livre
✔ Deve haver suporte abaixo (modelo do PDF)
✔ Movimento não pode ser redundante
✔ Estado não pode ser repetido

---

## 🔍 Algoritmo de Busca

Foi utilizada uma **busca em profundidade limitada (DFS com controle)**:

* Evita loops com lista de visitados
* Limita profundidade para evitar travamentos
* Considera apenas movimentos válidos

---

## ▶️ Como Executar

### 1. Abrir o Prolog

```bash
swipl
```

### 2. Carregar o arquivo

```prolog
consult('planner_final_estavel.pl').
```

### 3. Executar o planejador

```prolog
resolver(P).
```

---

## ✅ Saída Esperada

O sistema retorna um plano como:

```prolog
P = [move(c,0,4), move(a,3,4), move(b,5,5)]
```

---

## ⚠️ Observações Importantes

* O modelo segue o padrão do **PDF da disciplina**, permitindo suporte parcial.
* Estados não foram alterados.
* O sistema evita colisões e movimentos inválidos.
* A busca é controlada para evitar estouro de memória.

---

## 🚀 Possíveis Melhorias

* Implementação de busca A* (mais eficiente)
* Heurísticas baseadas na posição final dos blocos
* Interface gráfica para visualização
* Geração automática de estados válidos

---

## 👨‍💻 Autor

Projeto desenvolvido para fins acadêmicos em Inteligência Artificial / Planejamento.

---
