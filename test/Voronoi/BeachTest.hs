module Voronoi.BeachTest
( newRaysEmitFromCenter
, awayRayPerpendicular
) where

import Test.QuickCheck
import Geometry.Vector
import Voronoi.Beach
import Voronoi.Event
import Voronoi.Edge
import Geometry.Angle

instance Arbitrary Bouy where
  arbitrary = Bouy <$> arbitrary <*> arbitrary
  
newRaysEmitFromCenter :: Position -> Bouy -> Bouy -> Bouy -> Bool
newRaysEmitFromCenter p b1 b2 b3 = length rs == 3 && and (fmap (\r -> pos r == p) rs)
  where
    rs = newRays p b1 b2 b3

awayRayPerpendicular :: Position -> Position -> Position -> Position -> Property
awayRayPerpendicular o a p q = (o /= a && o /= p && o /= q) ==> (separation (awayRay o a p q) (direction (p |- q)) == Orthogonal)