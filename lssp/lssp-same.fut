-- Parallel Longest Satisfying Segment
--
-- ==
-- entry: main seq
-- compiled input {
--    [1i32, -2i32, -2i32, 0i32, 0i32, 0i32, 0i32, 0i32, 3i32, 4i32, -6i32, 1i32]
-- }
-- output {
--    5i32
-- }

-- Parallel Longest Satisfying Segment - Same
--
-- ==
-- entry: main seq
-- compiled input {
--    [-2, 0, 0, 0, 1i32, 5i32, 2i32, 2, 2, 2i32, 2, 2, 2, -5, -1, 0, 8, 10i32]
-- }
-- output {
--    7
-- }

-- Longest Satisfying Segment, same predicate - parallel
-- ==
-- entry: main
-- "10M"  input @ data/lss_10M.in
-- "100M" input @ data/lss_100M.in

-- Longest Satisfying Segment, same predicate - sequential
-- ==
-- entry: seq
-- "10M"  input @ data/lss_10M.in
-- "100M" input @ data/lss_100M.in

import "lssp"
import "lssp-seq"

let same_pred1 _   = true
let same_pred2 (x: i32) (y: i32) = (x == y)

entry main (xs: []i32) : i32 = lssp     same_pred1 same_pred2 xs
entry seq  (xs: []i32) : i32 = lssp_seq same_pred1 same_pred2 xs
