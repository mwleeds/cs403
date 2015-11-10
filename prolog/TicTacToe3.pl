% Author: Dr. Richard Borie

other(x,o).
other(o,x).

cell(1). cell(2). cell(3).
cell(4). cell(5). cell(6).
cell(7). cell(8). cell(9).

line(1,2,3). line(4,5,6). line(7,8,9).
line(1,4,7). line(2,5,8). line(3,6,9).
line(1,5,9). line(3,5,7).

at([X|_], 1, X).
at([_|Y], K, Z) :- K>1, J is K-1, at(Y, J, Z).

put([_|Y], 1, A, [A|Y]).
put([X|Y], K, A, [X|Z]) :- K>1, J is K-1, put(Y, J, A, Z).

won(P, B) :- line(X, Y, Z), at(B, X, P), at(B, Y, P), at(B, Z, P).

lost(P, B) :- other(P, Q), won(Q, B).

tied(B) :- not(won(_, B)), not(move(_, B, _, _)).

move(P, B, K, C) :- cell(K), at(B, K, '-'), put(B, K, P, C).

one_move_win(P, B, C) :- move(P, B, _, C), won(P, C).

will_win(P, B, _) :- won(P, B).
will_win(P, B, K) :- not(lost(P, B)), move(P, B, K, C), other(P, Q), will_lose(Q, C).

will_win_or_tie(P, B, _) :- tied(B).
will_win_or_tie(P, B, K) :- not(lost(P, B)), move(P, B, K, C), other(P, Q), not(will_win(Q, C, _)).

will_lose(P, B) :- lost(P, B).
will_lose(P, B) :- not(will_win_or_tie(P, B, _)).

will_tie(P, B) :- not(will_win(P, B, _)), not(will_lose(P, B)).

start :- ask_level(L), L>=1, L=<3, retractall(level(_)), assert(level(L)), show_rules, init(9, B), x_turn(B).

ask_level(L) :- write('Enter level 1 (beginner), 2 (intermediate), or 3 (advanced) followed by dot.'), nl, read(L).

show_rules :- write('You are X. Enter integer 1 to 9 followed by dot.'), nl, display([1,2,3,4,5,6,7,8,9]).

display([A,B,C,D,E,F,G,H,I]) :- write([A,B,C]), nl, write([D,E,F]), nl, write([G,H,I]), nl, nl.

init(0, [ ]).
init(N, ['-'|X]) :- N>0, M is N-1, init(M, X).

x_turn(B) :- won(o, B), write('Computer wins.'), nl, !.
x_turn(B) :- read(K), move(x, B, K, C), display(C), !, o_turn(C).

o_turn(B) :- won(x, B), write('You win.'), nl, !.
o_turn(B) :- tied(B), write('Game over. Nobody wins.'), nl, !.
o_turn(B) :- level(1), beginner_move(B).
o_turn(B) :- level(2), intermediate_move(B).
o_turn(B) :- level(3), advanced_move(B).

advanced_move(B) :- will_win(o, B, K), move(o, B, K, C), display(C), !, x_turn(C).
advanced_move(B) :- will_win_or_tie(o, B, K), move(o, B, K, C), display(C), !, x_turn(C).
advanced_move(B) :- move(o, B, _, C), display(C), !, x_turn(C).

intermediate_move(B) :- one_move_win(o, B, C), display(C), !, x_turn(C).
intermediate_move(B) :- move(o, B, _, C), not(one_move_win(x, C, _)), display(C), !, x_turn(C).
intermediate_move(B) :- move(o, B, _, C), display(C), !, x_turn(C).

beginner_move(B) :- move(o, B, _, C), display(C), !, x_turn(C).
