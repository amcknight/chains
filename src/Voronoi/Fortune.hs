module Voronoi.Fortune
( voronoi
) where

import Geometry.Vector
import Debug.Trace
import Geometry.Line
import Geometry.Bound
import Voronoi.Beach
import Geometry.Angle
import Geometry.CrossPoint
import Voronoi.Edge
import qualified Data.Vector as V
import Data.List (sortOn)
import qualified Data.List.Index as I
import Utils

voronoi :: [Position] -> [Edge]
voronoi [p,q] = voronoi2 p q
voronoi ps
  | allColinear ps = voronoiColinear ps
  | otherwise = edgesFromRays (bufferedBound ps 1) $ voronoi' $ initialBeach ps

voronoi' :: Beach -> [Ray]
voronoi' b@(Beach _ _ [] bs rs) = rs
voronoi' b = voronoi' $ updateBeach b

voronoi2 :: Position -> Position -> [Edge]
voronoi2 p q = [Edge (midEdge p q) (0,1)]

voronoiColinear :: [Position] -> [Edge]
voronoiColinear ps
  | allEq (fmap fst ps) = zipWith iPosToEdge spsY (tail spsY)
  | otherwise = zipWith iPosToEdge spsX (tail spsX)
  where
    iPosToEdge :: (Int, Position) -> (Int, Position) -> Edge
    iPosToEdge (i1,p1) (i2,p2) = Edge (midEdge p1 p2) (i1,i2)
    spsX = sortOn (fst . snd) (I.indexed ps)
    spsY = sortOn (snd . snd) (I.indexed ps)

midEdge :: Position -> Position -> Seg
midEdge p q = case unsidedRayCrossBound b m d of
  TwoCross p1 p2 -> Seg p1 p2
  _ -> error "Segment must exist"
  where
    b = bufferedBound [p,q] 1
    m = mid p q
    d = simple $ 0.25 + direction (p |- m)
    