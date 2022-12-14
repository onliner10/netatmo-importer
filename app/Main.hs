module Main where

import NetatmoAdapter as Adapter
import Data.Time.Clock
import Core
import Control.Monad.Trans.Except
import Control.Monad.Trans.Class

getTimeRange :: ExceptT String IO TimeRange
getTimeRange = do
  end <- lift $ getCurrentTime
  let start = addUTCTime (nominalDay * (-1)) end

  timeRange <- except $ createTimeRange start end
  return timeRange

getMeasurements :: ExceptT String IO WeatherReport
getMeasurements = do
  timeRange <- getTimeRange

  result <- lift $ Adapter.getLocalMeasurements timeRange
  return result

printWithPrefix :: (Show a) => String -> a -> IO ()
printWithPrefix prefix result = 
  putStrLn prefix >> (putStrLn $ show result)

handleSuccess :: (Show a) => a -> IO ()
handleSuccess = printWithPrefix "SUCCESS"

handleError :: (Show a) => a -> IO ()
handleError = printWithPrefix "ERROR"

main :: IO ()
main = do
  measurementsE <- runExceptT getMeasurements

  either handleError handleSuccess measurementsE

  putStrLn "-- DONE --"
