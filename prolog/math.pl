% calculate X = M^N where N is a nonnegative integer
power(_, 0, 1).
power(M, 1, M).
power(M, N, X) :- O is M * M, P is N - 1, power(O, P, X).

% calculate X = log base M of Q (M^X = Q)
log(_, 1, 0).
log(M, M, 1).
log(M, Q, X) :- N is Q / M, log(M, N, Y), X is Y + 1.

% calculate X = N!
factorial(0, 1).
factorial(1, 1).
factorial(N, X) :- O is N - 1, factorial(O, P), X is P * N.

% X = pascal's triangle at row, col (0-indexed)
pascal(_, 0, 1).
pascal(R, R, 1).
pascal(R, C, X) :- Q is R - 1, B is C - 1, pascal(Q, B, Y), pascal(Q, C, Z), X is Y + Z.

% calculate X = number of combinations N choose K
comb(N, K, X) :- K = N, X is 1.
comb(N, K, X) :- K > N, X is 0.
comb(N, K, X) :- pascal(N, K, X).
