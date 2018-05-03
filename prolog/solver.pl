printline([]) :- writeln("|").
printline([H|T]) :- integer(H), !, write("|"), write(H), printline(T).
printline([_|T]) :-  write("|"), write(" "), printline(T).

print([]) :- !.
print([H|T]) :- printline(H), print(T).

bonnelongueur([], 0).
bonnelongueur([_|T], N) :- bonnelongueur(T, X), N is X+1.

bonnetaille([], _) :- !.
bonnetaille([H|T], N) :- bonnelongueur(H, N), !, bonnetaille(T, N).

:- use_module(library(clpfd)).

grille([
	[_,_,_,_,_,3,_,8,5],
	[_,_,_,_,_,_,_,_,_],
	[_,_,1,_,2,_,_,_,_],
	[_,_,_,5,_,7,_,_,_],
	[_,_,4,_,_,_,1,_,_],
	[_,9,_,_,_,_,_,_,_],
	[5,_,_,_,_,_,_,7,3],
	[_,_,2,_,1,_,_,_,_],
	[_,_,_,_,4,_,_,_,9]]).

verifie([]).
verifie([H|T]) :- H ins 1..9, all_distinct(H), verifie(T).

eclate([], _, []) :- !.
eclate([H|T], [], [[H]|T2]) :- eclate(T,[], T2), !.
eclate([H1|T1], [H2|T2], [[H1|H2]|T3]) :- eclate(T1, T2,T3).

transp([], []) :- !.
transp([H|T], L) :- transp(T, L2), eclate(H, L2, L).

decoupe([], [], [], []).
decoupe([A1, A2, A3|T1],
	[B1, B2, B3|T2],
	[C1, C2, C3|T3],
	[[A1, A2, A3, B1, B2, B3, C1, C2,C3]|L]) :- decoupe(T1, T2, T3, L).

concatene([], L, L).
concatene([H|T], L, [H|T1]) :- concatene(T, L, T1).

carres([], []).
carres([L1, L2, L3|T], L) :- carres(T,X), decoupe(L1, L2, L3, Y), concatene(X, Y, L).

solution(GRID) :- transp(GRID, TGRID),
	bonnetaille(GRID, 9), bonnetaille(TGRID, 9),
	verifie(GRID), verifie(TGRID),
	carres(GRID, CGRID), carres(TGRID, CTGRID),
	verifie(CGRID), verifie(CTGRID).