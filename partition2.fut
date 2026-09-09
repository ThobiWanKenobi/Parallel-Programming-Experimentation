let partition2 't [n] (dummy: t)
    (pred: t -> bool) (X: [n]t): (i64, [n]t) =

    let cs = map pred X
    let tfs = map (\f -> if f then 1 else 0) cs

    let isT = scan (+) 0 tfs
    let s = if n == 0 then 0 else isT[n-1]

    let ffs = map (\f -> if f then 0 else 1) cs
    let isF = map (+s) <| scan (+) 0 ffs

    let inds = map (\(c, iT, iF) ->
        if c then iT - 1
        else iF - 1) (zip3 cs isT isF)
    
    let tmp = replicate n dummy
    in (s, scatter tmp inds X)