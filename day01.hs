import Data.List

main = do input <- getContents
          let mapped = map convert input
          print . sum $ mapped
          print . elemIndex (-1) . scanl1 (+) $ mapped
       where convert '(' = 1
             convert _ = -1
