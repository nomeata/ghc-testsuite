import Debug.Trace

myMap :: (a -> a) -> [a] -> [a]
myMap h x = trace "not ok" (map h x)
{-# NOINLINE myMap #-}

{-# RULES "myMap id" myMap (\x -> x) = id #-}

main = do
    putStrLn "myMap id: "
    putStr $ myMap id ""
    putStrLn "myMap (\\x -> x): "
    putStr $ myMap (\x -> x) ""
