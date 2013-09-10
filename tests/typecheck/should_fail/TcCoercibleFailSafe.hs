{-# LANGUAGE RoleAnnotations, RankNTypes, ScopedTypeVariables, Safe #-}

import GHC.Prim (coerce)
import GHC.Types (Coercible)
import Data.Ord (Down)

newtype Age = Age Int deriving Show

foo1 :: (Down Age -> Down Int)
foo1 = coerce 

main = return ()
