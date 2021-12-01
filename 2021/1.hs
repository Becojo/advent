part1 :: [Int] -> Int
part1 xs = length . filter (uncurry (<)) . zip xs $ (drop 1 xs)

part2 :: [Int] -> Int
part2 xs = part1 $ map (\(a,b,c) -> a+b+c) $ zip3 xs (drop 1 xs) (drop 2 xs)

main = do input <- getContents
          let xs = map read . lines $ input in
            (putStrLn . part1 $ xs) >> (putStrLn . part2 $ xs)
