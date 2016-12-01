import qualified Data.Word (Word32)
import Data.Bits

import Text.Parsec
import Text.Parsec.String
import Text.Parsec.Combinator
import Text.Parsec.Char

import Data.Map (Map, insert)
import qualified Data.Map as M

type Word16 = Data.Word.Word32

data Value = Reference String
           | Scalar Word16

instance Show Value where
  show (Reference x) = x
  show (Scalar x) = show x

data Operation = And Value Value String
               | Or Value Value String
               | RShift Value Value String
               | LShift Value Value String
               | Not Value String
               | Set Value String

instance Show Operation where
  show (And a b ref) = show a ++ " AND " ++ show b ++ " -> " ++ ref
  show (Or a b ref) = show a ++ " OR " ++ show b ++ " -> " ++ ref
  show (LShift a b ref) = show a ++ " LSHIFT " ++ show b ++ " -> " ++ ref
  show (RShift a b ref) = show a ++ " RSHIFT " ++ show b ++ " -> " ++ ref
  show (Not a ref) = "NOT " ++ show a ++ " -> " ++ ref
  show (Set a ref) = show a ++ " -> " ++ ref


scalarParser :: Parser Word16
scalarParser = many1 digit >>= return . read

referenceParser :: Parser String
referenceParser = many1 lower

valueParser :: Parser Value
valueParser = (referenceParser >>= return . Reference) <|> (scalarParser >>= return . Scalar)

setParser :: Parser Operation
setParser = do val <- valueParser
               string " -> "
               ref <- referenceParser
               return $ Set val ref

operation :: String -> Value -> Value -> String -> Operation
operation "AND" = And
operation "OR" = Or
operation "RSHIFT" = RShift
operation "LSHIFT" = LShift

binaryOperationParser :: Parser Operation
binaryOperationParser = do a <- valueParser
                           spaces
                           op <- many1 upper
                           spaces
                           b <- valueParser
                           string " -> "
                           out <- referenceParser
                           return $ operation op a b out

notParser :: Parser Operation
notParser = do string "NOT "
               a <- valueParser
               string " -> "
               b <- referenceParser
               return $ Not a b

operationParser = try setParser <|> notParser <|> binaryOperationParser

resolveValue :: Map String Word16 -> Value -> Word16
resolveValue map (Reference x) = maybe 0 id (M.lookup x map)
resolveValue map (Scalar x) = x

applyOperation :: Map String Word16 -> Operation -> Map String Word16
applyOperation values (Set val ref) = insert ref (resolveValue values val) values
applyOperation values (And a b ref) = insert ref (resolveValue values a .&. resolveValue values b) values
applyOperation values (Or a b ref) = insert ref (resolveValue values a .|. resolveValue values b) values
applyOperation values (RShift a b ref) = insert ref (resolveValue values a `shiftL` (fromIntegral $ resolveValue values b)) values
applyOperation values (LShift a b ref) = insert ref (resolveValue values a `shiftR` (fromIntegral $ resolveValue values b)) values
applyOperation values (Not a ref) = insert ref (complement $ resolveValue values a) values

evalNextScalar values (Set (Scalar x) ref) = (True, insert ref x values)

inputParser = many (do x <- operationParser
                       many newline
                       return x)

printProgram :: [Operation] -> IO ()
printProgram ops = putStr $ unlines $ map show ops

printState :: Map String Word16 -> IO ()
printState m = putStr $ unlines $ map (\(k, v) -> k ++ ": " ++ show v) (M.toAscList m)

main = do input <- getContents
          let program = either (const []) id (parse inputParser "" input)
          printProgram program
          printState $ foldl applyOperation M.empty program
