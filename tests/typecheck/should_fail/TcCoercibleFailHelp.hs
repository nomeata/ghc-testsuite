module TcCoercibleFailHelp (Private, mkPrivate) where

mkPrivate = Private

newtype Private a = Private a
