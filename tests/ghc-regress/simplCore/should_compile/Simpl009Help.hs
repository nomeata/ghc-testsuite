{-# OPTIONS -fglasgow-exts #-}

-- Helper for simpl009.hs (see comments there)

module Simpl009Help where
  
import Monad

newtype Parser s a
  = Parser (forall res . (a -> [String] -> P s res) -> [String] -> P s res)

data P s res
  = Symbol (s -> P s res)
  | Fail [String] [String]
  | Result res (P s res)

instance Monad (Parser s) where
  return a = Parser (\fut -> fut a)
  
  Parser f >>= k =
    Parser (\fut -> f (\a -> let Parser g = k a in g fut))

  fail s =
    Parser (\fut exp -> Fail exp [s])

instance MonadPlus (Parser s) where
  mzero =
    Parser (\fut exp -> Fail exp [])

lookAhead :: Parser s s
lookAhead =
  Parser (\fut exp -> Symbol (\c ->
    feed c (fut c [])
  ))
 where
  feed c (Symbol sym)     = sym c
  feed c (Result res fut) = Result res (feed c fut)
  feed c p@(Fail _ _)     = p
