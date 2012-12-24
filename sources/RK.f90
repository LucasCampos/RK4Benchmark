        Program RungeKutta4
        Implicit None
        Double Precision, Dimension(:,:), Allocatable :: p
        Double Precision, Dimension(4,3) :: k
        Integer :: nSteps
        Double Precision :: dt
        Integer :: i, un

        un=50
        nSteps = 10**6
        dt=0.01
        Allocate(p(nSteps+1,3))
        p(1,:)=0
        Do i=1,nSteps
                Call Attractor(p(i,:), k(1,:))
                k(1,:)=k(1,:)*dt
                Call Attractor(p(i,:)+0.5*k(1,:), k(2,:))
                k(2,:)=k(2,:)*dt
                Call Attractor(p(i,:)+0.5*k(2,:), k(3,:))
                k(3,:)=k(3,:)*dt
                Call Attractor(p(i,:)+k(3,:), k(4,:))
                k(4,:)=k(4,:)*dt
                p(i+1,:)=p(i,:)+(1.0/6.0)*(k(1,:)+k(2,:)*2+k(3,:)*3+k(4,:))
        EndDo

        !Open(unit=un, file="trajFortran.dat", action='write')

        !Do i=1,nSteps
        !        write(un,*) p(i,:)
        !EndDo
        
        Contains

        Subroutine Attractor (p, newP)
        Implicit None
        Double Precision, Intent(In), Dimension(3) :: p
        Double Precision, Intent(Out), Dimension(3) :: newP
        Double Precision :: a, b
        a=0.08
        b=0.6
        newP(1) = -p(1)+a*p(2)+p(1)*p(1)*p(2)
        newP(2) = b-a*p(2) - p(2)*p(1)**2
        newP(3) = 0
        EndSubroutine

        EndProgram
