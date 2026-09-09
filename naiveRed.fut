-- Reduction by hand in Futhark: naiveRed.fut
-- ==
-- entry: futharkRed naiveRed
-- copmiled input { [1.0f32, -2.0, 3.0, 1.0] }
-- output { 3.0f32 }
-- compiled random input { [33554432]f32 } auto output

entry naiveRed [n] (a: [n]f32) : f32 = -- assumes n = 2^k
    let k = i64.f32 <| f32.log2 <| f32.i64 n
    let b = 
        loop b = a for h < k do
            let n' = n >> (h + 1)
            in map (\i -> b[2 * i] + b[2 * i + 1]) (iota n')
    in b[0]

entry futharkRed [n] (a: [n]f32): f32 =
    reduce (+) 0.0f32 a