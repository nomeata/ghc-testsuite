{-# LANGUAGE RoleAnnotations, RankNTypes, ScopedTypeVariables #-}

import GHC.Prim (coerce)
import GHC.Types (Coercible)
import TcCoercibleFailHelp

newtype Age = Age Int deriving Show

data Map a@N b = Map a b deriving Show

foo1 = coerce $ one :: ()

foo2 :: forall m. Monad m => m Age
foo2 = coerce $ (return one :: m Int)

foo3 = coerce $ (return one :: IO Int) :: IO Age

foo4 = coerce $ one :: Private Int

foo5 = coerce $ mkPrivate one :: Private Age

newtype WrapPrivate a = WrapPrivate (Private a)

foo6 = coerce $ WrapPrivate (mkPrivate one) :: WrapPrivate Age

data WrapPrivate' a = WrapPrivate' (Private a)

foo7 = coerce $ WrapPrivate' (mkPrivate one) :: WrapPrivate' Age

one :: Int
one = 1

main = return ()
