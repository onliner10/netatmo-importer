module NetatmoAdapter.Adapter where

import Core
import NetatmoAdapter.Dto as Dto
import Network.HTTP.Simple
import Network.HTTP.Conduit
import Ports

data NetatmoHandle = NetatmoHandle { baseUrl :: String }

newtype DeviceId = DeviceId String
newtype ModuleId = ModuleId String

data NetatmoBaseModule = NetatmoBaseModule { deviceId :: DeviceId, moduleId :: ModuleId }
type NetatmoWeatherStation = Sensor NetatmoBaseModule

getMeasurePath :: String
getMeasurePath = "https://app.netatmo.net/api/getmeasure"

getReadings :: IO Dto.GetMeasureResponse
getReadings = do
  initReq <- parseRequest getMeasurePath
  let req = initReq { method = "POST" }

  response <- httpJSON "https://app.netatmo.net/api/getmeasure"

  putStrLn $ "The status code was: " ++ show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response

  return $ (getResponseBody response :: Dto.GetMeasureResponse)

createGetMeasurements :: Ports.GetMeasurements
createGetMeasurements = undefined