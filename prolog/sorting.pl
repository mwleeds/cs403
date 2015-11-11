% insertion sort
insertion_sort([], []).
insertion_sort(List, Sorted) :- 
    insertion_helper(List, [], Sorted).
% insertion helper iterates over the first argument inserting elements
% into the second argument, which is a sorted list (returned in the 3rd).
insertion_helper([], Sorted, Sorted).
insertion_helper([H|T], SortedPartial, Sorted) :- 
    insert_into(H, SortedPartial, NewSortedPartial), 
    insertion_helper(T, NewSortedPartial, Sorted).
% insert E into the sorted list L, yielding M
insert_into(Elem, [], [Elem]).
insert_into(Elem, [H|T], New) :- 
    Elem =< H, 
    append([Elem], [H|T], New).
insert_into(Elem, [H|T], [H|NewTail]) :- 
    Elem > H, 
    insert_into(Elem, T, NewTail).

% selection sort
min([X], X).
min([X,Y], X) :- X =< Y.
min([X,Y], Y) :- Y < X.
min([H|T], X) :- min(T, U), min([H,U], X).
remove(H, [H|T], T).
remove(X, [H|T], [H|U]) :- remove(X, T, U).
selection_sort([], []).
selection_sort(L, [Smallest|Sorted]) :- 
    min(L, Smallest), 
    remove(Smallest, L, NewUnsorted), 
    selection_sort(NewUnsorted, Sorted).

% merge sort
split([], [], []).
split([X], [X], []).
split([L,R|T], [L|LT], [R|RT]) :- 
    split(T, LT, RT).
merge(Left, [], Left).
merge([], Right, Right).
merge([L|LT], [R|RT], [L|RestSorted]) :- 
    L =< R,
    merge(LT, [R|RT], RestSorted).
merge([L|LT], [R|RT], [R|RestSorted]) :- 
    L > R,
    merge([L|LT], RT, RestSorted).
merge_sort([], []).
merge_sort([X], [X]).
merge_sort(List, Sorted) :-
    split(List, Left, Right),
    merge_sort(Left, LeftSorted),
    merge_sort(Right, RightSorted),
    merge(LeftSorted, RightSorted, Sorted).

% quick sort
partition(_, [], [], []).
partition(Pivot, [X], [X], []) :- X =< Pivot.
partition(Pivot, [Y], [], [Y]) :- Y > Pivot.
partition(Pivot, [H|T], [H|Smaller], Larger) :-
    H =< Pivot,
    partition(Pivot, T, Smaller, Larger).
partition(Pivot, [H|T], Smaller, [H|Larger]) :-
    H > Pivot,
    partition(Pivot, T, Smaller, Larger).
quick_sort([], []).
quick_sort([X], [X]).
quick_sort([H|T], Sorted) :-
    partition(H, T, Smaller, Larger),
    quick_sort(Smaller, SmallerSorted),
    quick_sort(Larger, LargerSorted),
    append(SmallerSorted, [H|LargerSorted], Sorted).

