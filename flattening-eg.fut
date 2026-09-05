import "mk-flag-array"

let sgmScan [n] 't (op: t -> t -> t) (ne: t) (flags: [n]i32) (arr: [n]t) : [n]t =
    let (_, res) = 
        scan (\(x_flag, x) (y_flag, y) ->
                    let fl = x_flag | y_flag
                    let vl = if y_flag != 0 then y else op x y
                    in (fl, vl)
             ) (0, ne) (zip flags arr)
        |> unzip
    in res