module Ball
( Ball (..)
, buildBall
, buildBalls
, extractOrb
) where

import Pair
import Point
import Time
import Orb
import Geometry.Vector
import Utils

data Ball c = Ball
  { point :: Point
  , chem :: c
  } deriving Show

instance HasPos (Ball c) where
  pos = pos . point

instance Mover (Ball c) where
  move dt (Ball p c) = Ball (move dt p) c

buildBall :: Speed -> Orb c -> R (Ball c)
buildBall sp (Orb p c) = do
  v <- randomV sp
  pure $ Ball (Point p v) c

buildBalls :: P Point -> P a -> P (Ball a)
buildBalls (p1, p2) (c1, c2) = (Ball p1 c1, Ball p2 c2)

extractOrb :: Ball c -> Orb c
extractOrb (Ball (Point pos _) c) = Orb pos c
