{-# LANGUAGE RoleAnnotations, RankNTypes, ScopedTypeVariables #-}

import GHC.Prim (coerce)
import GHC.Types (Coercible)
import Data.Ord (Down)

newtype Age = Age Int deriving Show

data Map a@N b = Map a b deriving Show

foo1 = coerce $ one :: ()

foo2 :: forall m. Monad m => m Age
foo2 = coerce $ (return one :: m Int)

foo3 = coerce $ (return one :: IO Int) :: IO Age

foo4 = coerce $ one :: Down Int

foo5 = coerce $ (undefined :: Down Int) :: Down Age

newtype WrapPrivate a = WrapPrivate (Down a)

foo6 = coerce $ WrapPrivate (undefined :: Down Int) :: WrapPrivate Age

data WrapPrivate' a = WrapPrivate' (Down a)

foo7 = coerce $ WrapPrivate' (undefined :: Down Int) :: WrapPrivate' Age

newtype Void a = Void (Void (a,a))

foo8 = coerce :: (Void ()) -> ()

one :: Int
one = 1

main = return ()
