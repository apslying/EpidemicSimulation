%Project 2
%deterministic model of a zombie epidemic
%Eddie (Gyu Myung) Shim, Hengyi Wu, Melody J Duan
 
clear
 
a=.3;               	%rate of infection
delta=.5;           	%rate of infected dying to zombie state
kappa = .6;       	%rate of death for zombies
beta=1;
S=95;              	%initial susceptible
I=5;                	%initial infected
Z=0;                	%initial zombies
D=0;                	%initial dead
R=0;
N=S+I+Z+R;            	%total population


T=100;
dt=1;
clockmax=ceil(T/dt);
 
s=zeros(1,clockmax);	%array to save values of s
i=s;
z=s;
d=s;
r=s;
t=0:dt:(T-dt);
for clock=1:clockmax
	S2I=dt*a*((I+Z)/N)*S; 	%susceptible to infection per dt
	I2Z=dt*delta*I;         	%infected to zombie per dt
	Z2D=dt*kappa*((I+S+R)/N); 	%zombie to death per dt
	S2R=dt*beta;
    
	S=S-S2I-S2R;
	I=I+S2I-I2Z;
	Z=Z+I2Z-Z2D;
	D=D+Z2D;
    R=R+S2R;

    if (S<0)
    	R=R+S2R+S;
        S=0;
        beta=0;
    	
	end
	
	if (Z<0)
    	negativeZ = Z;
    	Z= Z-negativeZ;
    	D= D+negativeZ;
    	
	end
	
	s(clock)=S;
	i(clock)=I;
	z(clock)=Z;
	d(clock)=D;
    r(clock)=R;
end
 
figure(1)
plot(t,s,t,i,t,z,t,d,t,r,'linewidth',2)
%ylim([0 1100]);
legend('(S):susceptible population','(I):infected population','(Z):zombie population', '(D):dead population','(R):recovered population')
