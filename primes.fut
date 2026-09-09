-- W(n lg lg n), D(\sqrt{n}) (not good enough)
let primesHelp [np1] (sq: i64)
    (a: *[np1]i32): [np1]i32 =
    
    let n = np1 - 1 in
    loop(a) for j < (sq-1) do
        let i = j + 2
        let m = (n / i) - 1
        let inds = map (\k -> (k + 2) * i) (iota m)
        in scatter a inds (replicate m 0)
    
let main (n: i64) : []i64 =
    let a = map (\i -> if i == 0 || i == 1 
                       then 0 else 1) 
                (iota (n + 1))
    let sq = i64.f64 (f64.sqrt (f64.i64 n))
    let fl = primesHelp sq a
    in filter (\i -> #[unsafe] fl[i] != 0)
        (iota (n + 1))

