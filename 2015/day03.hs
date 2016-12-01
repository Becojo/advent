import Data.Set

move (x, y) '^' = (x, y - 1)
move (x, y) 'v' = (x, y + 1)
move (x, y) '<' = (x - 1, y)
move (x, y) '>' = (x + 1, y)

dropEven (x:_:xs) = x:(dropEven xs)
dropEven x = x

part1 = size . fromList . scanl move (0, 0)
part2 input = size . fromList $ scanl move (0, 0) (dropEven input) ++
                                scanl move (0, 0) (dropEven (tail input))

main = do input <- getContents
          print . part1 $ input
          print . part2 $ input
