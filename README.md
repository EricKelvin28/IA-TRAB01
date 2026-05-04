# Trabalho 1: Planejador Mundo dos Blocos (Dimensões Variáveis)
**Disciplina:** Inteligência Artificial - UFAM

## 1. Representação de Conhecimento
Para este problema, abandonamos a lógica clássica onde cada bloco ocupa 1 unidade. 
- Utilizamos `bloco(ID, Largura)` para definir a dimensão horizontal.
- A posição na mesa é definida por coordenadas `no_chao(Bloco, X_Inicio)`.
- O equilíbrio é calculado garantindo que a base do bloco superior não exceda os limites dos blocos inferiores.

## 2. Ações Definidas
- **Desempilhar Largo:** Remover um bloco que se apoia em dois (ex: Bloco D sobre A e B).
- **Mover Horizontal:** Deslocar um bloco pela régua (0-6) validando se o novo intervalo [X, X+Largura] está livre.

## 3. Comparação: Manual vs Automatizado
Na Situação 1, o plano manual revelou que a soma das larguras (9 unidades) excede o tamanho da mesa (7 unidades). 
O planejador automatizado identificou que para chegar em $S_{f1}$, é necessário que alguns blocos fiquem fora da régua visível ou sobrepostos, validando a restrição de espaço implementada.

## 4. Como Executar
1. Instale o SWI-Prolog.
2. Carregue o ficheiro: `consult('planejador.pl').`
3. Execute: `resolver(EstadoInicial, Plano, EstadoFinal).`
