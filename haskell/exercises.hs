-- factorial
fact 0 = 1
fact n = n * fact(n-1)

-- fibonacci
fib 0 = 1
fib n = helper (n-1) 1 1
        where helper 0 a b = b
              helper n a b = helper (n-1) b (a+b)
-- alternatively you could use let (definitions) in (expression)

-- quick sort
qsort [] = []
qsort [x] = [x]
qsort (h:t) = (qsort smaller) ++ [h] ++ (qsort greater)
              where smaller = [x | x <- t, x < h]
                    greater = [x | x <- t, x >= h]

-- find the length of a list
length' [] = 0
length' x = 1 + length' (tail x)

-- find the sum of a list of numbers
sum' [] = 0
sum' (h:t) = h + sum' t

-- tree traversal
-- nodes are 3-tuples (value, left subtree, right subtree)
left (_, l, _) = l
right (_, _, r) = r
value (v, _, _) = v

--preorder :: (Show a, Show b, Show c) => (a, b, c) -> String
preorder (_, (), ()) = show ()
preorder (v, l, r) = (show v) ++ " " ++ (preorder l) ++ " " ++ (preorder r)
-- TODO: fix above so it doesn't try to call preorder on ()
