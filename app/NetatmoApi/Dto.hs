module NetatmoApi.Dto (GetMeasureResponse, GetMeasureRequest, Measure) where

import Data.Aeson.Types
import System.Posix.Types

data MeasureType = Rain | Humidity | Pressure | Temperature | WindStrength | WindAngle | GustStrength | GustAngle

data Measure = Measure { begtime :: EpochTime, values :: [Double]}
data GetMeasureResponse = GetMeasureResponse { body :: [Measure], status :: String }
data GetMeasureRequest = GetMeasureRequest { 
  dateBegin :: EpochTime,
  dateEnd :: EpochTime, 
  scale :: String, 
  deviceId:: String, 
  moduleId:: String, 
  types :: [MeasureType] }

instance FromJSON Measure where
  parseJSON (Object o) = Measure <$> 
    o .: "beg_time" <*>
    o .: "value"

  parseJSON invalid = prependFailure "parsing Measure failed, " (typeMismatch "Object" invalid)

instance FromJSON GetMeasureResponse where
  parseJSON (Object o) = GetMeasureResponse <$> 
    o .: "body" <*>
    o .: "status"

  parseJSON invalid = prependFailure "parsing GetMeasureResponse failed, " (typeMismatch "Object" invalid)

