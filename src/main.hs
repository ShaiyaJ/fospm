module Main
where

import System.Console.Haskeline
import Data.Maybe
import Data.Bits
import Data.Char
import Data.List

-- Password generator

---- Converts the characters between a very specific clamped range that is more common to use in passwords - removing unprintable values
toChar :: Int -> Int -> Int -> Char
toChar x base range =  chr (base + (x `mod` range))

toLevelOnePass :: Int -> Char
toLevelOnePass x =  toChar x base range
                    where
                        base  = 0x21
                        range = 0x7E - base + 1

toLevelTwoPass :: Int -> Char
toLevelTwoPass x =  toChar x base range
                    where
                        base  = 0x2A
                        range = 0x7A - base + 1

toLevelThreePass :: Int -> Char
toLevelThreePass x =    toChar x base range
                        where
                            base  = 0x41
                            range = 0x7A - base + 1

---- Calculates a single character by taking (serviceName[i] % userName[i]) and folding an xor onto this value using the whole master password
calculateServiceChar :: String -> Char -> Char -> Int
calculateServiceChar masterPassword serviceC userC =    let v       = (ord serviceC) `mod` (ord userC)
                                                            intMp   = map ord masterPassword
                                                        in  foldl' (\newv passC -> newv `xor` passC) v intMp

---- Calls calculateServiceChar for every character in the password
calculateServicePassword :: String -> String -> String -> [Int]
calculateServicePassword masterPassword serviceName userName =  let sizedServiceName = take 30 (cycle serviceName)
                                                                    sizedUserName    = take 30 (cycle userName)
                                                                in zipWith (calculateServiceChar sizedServiceName) sizedServiceName sizedUserName

-- IO related section

applyAccountInfo :: String -> String -> String -> InputT IO ()
applyAccountInfo masterPassword serviceName userName = do   let password = calculateServicePassword masterPassword serviceName userName

                                                            outputStr $ "  Wide range password: "
                                                            outputStrLn $ map toLevelOnePass password

                                                            outputStr $ " Lower range password: "
                                                            outputStrLn $ map toLevelTwoPass password

                                                            outputStr $ "Lowest range password: "
                                                            outputStrLn $ map toLevelThreePass password
                                                            outputStrLn ""

                                                            -- loop
                                                            getAccountInfo masterPassword


getAccountInfo :: String -> InputT IO ()
getAccountInfo masterPassword = do  serviceName <- getInputLine "Service name (\"quit\" to quit): "
                                    let serviceNameInner = fromJust serviceName

                                    if serviceNameInner == "quit"
                                    then outputStrLn "Quitting..." 
                                    else do userName <- getInputLine "Username: "
                                            applyAccountInfo masterPassword serviceNameInner (fromJust userName)
                        

main :: IO()
main =  runInputT defaultSettings $ do  p <- getPassword (Just '*') "Master password: "
                                        getAccountInfo $ fromJust p

