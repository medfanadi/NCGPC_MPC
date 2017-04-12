%% paramètres générals du spido
M=900; %Kg
a=1.1; %m demi_largeur
b=1.1; %m
d=0.75; %m demi-longueur
h=1.114; %m hauteur
Vxmax=15; %m/s
Cf=1500; % rigidité de dérive avant  1500-15000
Cr=1500; % rigidité de dérive arrière  1500-15000
beta_max=0.698; % angle de braquage max
Iz=1300; %kg.m2
Ts=0.5;  %horizon de prédiction 


%capp=pi/4;

%A1=[(2*(Cf+Cr))/(M*Vx) (2*(a*Cf-b*Cr))/(M*Vx)-Vx;(2*(a*Cf-b*Cr))/(Iz*Vx) (2*(a^2*Cf-b^2*Cr))/(Iz*Vx)];
%B1=[-2*Cf/M -2*Cr/M;-2*a*Cf/Iz 2*b*Cr/Iz];

syms  cap dcap X Vx Y Vy Cap_ref dCap_ref ddCap_ref X_ref Vx_ref dVx_ref Y_ref Vy_ref dVy_ref real

Vx=5 %m/s
A1=[(2*(Cf+Cr))/(M*Vx) (2*(a*Cf-b*Cr))/(M*Vx)-Vx;(2*(a*Cf-b*Cr))/(Iz*Vx) (2*(a^2*Cf-b^2*Cr))/(Iz*Vx)];
B1=[-2*Cf/M -2*Cr/M;-2*a*Cf/Iz 2*b*Cr/Iz];

b11=B1(1,1); b12=B1(1,2); b22 =B1(2,2);b21=B1(2,1); a11=A1(1,1); a12=A1(1,2); a21=A1(2,1); a22=A1(2,2);
D=[b21 b22;-b11*sin(cap) -b12*sin(cap);b11*cos(cap) b12*cos(cap)];


K=[10/3*Ts^2 0 0 0 0 0 0 0 0;0 0 0 10/4*Ts 0 0 0 0 0;0 0 0 0 0 0 1 0 0];
xi_h=Vx*dcap+a11*Vy+a12*dcap;
E=[cap-Cap_ref;dcap-dCap_ref;a21*Vy+a22*dcap-ddCap_ref;X-X_ref;Vx*cos(cap)-Vy*sin(cap)-Vx_ref;-xi_h*sin(cap)-Vy*dcap*cos(cap)-dVx_ref;  Y-Y_ref;Vx*sin(cap)+Vy*cos(cap)-Vy_ref;-xi_h*cos(cap)-Vy*dcap*sin(cap)-dVy_ref];



U=simplify(-inv(D'*D)*D'*K*E);
u1=simplify(U(1,1))
u2=simplify(U(2,1))

%Vx=5  %m/s

