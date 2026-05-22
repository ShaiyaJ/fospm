module Main
where

import System.Console.Haskeline
import Data.Maybe
import Data.Bits
import Data.Char
import Data.List

-- Password generator

---- Converts the characters between a very specific clamped range that is more common to use in passwords - removing unprintable values
toChar :: Int -> Char
toChar x =  chr (base + (x `mod` range))
            where
                base  = 0x23
                range = 0x7E - base + 1

---- Calculates a single character by taking (serviceName[i] % userName[i]) and folding an xor onto this value using the whole master password
calculateServiceChar :: String -> Char -> Char -> Char
calculateServiceChar masterPassword serviceC userC =    let v       = (ord serviceC) `mod` (ord userC)
                                                            intMp   = map ord masterPassword
                                                        in toChar (foldl' (\newv passC -> newv `xor` passC) v intMp)

---- Calls calculateServiceChar for every character in the password
calculateServicePassword :: String -> String -> String -> String
calculateServicePassword masterPassword serviceName userName =  let sizedServiceName = take 30 (cycle serviceName) -- TODO: could do the modding here? that would look cleaner
                                                                    sizedUserName    = take 30 (cycle userName)
                                                                in zipWith (calculateServiceChar sizedServiceName) sizedServiceName sizedUserName

-- IO related section

applyAccountInfo :: String -> String -> String -> InputT IO ()
applyAccountInfo masterPassword serviceName userName = do   outputStrLn $ calculateServicePassword masterPassword serviceName userName
                                                            getAccountInfo masterPassword


getAccountInfo masterPassword = do  serviceName <- getInputLine "Service name (\"quit\" to quit): "
                                    let serviceNameInner = fromJust serviceName

                                    if serviceNameInner == "quit"
                                    then outputStrLn "Quitting..." 
                                    else do userName <- getInputLine "Username: "
                                            applyAccountInfo masterPassword serviceNameInner (fromJust userName)
                        

main :: IO()
main =  runInputT defaultSettings $ do  p <- getPassword (Just '*') "Master password: "
                                        getAccountInfo $ fromJust p

