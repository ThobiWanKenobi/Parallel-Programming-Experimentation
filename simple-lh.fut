let max (x:f32) (y:f32) = f32.max x y

let id x = x

let all [n] 't (p : t -> bool) (a: [n]t) : bool =
    map p a |> reduce (&&) true

let sum (a: []f32) : f32 = 
    reduce (+) 0.0 <| map id a

let fld (a: []f32) : f32 =
    map (\x -> x - 2f32) a |> reduce (*) 1.0f32

let main [n] (a: [n]f32) : (bool, f32, f32, f32) =
    let p = all (> -10) a
    let m = reduce max 0.0f32 a
    let s = map (\x -> x / m) a |> sum
    let f = fld a
    in (p, m, s, f)