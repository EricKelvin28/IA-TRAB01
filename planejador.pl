% --- Definição dos Blocos e Larguras ---
bloco(a, 2).
bloco(b, 2).
bloco(c, 3).
bloco(d, 2).

% --- Verificação de Espaço e Empilhamento ---
% Verifica se há espaço na mesa (0 a 6) para um bloco de largura L na posição X
espaco_livre_mesa(X, Largura, Estado) :-
    X >= 0,
    X + Largura =< 7, % Limite da régua é 6 (índices 0,1,2,3,4,5,6)
    not(sobreposto(X, Largura, Estado)).

% Verifica se o bloco D pode ficar sobre A e B (Situação 1)
pode_empilhar(d, a, b) :- 
    bloco(a, La), bloco(b, Lb),
    % Lógica de suporte: o bloco de cima deve estar equilibrado
    true.

% --- Estados ---
% Estado Inicial Situação 1: c(0-2), a(3-4), b(5-6), d sobre a e b
estado_inicial([no_chao(c, 0), no_chao(a, 3), no_chao(b, 5), sobre(d, a, b)]).

% --- Ações do Planejador ---
% Mover bloco para o chão
acao(Estado, move(B, de_sobre(A,B2), para_chao(X)), NovoEstado) :-
    select(sobre(B, A, B2), Estado, Resto),
    espaco_livre_mesa(X, 2, Resto), % Exemplo simplificado
    append([no_chao(B, X)], Resto, NovoEstado).

% Mover bloco do chão para cima de outros
acao(Estado, move(B, de_chao(X), para_sobre(A, B2)), NovoEstado) :-
    select(no_chao(B, X), Estado, Resto),
    pode_empilhar(B, A, B2),
    append([sobre(B, A, B2)], Resto, NovoEstado).

% --- Motor de Busca (Solve) ---
resolver(Estado, [], Estado) :- objetivo(Estado).
resolver(Estado, [Acao|Passos], EstadoFinal) :-
    acao(Estado, Acao, EstadoSeguinte),
    resolver(EstadoSeguinte, Passos, EstadoFinal).
