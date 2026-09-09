-- W(n lg N), D(lg^2 n)
nestedQuicksort :: [a] -> [a]
nestedQuicksort arr =
    if (length arr) <= 1 then 
        arr 
    else
        let i = getRand (0, (length arr) - 1)
            a = arr !! i
            s1 = filter (\x -> (x < a)) arr
            s2 = filter (\x -> (x >= a)) arr
            rs = map nestedQuicksort [s1, s2]
        in (rs !! 0) ++ (rs !! 1)
