let segmented_scan [n] 't 
    (op: t -> t -> t) 
    (ne: t) 
    (flags: [n] bool)
    (arr: [n]t): [n]t =
    
    let (_, res) = unzip <|
        scan (\(x_flag, x) (y_flag, y) ->
            let fl = x_flag || y_flag
            let vl = if y_flag then y else op x y
            in (fl, vl)
        ) (false, ne) (zip flags arr)
    in res