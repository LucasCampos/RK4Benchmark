import Data.List
import System.IO
import qualified Data.Vector.Unboxed as V

xversor = Vector(1.0,0.0,0.0)
yversor = Vector(0.0,1.0,0.0)
zversor = Vector(0.0,0.0,1.0)
nullVector = Vector(0.0,0.0,0.0)

sumV (Vector (x1, x2, x3)) (Vector (y1, y2, y3)) = Vector(x1+y1, x2+y2, x3+y3)

multScalar a (Vector(x,y,z)) = Vector(x*a,y*a,z*a)

showVector :: (Show a) => Vector a -> String
showVector (Vector(x,y,z)) = (show x) ++ "  " ++ (show y) ++ "  " ++ (show z)

rk4 f h x = sumV x $(multScalar (1.0/6.0) ks)
	where 	k1 = multScalar h $f (x)
		k2 = multScalar h $f (x `sumV` (0.5 `multScalar`k1))
		k3 = multScalar h $f (x `sumV` (0.5 `multScalar`k2))
		k4 = multScalar h $f (x `sumV` k3)
		ks = foldl' sumV nullVector [k1,2.0`multScalar`k2,2.0`multScalar`k3,k4]

fullRK4 f h nSteps x0 = take nSteps $iterate (rk4 f h) x0

attractor (Vector(x,y,z)) = Vector(xn, yn, zn)
	where 	a=0.08
		b=0.6
		xn = -x+a*y+x*x*y
		yn = b-a*y-x*x*y
		zn = 0

main = do 
	let dt = 0.01
	let nSteps = 10^6
	let traj = fullRK4 attractor dt nSteps nullVector
	putStrLn (show (traj!!(nSteps-1)))
	--let b=  map showVector traj
	--handle <- openFile "trajHaskell.dat" WriteMode
	--mapM_ (hPutStrLn handle)  b

