foldn :: Int -> String -> String
foldn n (a:b:xs) = if a == b then
                     foldn (n + 1) (b:xs)
                   else
                     show n ++ [a] ++ foldn 1 (b:xs)
foldn n (x:[]) = show n ++ [x]


main = do print $ length (seq !! 40)
          print $ length (seq !! 50)
       where seq = iterate (foldn 1) "3113322113"
