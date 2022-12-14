module NetatmoAdapter (getLocalMeasurements) where

import Core
import Ports
import Data.Time
import System.Posix.Types
import Data.Time.Clock.POSIX

utcTimeToEpochTime :: UTCTime -> EpochTime
utcTimeToEpochTime = fromIntegral . toSecs
  where
    toSecs :: UTCTime -> Int
    toSecs = round . utcTimeToPOSIXSeconds

getLocalMeasurements :: GetMeasurements 
getLocalMeasurements timeRange = 
  do
    let startEpoch = utcTimeToEpochTime $ rangeStart timeRange
    let endEpoch = utcTimeToEpochTime $ rangeEnd timeRange

    putStrLn "Start epoch"
    print startEpoch

    putStrLn "End epoch"
    print endEpoch
    
    return emptyReport