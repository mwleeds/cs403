% Author: Dr. Richard Borie

% Prolog: Programming Logic
% a declarative programming language
% variables begin with uppercase letters
% add facts and rules, then ask queries
% closed world assumption: all facts in database; not true means the expression can't be proven from what has been defined

% example: familial relations
% facts
relation(a, b, c, d).
parent(bob, sue).
parent(sue, bill).
parent(sue, john).
male(bob).
female(sue).
male(bill).
male(john).
% rules
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X =/= Y.

% you could ask parent(sue, A) at the prompt and it will answer with the first match (bill). A semicolon means continue the search.
% use consult(filepath) to load facts/rules into the interpreter


%database:
p(f(Y)) :- q(Y), r(Y)
q(g(Z)).
q(h(Z)).
r(h(a)).
% ?- p(x) first sets X = f(Y), then Y = g(z) based on q(g(Z)), then failing trying to find r(g(Z))
% on the second try Y = h(Z) and x = f(h(a)) is returned (and that's the only solution)

% math operations aren't pure logic because an order/direction is forced
% binary operators: + - * / // mod is (assignment)
% comparisons: > >= < =< =

factorial(0, 1).
factorial(N, R) :-
  N > 0,
  M is N - 1,
  factorial(M, Q),
  R is N * Q.
% notice instead of functions returning values, a parameter is passed to receive the result

inversefact(0, 1).
inversefact(N, R) :-
  R > 1,
  helper(1, N, R).
helper(M, N, R) :-
  R > 1,
  X is R // M,
  Y is R mod M,
  Y = 0, 
  Z is M + 1,
  helper(Z, N, X).

% if no inverse factorial is found, the interpreter will return No or False

% inefficient fibonacci:
fib(0, 0).
fib(1, 1).
fib(N, Z) :-
  N > 1,
  A is N - 2,
  B is N - 1,
  fib(A, X),
  fib(B, Y),
  Z is X + Y.

fib(N, Z) :-
  helper(1, 0, N, Z).
% where N is the number of terms remaining
helper(_, Y, 0, Y)
helper(X, Y, N, Z) :-
  N > 0,
  Q is X + Y,
  M is N - 1,
  helper(Y, Q, M, Z).

% lists

% scheme: '(1 2 3 4)
% haskell, prolog: [1,2,3,4]

% cons

% scheme: (cons H T)
% haskell: (H : T)
% prolog: [H|T]

% redefining length

length([], 0).
length([_|T], N) :-
  length(T, M),
  N is M + 1.

% redefining append
% append([a,b],[c,d],X) yields [a,b,c,d]
% consequently append([a,b],X,[a,b,c,d]) yields [a,b,c,d]
% append(X, Y, [a,b,c,d]) would yield all possible solutions
% that is, direction doesn't matter because no math is involved

append([], Y, Y).
append([H|T], Y, [H|Q]) :-
  append(T, Y, Q).

cons(X, Y, [X|Y]).
head([X|Y], X).
tail([X|Y], Y).

% ?- reverse([a,b,c,d], L) yields [d,c,b,a]
reverse([], []).
reverse([H|T], L) :-
  reverse(T, Q),
  append(Q, [H], L).
% the above algorithm runs in O(n^2) time

% in O(n) time:
reverse(L, R) :-
  helper(L, [], R).
helper([], R, R).
helper([H|T], L, R) :-
  helper(T, [H|L], R).


% bubble sort

ascending([]).
ascending([_]).
ascending([A,B|T]) :-
  A < B, ascending([B|T]).

% the second parameter is the list to be "returned"
% ! means don't backtrack (don't search for any other solutions)
bubblesort(L,L) :- ascending(L), !. 
% do one pass (swapping out-of-order elements) and recurse
bubblesort(L, L2) :- pass(L, L1), bubblesort(L1, L2).
pass([x], [x]).
pass([A,B|T], [A|L]) :- A =< B, pass([B|T], L).
pass([A,B|T], [B|L]) :- A > B, pass([A|T], L).

% quicksort
quicksort([], []).
quicksort([H|T], L) :-
  partition(H, T, Less, Greater),
  quicksort(Less, X),
  quicksort(Greater, Y),
  append(X, [H|Y], L).
partition(pivot, [], [], []).
partition(pivot, [H|T], L, [H|G]) :-
  pivot < H, partition(pivot, T, L, G).
partition(pivot, [H|T], [H|L], G) :-
  pivot > H, partition(pivot, T, L, G).

% flatten a nested list
% ?- flatten([a, [], [b,c], [[d],[e]]], L) yields L = [a,b,c,d,e]
% ?- flatten(a, L) yields L = [a]
% atom(X) succeeds if X is not a list
% number(X), integer(X), float(X), symbol(X) check the type of X
% var(X) succeeds if X is an unassigned variable

flatten([], []).
flatten(X, [X]) :- atom(X).
flatten([H|T], L) :-
  flatten(H, Y),
  flatten(T, Z),
  append(Y, Z, L).

% binary trees
% [root, left, right]
maketree([], []).
maketree([H|T], Tree) :-
  maketree(T, X),
  insert(H, X, Tree).

% insert(H, X, Y) inserts H into X and returns Y
insert(H, [], [H, [], []]).
insert(H, [Root, Left, Right], [Root, NewLeft, Right]) :- H =< Root, insert(H, Left, NewLeft).
insert(H, [Root, Left, Right], [Root, Left, NewRight]) :- H > Root, insert(H, Right, NewRight).

% traversal
inorder([], []).
inorder([Root, Left, Right], L) :-
  inorder(Left, X),
  inorder(Right, Y),
  append(X, [Root|Y], L).

% remove an element from a list
remove(H, [H|T], T).
remove(X, [H|T], [H|U]) :- remove(X, T, U).

% the second argument is any permutation of the first
permute([], []).
permute(L, [H|T]) :- member(H, L), remove(H, L, M), puzzle(M, T).

% check if an element is in a list
member(H, [H|_]) :- !.
member(H, [_|T]) :- member(H, T).

% bogo sort
sort([], []).
sort(A, B) :- permute(A, B), ascending(A, B).

% print all permutations of a list
print_permutations(L) :- permute(L, Z), write(Z), nl, fail.
fail :- 0=1.

not(X) :- call(X), !, fail.
not(_).
