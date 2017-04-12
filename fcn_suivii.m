function [bet_f,bet_r] = fcn_suivii(x,y,cap,x_ref,y_ref,cap_ref)

%%
M=900; %Kg
a=1.1; %m demi_largeur
b=1.1; %m
d=0.75; %m demi-longueur
h=1.114; %m hauteur
Vxmax=15; %m/s

%%
Cf=2500; % rigidité de dérive avant  1500-15000
Cr=1500; % rigidité de dérive arrière  1500-15000
beta_max=0.698; % angle de braquage max
%%
Iz=1300; %kg.m2
Ts=0.5;  %horizon de prédiction 
% %% Matrice modèle dynamique non linèaires 
% A1=[(2*(Cf+Cr))/(M*vx) (2*(a*Cf-b*Cr))/(M*vx)-vx;(2*(a*Cf-b*Cr))/(Iz*vx) (2*(a^2*Cf+b^2*Cr))/(Iz*vx)];
% B1=[-2*Cf/M -2*Cr/M;-2*a*Cf/Iz 2*b*Cr/Iz];
% 
% 
% %% Matrice de découplage 
% b11=B1(1,1); b12=B1(1,2); b22 =B1(2,2);b21=B1(2,1); a11=A1(1,1); a12=A1(1,2); a21=A1(2,1); a22=A1(2,2);
% D=[b21 b22;-b11*sin(cap) -b12*sin(cap);b11*cos(cap) b12*cos(cap)];
% 
% 
% %% Matrice de gain
% K=[10/3*Ts^2 0 0 0 0 0 0 0 0;0 0 0 10/4*Ts 0 0 0 0 0;0 0 0 0 0 0 1 0 0];
% 
% %% XI
% xi_h=vx*dcap+a11*vy+a12*dcap;
% 
% 
% %% Vecteur erreur 
% 
% E=[cap-cap_ref;dcap-dcap_ref;a21*vy+a22*dcap-ddcap_ref;x-x_ref;vx*cos(cap)-vy*sin(cap)-vx_ref;-xi_h*sin(cap)-vy*dcap*cos(cap)-dvx_ref;  y-y_ref;vx*sin(cap)+vy*cos(cap)-vy_ref;-xi_h*cos(cap)-vy*dcap*sin(cap)-dvy_ref];
% 
% %% Commande CPNLG
% 
% 
% U=simplify(-inv(D'*D)*D'*K*E);
% u1=simplify(U(1,1))
% u2=simplify(U(2,1))


bet_f=(20*Iz*Ts^2*cap - 20*Iz*Ts^2*cap_ref + 6*M*b*y*cos(cap) - 6*M*b*y_ref*cos(cap) - 15*M*Ts*b*x*sin(cap) + 15*M*Ts*b*x_ref*sin(cap))/(12*Cf*(a + b));


bet_r=-(20*Iz*Ts^2*cap - 20*Iz*Ts^2*cap_ref - 6*M*a*y*cos(cap) + 6*M*a*y_ref*cos(cap) + 15*M*Ts*a*x*sin(cap) - 15*M*Ts*a*x_ref*sin(cap))/(12*Cr*(a + b));



end

