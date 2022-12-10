module Ports (GetMeasurements) where

import Core
import Data.List.NonEmpty

type GetMeasurements = TimeRange -> NonEmpty MeasurementType -> IO [Measurement]