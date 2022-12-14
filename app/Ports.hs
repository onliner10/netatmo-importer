module Ports (GetMeasurements) where

import Core

type GetMeasurements = TimeRange -> IO WeatherReport