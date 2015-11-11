% a binary tree is stored as [root, left_subtree, right_subtree]

% check if the atom X is in the given tree
member(X, [X, _, _]).
member(X, [root, left_subtree, right_subtree]) :- X =< root, member(X, left_subtree).
member(X, [root, left_subtree, right_subtree]) :- X > root, member(X, right_subtree).

% insert the atom X into the given tree, and return the modified tree
insert(X, [], [X, [], []]).
insert(X, [root, left_subtree, right_subtree], [root, new_left, right_subtree]) :-
    X =< root,
    insert(X, left_subtree, new_left).

% remove the first instance of the given atom X, and return the modified tree
remove_leftmost([V, [], Right], Right, V).
remove_leftmost([V, Left, Right], [V, NewLeft, Right], Val) :- 
    remove_leftmost(Left, NewLeft, Val).
remove_rightmost([V, Left, []], Left, V).
remove_rightmost([V, Left, Right], [V, Left, NewRight], Val) :- 
    remove_rightmost(Right, NewRight, Val).
remove(_, [], []).
remove(X, [X, [], []], []).
remove(X, [X, Left, []], Left).
remove(X, [X, [], Right], Right).
remove(X, [Root, Left, Right], [Root, NewLeft, Right]) :-
    X < Root,
    remove(X, Left, NewLeft).
remove(X, [Root, Left, Right], [Root, Left, NewRight]) :-
    X > Root,
    remove(X, Right, NewRight).
remove(X, [X, [], Right], [Leftmost, [], NewRight]) :-
    remove_leftmost(Right, NewRight, Leftmost).
remove(X, [X, Left, Right], [Rightmost, NewLeft, Right]) :-
    remove_rightmost(Left, NewLeft, Rightmost).

