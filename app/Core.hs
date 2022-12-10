module Core where

import Data.Time
import Data.Metrology
import Data.Units.SI

newtype DeviceId = DeviceId String
newtype ModuleId = ModuleId String

data MeasurementType = Rain | Humidity | Pressure | Temperature | WindStrength | WindAngle | GustStrength | GustAngle

data DataPoint a = DataPoint { value :: a, timeStamp :: UTCTime}
data Measurement = 
    MeasuredRain (DataPoint (Meter :/ Hour)) 
    -- TODO: Represent it with a constrained type
    | MeasuredHumidity (DataPoint Double) 
    | MeasuredPressure (DataPoint Pascal) 
    | MeasuredTemperature (DataPoint Kelvin) 
    | MeasuredWindStrength (DataPoint (Meter :/ Hour)) 
    | MeasuredWindAngle (DataPoint Degree) 
    | MeasuredGustStrength (DataPoint (Meter :/ Hour)) 
    | MeasuredGustAngle (DataPoint Degree) 

type StartTime = UTCTime
type EndTime = UTCTime

data TimeRange = TimeRange { from :: StartTime, to :: EndTime}
createTimeRange :: StartTime -> EndTime -> Either String TimeRange
createTimeRange start end | end >= start = Right $ TimeRange{ from = start, to = end}
createTimeRange _ _ = Left "End time must be >= start time"

