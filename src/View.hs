module View
  ( View(..)
  )
where

import Model
import Geometry.Vector
import Struct

data View c = View
  { structOrModel :: Either (Struct c) (Model c)
  , center :: Position
  , zoom :: Double
  }

instance HasPos (View c) where
  pos = center