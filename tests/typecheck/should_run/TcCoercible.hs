{-# LANGUAGE RoleAnnotations #-}

import GHC.Prim (coerce)
import GHC.Types (Coercible)

newtype Age = Age Int deriving Show
newtype Foo = Foo Age deriving Show
newtype Bar = Bar Age deriving Show
newtype Baz = Baz Bar deriving Show

data Map a@N b = Map a b deriving Show

main = do
    print (coerce $ one                       :: Age)
    print (coerce $ Age 1                     :: Int)
    print (coerce $ Baz (Bar (Age 1))         :: Foo)

    print (coerce (id::Bar->Bar) (Age 1)      :: Foo)
    print (coerce Baz (Age 1)                 :: Foo)
    print (coerce $ (Age 1, Foo (Age 1))      :: (Baz, Baz))

    print (coerce $ Map one one               :: Map Int Age)

  where one = 1 :: Int



