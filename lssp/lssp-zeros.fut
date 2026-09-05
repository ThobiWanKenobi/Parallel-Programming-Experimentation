-- Parallel Longest Satisfying Segment
--
-- ==
-- entry: main seq
-- compiled input {
--    [1i32, -2, -2, 0, 0, 0, 0, 0, 3, 4, -6, 1]
-- }
-- output {
--    5
-- }

-- Parallel Longest Satisfying Segment with zeros predicate
--
-- ==
-- entry: main seq
-- compiled input {
--    [0, 0, 0, 1i32, -2, -1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -5, 2i32, 0, 0, 0, 0]
-- }
-- output {
--    9
-- }

import "lssp-seq"
import "lssp"

let zeros_pred1 x = (x == 0i32)
let zeros_pred2 x y = zeros_pred1 x && zeros_pred1 y

entry main (xs: []i32): i32 = lssp     zeros_pred1 zeros_pred2 xs
entry seq  (xs: []i32): i32 = lssp_seq zeros_pred1 zeros_pred2 xs
