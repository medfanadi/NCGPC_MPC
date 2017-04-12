clc
clear all
close all


syms  psi Vpsi X Vx Y Vy psi_ref Vpsi_ref dVpsi_ref X_ref Vx_ref dVx_ref Y_ref Vy_ref dVy_ref vit real

syms masse a b d h Cf vit Cr moment Ts real
syms a11 a12 a21 a22 b12 b11 b21 b22 beta_f beta_r Vy Vpsi P N real

% %rigidité de dérive
% Cf=10000;
% Cr=10000;
% 
% %position du cdg
% a=1.2;
% b=1.2;
% 
% %masse et momet d'inertie
% masse=700;
% moment=400*(1.2^2+0.7^2)/12;
% 
% %vitesse
% % vit=5;
% 
% temps de prédiction
Ts=5 ;

% a11=-2*(Cf+Cr)/(masse*vit);
% a12=-2*(a*Cf-b*Cr)/(masse*vit)-vit;
% a21=-2*(a*Cf-b*Cr)/(vit*moment);
% a22=-2*(a^2*Cf+b^2*Cr)/(vit*moment);

b11=P; b12=P;
b21=P; b22=N;

% a11=-2*(Cf+Cr)/(masse*vit);
% a12=-2*(a*Cf-b*Cr)/(masse*vit)-vit;
% a21=-2*(a*Cf-b*Cr)/(vit*moment);
% a22=-2*(a^2*Cf+b^2*Cr)/(vit*moment);
% 
% b11=2*Cf/masse; b12=2*Cr/masse;
% b21=2*a*Cf/moment; b22=-2*b*Cr/moment;

%%
zetah=Vx*Vpsi+a11*Vy+a12*Vpsi;

%%

Ep=[psi-psi_ref;
    Vpsi-Vpsi_ref;
    a21*Vy+a22*Vpsi-dVpsi_ref
    X-X_ref;
    Vx-Vx_ref;
    -zetah*sin(psi)-Vy*Vpsi*cos(psi)-dVx_ref;
    Y-Y_ref;
    Vy-Vy_ref;
    zetah*cos(psi)-Vy*Vpsi*sin(psi)-dVy_ref];
%%

D=[b21 -b22;
    -b11*sin(psi) -b12*sin(psi);
   b11*cos(psi) b12*cos(psi)];

%%
%% matrice de gain
Ki=[10/(3*Ts^2) 10/(4*Ts) 1];

Ki2=[0.1/(3*Ts^2) 0.1/(4*Ts) 1];

ZE=zeros(1,3);

K= [Ki2 ZE ZE;
    ZE Ki2 ZE;
    ZE ZE Ki];

%% Angles de brauage

u=simplify(-inv(D'*D)*D'*K*Ep);




betaf=simplify((u(1,1)))
betar=simplify(u(2,1))
