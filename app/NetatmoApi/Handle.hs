module NetatmoApi.Handle where

import NetatmoApi.Dto as Dto
import Network.HTTP.Simple
import Network.HTTP.Conduit



data Measure = Rain | Humidity | Pressure | Temperature | WindStrength | WindAngle | GustStrength | GustAngle

data NetatmoHandle = NetatmoHandle { baseUrl :: String }


getReading :: IO Dto.GetMeasureResponse
getReading = do
  initReq <- parseRequest "https://app.netatmo.net/api/getmeasure"
  let req = initReq { method = "POST" }

  response <- httpJSON "https://app.netatmo.net/api/getmeasure"

  putStrLn $ "The status code was: " ++ show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response

  return $ (getResponseBody response :: Dto.GetMeasureResponse)