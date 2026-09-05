let max (x:i32, y:i32) = i32.max x y

let mssp (xs: []i32) : i32 =
    let best_sum = 0
    let curr_sum = 0
    let (res, _) =
        loop(best_sum, curr_sum) for x in xs do
            let curr_sum = max(0, curr_sum + x)
            let best_sum = max(best_sum, curr_sum)
            in (best_sum, curr_sum)
    in res

let main(xs: []i32) = mssp xs