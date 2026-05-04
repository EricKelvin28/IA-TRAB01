% =========================================
% PLANEJADOR FINAL 
% =========================================

% -------------------------
% BLOCOS
% -------------------------
bloco(a,1).
bloco(b,1).
bloco(c,2).
bloco(d,3).

limite(0,6).

% -------------------------
% ESTADOS (NÃO ALTERADOS)
% -------------------------
estado(s0, [
    b(c,0,1,0),
    b(a,3,3,0),
    b(b,5,5,0),
    b(d,3,5,1)
]).

estado(sf1, [
    b(d,3,5,0),
    b(a,4,4,1),
    b(b,5,5,1),
    b(c,4,5,2)
]).

% -------------------------
% SOBREPOSIÇÃO
% -------------------------
sobrepoe(I1,F1,I2,F2) :-
    I1 =< F2,
    I2 =< F1.

% -------------------------
% OCUPAÇÃO
% -------------------------
ocupado(I,F,H,Estado) :-
    member(b(_,I2,F2,H), Estado),
    sobrepoe(I,F,I2,F2).

espaco_livre(I,F,H,Estado) :-
    \+ ocupado(I,F,H,Estado).

% -------------------------
% TOPO LIVRE
% -------------------------
topo_livre(b(_,I,F,H), Estado) :-
    H1 is H+1,
    \+ (
        member(b(_,I2,F2,H1), Estado),
        sobrepoe(I,F,I2,F2)
    ).

% -------------------------
% SUPORTE (MODELO PDF)
% -------------------------
tem_suporte(_,_,0,_).

tem_suporte(I,F,H,Estado) :-
    H > 0,
    H1 is H-1,
    member(b(_,I2,F2,H1), Estado),
    sobrepoe(I,F,I2,F2).

% -------------------------
% UTIL
% -------------------------
pega_bloco(N, [b(N,I,F,H)|_], b(N,I,F,H)).
pega_bloco(N, [_|T], B) :- pega_bloco(N,T,B).

remove_bloco(N, [b(N,_,_,_)|T], T).
remove_bloco(N, [H|T], [H|R]) :- remove_bloco(N,T,R).

% -------------------------
% ALTURA
% -------------------------
altura_valida(I,F,H,Estado,H) :-
    H =< 5,
    espaco_livre(I,F,H,Estado),
    tem_suporte(I,F,H,Estado), !.

altura_valida(I,F,H,Estado,Hfinal) :-
    H < 5,
    H1 is H+1,
    altura_valida(I,F,H1,Estado,Hfinal).

% -------------------------
% POSIÇÕES (REDUZIDAS)
% -------------------------
pos_valida(N, Pos) :-
    bloco(N,Tam),
    limite(Min,Max),
    MaxPos is Max - Tam + 1,
    between(Min, MaxPos, Pos),
    member(Pos, [0,2,3,4,5]).  % reduz busca

% -------------------------
% MOVER
% -------------------------
mover(N, NovoInicio, Estado, NovoEstado) :-

    pega_bloco(N, Estado, b(N,I,F,H)),
    bloco(N,Tam),

    NovoInicio =\= I,

    topo_livre(b(N,I,F,H), Estado),

    NovoFim is NovoInicio + Tam - 1,
    limite(_,Max),
    NovoFim =< Max,

    altura_valida(NovoInicio, NovoFim, 0, Estado, NovaAltura),

    espaco_livre(NovoInicio, NovoFim, NovaAltura, Estado),

    tem_suporte(NovoInicio, NovoFim, NovaAltura, Estado),

    remove_bloco(N, Estado, Temp),
    NovoEstado = [b(N,NovoInicio,NovoFim,NovaAltura)|Temp].

% -------------------------
% NORMALIZAÇÃO
% -------------------------
normaliza(E, EN) :- sort(E, EN).

% -------------------------
% COMPARAÇÃO
% -------------------------
igual_estado([], _).
igual_estado([b(N,I,F,H)|T], Estado) :-
    member(b(N,I,F,H), Estado),
    igual_estado(T, Estado).

% -------------------------
% RESOLVER
% -------------------------
resolver(Plano) :-
    estado(s0, Ini),
    estado(sf1, Goal),
    normaliza(Ini, IniN),
    busca(IniN, Goal, [IniN], Plano, 0, 8).

% -------------------------
% BUSCA CONTROLADA
% -------------------------
busca(Estado, Goal, _, [], _, _) :-
    igual_estado(Goal, Estado).

busca(EstadoAtual, Goal, Visitados, [move(N,Pi,Pj)|Plano], Prof, Limite) :-
    Prof < Limite,

    member(b(N,Pi,F,H), EstadoAtual),
	topo_livre(b(N,Pi,F,H), EstadoAtual),

    pos_valida(N, Pj),
    Pj =\= Pi,

    mover(N, Pj, EstadoAtual, NovoEstado),

    normaliza(NovoEstado, NovoN),

    \+ member(NovoN, Visitados),

    Prof1 is Prof + 1,

    busca(NovoN, Goal, [NovoN|Visitados], Plano, Prof1, Limite).
    busca(NovoN, Goal, [NovoN|Visitados], Plano, Prof1, Limite).
