%% Scripte de déplacelemnt du robot 


%% Clean up the workspace and existing figures
clear all; 
close all;
clc;


%% Simulation selon le Type de la trajectoire (rectiligne, ciculaire sinusoidale)
X0_rectiligne=[0 0 -pi/3*0.8 6*cos(-pi/3*0.8) 6*sin(-pi/3*0.8) 0];  %condition initiale cas DROITE
X0_circulaire=[60 0 0.8*pi/2 0 5 5/60]; %condition initiale cas CIRCLE

sim('NCGPC_droite',50);


%% Paramètres du robot
%coef graphique (d'agrondissement du robot)
coef=17;

% le robot
a=1.200*coef; %Empatement avant
b=1.200*coef; % Empattement arrière
l=1.500*coef;  % largeur

% les roues
r=0.500*coef; 
e=0.200*coef; % rayon et epaisseur


%% Conditions Initiales

% XPOS=0;
% YPOS=0;
% psi=0;

%% Angles de braquages

figure;
plot(temps,beta(:,1),'b','LineWidth',3)
hold on;
plot(temps,beta(:,2),'r--','LineWidth',3)
grid on
xlabel('temps(s)');
ylabel('angle de braquage (rad)');
legend('beta-f','beta_r');

%% affichage et trace des trajectoires de réf et calculé 

% Lecture des donnée du Simulink 

x_ref(:,1)=posref(1,1,:);

y_ref(:,1)=posref(1,2,:);

psi_ref(:,1)=posref(1,3,:);

x_cal(:,1)=pos_cal(1,1,:);

y_cal(:,1)=pos_cal(1,2,:);

psi_cal(:,1)=pos_cal(1,3,:);

%% erreur

figure;
plot(temps,y_ref(:,1)-y_cal(:,1),'b','LineWidth',3)
grid on
xlabel('temps(s)');
ylabel('erreur latérale (m)');
title('erreure latérale (m)');

figure;
plot(temps,psi_ref(:,1)-psi_cal(:,1),'b','LineWidth',3)
grid on
xlabel('temps(s)');
ylabel('erreur angulaire (rad)');
title('erreure angulaire (rad)');
%% qques réglages graphiques
x=zeros(1,5);
y=zeros(1,5);

figure;

h2=plot(x,y,'-');

hold on

h1=plot(x_cal,y_cal,'r--','LineWidth',3); % Trajectoire calculée

hold on

h3=plot(x_ref,y_ref,'b-','LineWidth',3);   % Trajectoire de référence


axis([-200 200 -200 200]);
axis square;
grid on;

set(h2,'EraseMode','xor','LineWidth',2);
set(h1);
set(h3);
xbel=xlabel('x(m)','FontWeight','bold');
ybel=ylabel('y(m)','FontWeight','bold');
legend('Robot','trajéctoire-cal','trajéctoire-réf');
set(xbel);
set(ybel);  

for i=1:length(beta)

    %% Lecture des données importées à partir Simulink (beta, POS_cal, POS_ref)
    
    XPOS=x_cal(i,1);
    YPOS=y_cal(i,1);
    psi=pos_cal(1,3,i);
    betaf=beta(i,1);
    betar=beta(i,2);
    
    %% Calcul des points graphiques du robot
    
    %La roue (wheel rear right)
    RX11=[0,r,r,-r,-r,0];
    RY11=[0,0,-e,-e,0,0];
 
    mat_r=[cos(betar),-sin(betar);sin(betar),cos(betar)];


    auxiR1=mat_r*[RX11;RY11];RX1=auxiR1(1,:); RY1=auxiR1(2,:);
    
    %La roue (wheel rear left)
    RX22=[0,r,r,-r,-r,0];
    RY22=[0,0,e,e,0,0];
    


    auxiR2=mat_r*[RX22;RY22];RX2=auxiR2(1,:); RY2=auxiR2(2,:);
    
    %La roue (wheel front right)
    RX33=[0,r,r,-r,-r,0];
    RY33=[0,0,e,e,0,0];
    
    mat_f=[cos(betaf),-sin(betaf);sin(betaf),cos(betaf)];


    auxiF1=mat_f*[RX33;RY33];RX3=auxiF1(1,:); RY3=auxiF1(2,:);
    
    
    %La roue (wheel front left)
    RX44=[0,r,r,-r,-r,0];
    RY44=[0,0,-e,-e,0,0];
    


    auxiF2=mat_f*[RX44;RY44];RX4=auxiF2(1,:); RY4=auxiF2(2,:);
 
   % Graphe de robot
    auxX=[RX1-a,RX2-a,RX3+b,RX4+b,-a];
    auxY=[RY1-l/2+e/2,RY2+l/2-e/2,RY3+l/2-e/2,RY4-l/2+e/2,-l/2+e/2];
    
   %% calcul déplacement du robot à chaque instant 
   
    ROT = [cos(psi),-sin(psi);sin(psi),cos(psi)];
    
    auxi=ROT*[auxX;auxY]+[XPOS*ones(1,size(auxX,2));YPOS*ones(1,size(auxX,2))]; 

    PRX=auxi(1,:); 
    PRY=auxi(2,:);
    
    %% Plot du robot
    set(h2,'XData',PRX,'YData',PRY);
    
    pause(0.008);
    
end