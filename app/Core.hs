{-# OPTIONS_GHC -Wno-unused-top-binds #-}
module Core (DataPoint, StartTime, EndTime, TimeRange, createTimeRange, WeatherReport, emptyReport) where

import Data.Time
import Data.Metrology
import Data.Units.SI
import Data.HashMap.Lazy

data DataPoint a = DataPoint { value :: a, timeStamp :: UTCTime}

data Rain = Rain ((Meter :/ Hour))deriving (Show)
data Humidity = Humidity (Double) deriving (Show)
data Pressure = Pressure (Pascal) deriving (Show)
data Temperature = Temperature (Kelvin) deriving (Show)
data WindStrength = WindStrength ((Meter :/ Hour)) deriving (Show)
data WindAngle = WindAngle (Degree) deriving (Show)
data GustStrength = GustStrength ((Meter :/ Hour)) deriving (Show)
data GustAngle = GustAngle (Degree) deriving (Show)

type TimeSeries a = HashMap UTCTime a

data WeatherReport = WeatherReport {
    temperature :: TimeSeries Temperature,
    humidity :: TimeSeries Humidity
} deriving (Show)

-- TODO: Remove later
emptyReport :: WeatherReport
emptyReport = WeatherReport{ temperature = empty, humidity = empty}

type StartTime = UTCTime
type EndTime = UTCTime

data TimeRange = TimeRange { from :: StartTime, to :: EndTime} deriving (Show)
createTimeRange :: StartTime -> EndTime -> Either String TimeRange
createTimeRange start end | end >= start = Right $ TimeRange{ from = start, to = end}
createTimeRange _ _ = Left "End time must be >= start time"

