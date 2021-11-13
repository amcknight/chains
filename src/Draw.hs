module Draw
( toTranslate
, toScale
, toLine, toPolygon
, toArcSolid
, toCircle, toCircleSolid
) where
import Geometry.Vector
import Graphics.Gloss
import Pair

toTranslate :: Position -> Picture -> Picture
toTranslate = uncurry translate . pmap realToFrac

toScale :: Double -> Double -> Picture -> Picture
toScale x y = scale (realToFrac x) (realToFrac y)

toLine :: [Position] -> Picture
toLine = line . fmap (pmap realToFrac)

toPolygon :: [Position] -> Picture
toPolygon = polygon . fmap (pmap realToFrac)

toArcSolid :: Double -> Double -> Double -> Picture
toArcSolid f t rad = arcSolid (realToFrac f) (realToFrac t) (realToFrac rad)

toCircle :: Double -> Picture
toCircle = circle . realToFrac

toCircleSolid :: Double -> Picture
toCircleSolid = circleSolid . realToFrac
