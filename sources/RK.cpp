#include <cstdlib>
#include <cmath>
#include <vector>
#include <sstream>
#include <fstream>

class Vector3D {
	private:
		double w;
	public:
		double x,y,z;

		Vector3D(): x(0),y(0),z(0){};
		Vector3D(double _x, double _y, double _z): x(_x), y(_y), z(_z) {};
		
		void SetElem(int i, double a) {
			switch(i) {
				case 0: x=a; break;
				case 1: y=a; break;
				case 2: z=a; break;
			}
		}

		Vector3D Sum(const Vector3D& v) const {
			return Vector3D(x+v.x, y+v.y, z+v.z);
		}

		Vector3D Subtract(const Vector3D& v) const {
			return Vector3D(x-v.x, y-v.y, z-v.z);
		}
		
		double InternalProduct(const Vector3D& v) const{
			return x*v.x+y*v.y+z*v.z;
		}

		double MagnitudeSquared() const{
			return InternalProduct((*this));
		}

		double Magnitude() const{
			return sqrt(MagnitudeSquared());
		}

		Vector3D Normalize() const{
			double mag = Magnitude();
			return Vector3D(x/mag, y/mag, z/mag);
		}

		Vector3D VectorialProduct(const Vector3D& v) const{
			return Vector3D(y*v.z - z*v.y,
					z*v.x - x*v.z,
					x*v.y - y*v.x);
		}

		Vector3D MultScalar(double a) const{
			return Vector3D(a*x, a*y, a*z);
		}

		Vector3D operator+ (const Vector3D& v) const{
			return Sum(v);
		}

		Vector3D operator- (const Vector3D& v) const{
			return Subtract(v);
		}

		double operator* (const Vector3D& v) const{
			return InternalProduct(v);
		}

		Vector3D operator^ (const Vector3D& v) const{
			return VectorialProduct(v);
		}

		Vector3D operator* (double a) const{
			return MultScalar(a);
		}

		Vector3D operator/ (double a) const{
			return MultScalar(1.0/a);
		}

		Vector3D& operator+= (const Vector3D& v) {
			x+=v.x;
			y+=v.y;
			z+=v.z;
			return (*this);
		}

		Vector3D& operator-= (const Vector3D& v) {
			x-=v.x;
			y-=v.y;
			z-=v.z;
			return (*this);
		}

		Vector3D& operator*= (double a) {
			x*=a;
			y*=a;
			z*=a;
			return (*this);
		}


		friend std::ostream& operator<<(std::ostream& stream,const Vector3D& v){

			stream << v.x << "   " << v.y << "   " << v.z << "   ";
			return stream;
		}
		
};

using namespace std;

Vector3D Attractor(const Vector3D& p) {
	const double a=0.08;
	const double b=0.6;
	
	return Vector3D(-p.x+a*p.y+p.x*p.x*p.y, b-a*p.y-p.y*p.x*p.x , 0);
}

int main() {

	const int nSteps = 1e6;
	const double dt = 0.01;
	Vector3D *traj = new Vector3D[nSteps+1];
	Vector3D k1,k2,k3,k4;
	//ofstream saida("trajCPP.dat");
	
	for (int i=0; i< nSteps; i++) {
		k1= Attractor(traj[i])*dt;
		k2= Attractor(traj[i]+k1*0.5)*dt;
		k2= Attractor(traj[i]+k2*0.5)*dt;
		k4= Attractor(traj[i]+k4)*dt;
		traj[i+1]=traj[i]+(k1+ k2*2.0 + k3*2.0 +k4)*(1.0/6.0);
	}
	//for (int i=0; i< nSteps; i++) 
	//	saida << traj[i] << endl;
}
