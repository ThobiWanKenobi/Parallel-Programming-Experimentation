-- Parallel Longest Satisfying Segment
--
-- ==
-- entry: main seq
-- compiled input {
--    [1, -2, -2, 0, 0, 0, 0, 0, 3, 4, -6, 1]
-- }  
-- output { 
--    9
-- }

-- Parallel Longest Satisfying Segment - Sorted
--
-- ==
-- entry: main seq
-- compiled input {
--    [2i32, 3, -1, -2, 0, 1i32, 2, 3i32, 5, 9, 15, -5, 7, 9i32, 0, 0, 0]
-- }
-- output {
--    8
-- }

-- Longest Satisfying Segment, sorted predicate - parallel
-- ==
-- entry: main
-- "10M"  input @ data/lss_10M.in
-- "100M" input @ data/lss_100M.in

-- Longest Satisfying Segment, sorted predicate - sequential
-- ==
-- entry: seq
-- "10M"  input @ data/lss_10M.in
-- "100M" input @ data/lss_100M.in

import "lssp"
import "lssp-seq"

let sorted_pred1 _   = true
let sorted_pred2 (x: i32) (y: i32) = (x <= y)

entry main (xs: []i32) : i32 = lssp     sorted_pred1 sorted_pred2 xs
entry seq  (xs: []i32) : i32 = lssp_seq sorted_pred1 sorted_pred2 xs
