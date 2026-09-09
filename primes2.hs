-- D(lg lg n)
primesOpt :: Int -> [Int]
primesOpt n =
    if n <= 2 then [2]
    else
        let sqrtN = floor (sqrt (fromIntegral n))
            sqrt_primes = primesOpt sqrtN
            nested = map (\p -> let m = (n `div` p)
                            in map (\j -> j * p)
                                   [2..m]
                         ) sqrt_primes
            not_primes = reduce (++) [] nested
            mm = length not_primes
            zeros = replicate mm False
            prime_flags = scatter (replicate (n + 1) True)
                                    not_primes zeros
            (primes, _) = unzip $ filter (\(i, f) -> f)
                            $ (zip [0..n] prime_flags)
        in drop 2 primes