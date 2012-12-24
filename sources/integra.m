function q=RK4(step,nSteps,x0,y0,z0,t0);
	x(1)=x0; y(1)=y0; z(1)=z0;
	t=t0:step:(nSteps-1)*step+t0; p2=step/2;
	p6=step/6; 
	for k=2:nSteps;

		n=k-1;
		% ***************************************** 
		Dx1=FunX(t(n),x(n),y(n),z(n)); 
		Dy1=FunY(t(n),x(n),y(n),z(n)); 
		Dz1=FunZ(t(n),x(n),y(n),z(n)); 
		%-------'--primeira previs\'84o h/2 

		Dx2=FunX(t(n)+p2,x(n)+Dx1*p2,y(n)+Dy1*p2,z(n)+Dz1*p2); 
		Dy2=FunY(t(n)+p2,x(n)+Dx1*p2,y(n)+Dy1*p2,z(n)+Dz1*p2); 
		Dz2=FunZ(t(n)+p2,x(n)+Dx1*p2,y(n)+Dy1*p2,z(n)+Dz1*p2);
		% \'f3\'f3	\'f3\'f3\'f3\'f3\'f3\'f3\'f3\'f1primeira corre\'c1\'84o h/2 

		Dx3=FunX(t(n)+p2,x(n)+Dx2*p2,y(n)+Dy2*p2,z(n)+Dz2*p2); 
		Dy3=FunY(t(n)+p2,x(n)+Dx2*p2,y(n)+Dy2*p2,z(n)+Dz2*p2); 
		Dz3=FunZ(t(n)+p2,x(n)+Dx2*p2,y(n)+Dy2*p2,z(n)+Dz2*p2); 
		%\'f3\'f3\'f3\'f3\'f3\'f3\'f3\'f3\'f3\'f3-segunda previs\'84o h 

		Dx4=FunX(t(k),x(n)+Dx3*step,y(n)+Dy3*step,z(n)+Dz3*step); 
		Dy4=FunY(t(k),x(n)+Dx3*step,y(n)+Dy3*step,z(n)+Dz3*step); 
		Dz4=FunZ(t(k),x(n)+Dx3*step,y(n)+Dy3*step,z(n)+Dz3*step); 
		%\'f3\'f3\'f3\'f3\'f3\'f3\'f3\'f3\'f3\'f3-segunda corre\'c1\'84o h 

		x(k)=x(n)+p6*(Dx1+2*Dx2+2*Dx3+Dx4); 
		y(k)=y(n)+p6*(Dy1+2*Dy2+2*Dy3+Dy4); 
		z(k)=z(n)+p6*(Dz1+2*Dz2+2*Dz3+Dz4);
	end; 

	q=[x' y' z']; 
end

function fx=FunX(tt,xx,yy,zz); 
	a=0.08;
	fx=-xx+a*yy+xx*xx*yy;
end;

function fy=FunY(tt,xx,yy,zz); 
	b=0.6;
	a=0.08;
	fy=b-a*yy-xx*xx*yy;
end;

function fz=FunZ(tt,xx,yy,zz);
	fz=0;
end;

nSteps=10^6;
x0=0;
y0=0;
z0=0;
dt=0.01;
tic();
A=RK4(dt, nSteps, x0,y0,z0,0);
toc();

