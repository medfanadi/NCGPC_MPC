clc
close all 
clear all
syms a11 a12 a21 a22 b12 b11 b21 b22 beta_f beta_r Vy Vpsi real

A=[a11 a12; a21 a22];
B=[b11 -b12;-b21 b22];
v=[Vy; Vpsi];
beta=[beta_f;beta_r];
dV=A*v+B*beta
