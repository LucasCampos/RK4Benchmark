echo "===================HASKELL=================="
for OPT in $(seq 0 3); do
	echo "=======O$OPT========"
	ghc sources/RK.hs -o RKHas -rtsopts -O$OPT
	time ./RKHas +RTS -K900000000000 -RTS
done

echo "===================FORTRAN=================="
for OPT in $(seq 0 3); do
	echo "=======O$OPT========"
	gfortran sources/RK.f90 -o RKF -O$OPT
	time ./RKF
done

echo "=====================C++===================="
for OPT in $(seq 0 3); do
	echo "=======O$OPT========"
	g++ sources/RK.cpp -o RKCpp -O$OPT
	time ./RKCpp
done

echo "===================JULIA===================="
julia sources/RK.jl

#echo "===================OCTAVE=================="
#octave -qf sources/integra.m
