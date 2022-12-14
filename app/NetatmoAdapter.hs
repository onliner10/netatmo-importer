module NetatmoAdapter (getLocalMeasurements) where

import Core
import Ports

getLocalMeasurements :: GetMeasurements 
getLocalMeasurements timeRange = 
  do
    print timeRange
    return emptyReport