import Base.(*)
import Base.(+)
import Base.(-)
import Base.println
import Base.print
import Base.write
import Base.open

type Vector3D{T<:Real}
x::T
y::T
z::T
end

##############################VECTOR FUNCTIONS################################

function InternalProduct(v::Vector3D, u::Vector3D)
    return v.x*u.x+v.y*u.y+v.z*u.z
end
 
function NormSquared(v::Vector3D)
    return InternalProduct(v,v)
end
 
function Norm(v::Vector3D)
    return sqrt(Norm)
end
 
function +(v::Vector3D, u::Vector3D)
    return Vector3D(v.x+u.x, v.y+u.y, v.z+u.z)
end
 
function -(v::Vector3D)
    return Vector3D(-v.x, -v.y,-v.z);
end
 
function -(v::Vector3D, u::Vector3D)
        return v+(-u)
end
 
function *(v::Vector3D,a::Real)
    return Vector3D(v.x*a, v.y*a, v.z*a)
end

function *(a::Real,v::Vector3D)
    return Vector3D(v.x*a, v.y*a, v.z*a)
end
 
function *(v::Vector3D, u::Vector3D)
    return InternalProduct(v,u)
end
 
function print(v::Vector3D)
	print("$(v.x)    $(v.y)    $(v.z)")
end

function write(io,v::Vector3D)
	write(io,"$(v.x)    $(v.y)    $(v.z)")
end

function writeln(io,v::Vector3D)
	write(io,"$(v.x)    $(v.y)    $(v.z)\n")
end
 
function println(v::Vector3D)
	println("$(v.x)    $(v.y)    $(v.z)")
end

######################################################################

#Fourth order Runge-Kutta
function RK4(v::Vector3D, dt::Real, Force::Function)
    k1 = Force(v)*dt;
    k2 = Force(v+0.5*k1)*dt;
    k3 = Force(v+0.5*k2)*dt;
    k4 = Force(v+k3)*dt;
   
    return v+(k1+(k2+k3)*2+k4)*(1.0/6.0);

end
 
#Function to integrate
function Attractor(p::Vector3D)
	a=0.08;
	b=0.6;
	xn = a*p.y+p.x*p.x*p.y-p.x;
	return Vector3D(xn, b-a*p.y-p.y*p.x*p.x , 0.0);

end;

######################Main part of the program########################

function main()
	p=Vector3D(0.0,0.0,0.0)

	dt = 0.01;
	nSteps = 10^6;
#file=open("trajJulia.dat","w");

	@time for i=1:nSteps
	    p=RK4(p,dt,Attractor);
#	    writeln(file,p);
	end
end;

main();
