%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 7, Problem 4 (Sayali Kedari)

%% Problem Description: Solving for the system of linear equations by Cramer's rule

clear; clc; close all

%% Inputs

% Differential equation
% 0 = D*d^c/dx^2 - U*dc/dx - kc
% where c=concentration, t=time, x=distance,D=diffusion coefficient,
% U = fluid velocity, and k = a first-order decay rate
D=2;
U=1;
k=0.2;
% c(0)=80;
c_init=80;
% c(10)=10;
c_finl = 10;
delx = 1; %using dx=1
x=0:delx:10;

% Writing derivatives
% dcdx = (c(x+delx) - c(x))./delx = (c(x+delx) - c(x));
% d2cdx2 = (c(x+delx) - 2*c(x) + c(x-delx))./delx^2 = (c(x+delx) - 2*c(x) + c(x-delx));

%% Setup the equations
%0=D*(c(x+delx) - 2*c(x) + c(x-delx)) - U*(c(x+delx) - c(x)) -k*c(x)
%0=D*(c(2) - 2*c(1) + c(0)) - U*(c(2) - c(1)) -k*c(1)        %x=1
%0=D*(c(3) - 2*c(2) + c(1)) - U*(c(3) - c(2)) -k*c(2)        %x=2
%0=D*(c(4) - 2*c(3) + c(2)) - U*(c(4) - c(3)) -k*c(3)        %x=3
%0=D*(c(5) - 2*c(4) + c(3)) - U*(c(5) - c(4)) -k*c(4)        %x=4
%0=D*(c(6) - 2*c(5) + c(4)) - U*(c(6) - c(5)) -k*c(5)        %x=5
%0=D*(c(7) - 2*c(6) + c(5)) - U*(c(7) - c(6)) -k*c(6)        %x=6
%0=D*(c(8) - 2*c(7) + c(6)) - U*(c(8) - c(7)) -k*c(7)        %x=7
%0=D*(c(9) - 2*c(8) + c(7)) - U*(c(9) - c(8)) -k*c(8)        %x=8
%0=D*(c(10) - 2*c(9) + c(8)) - U*(c(10) - c(9)) -k*c(9)      %x=9
% A = 9x9 coefficient matrix
A = [(-2*D+U-k), (D-U)    , 0        ,  0       ,   0      ,   0      ,   0      ,  0       ,   0     ;...
      D        ,(-2*D+U-k), (D-U)    ,  0       ,   0      ,   0      ,   0      ,  0       ,   0     ;...
      0        ,   D      ,(-2*D+U-k), (D-U)    ,   0      ,   0      ,   0      ,  0       ,   0     ;...
      0        ,   0      ,   D      ,(-2*D+U-k), (D-U)    ,   0      ,   0      ,  0       ,   0     ;...
      0        ,   0      ,   0      ,   D      ,(-2*D+U-k), (D-U)    ,   0      ,  0       ,   0     ;...
      0        ,   0      ,   0      ,   0      ,   D      ,(-2*D+U-k), (D-U)    ,  0       ,   0     ;...
      0        ,   0      ,   0      ,   0      ,   0      ,   D      ,(-2*D+U-k), (D-U)    ,   0     ;...
      0        ,   0      ,   0      ,   0      ,   0      ,   0      ,   D      ,(-2*D+U-k), (D-U)   ;...
      0        ,   0      ,   0      ,   0      ,   0      ,   0      ,   0      ,  D      ,(-2*D+U-k)];

% b = 9x1 matrix
b = [(-D*c_init); 0; 0; 0; 0; 0; 0; 0; ((U-D)*c_finl)];

%% Cramer's rule
detA=det(A);                               %determinant of coefficient matrix
c = zeros(length(b),1);                    %memory assigned to solution matrix

for i=1:length(b)
    Ab = A;
    Ab(:,i)=b(:);
    
    c(i)=det(Ab)/detA;
end

%% print output
fprintf('Solution of the system of linear algebraic equations:\n')
disp(c)

conc = [c_init;c;c_finl];               %including boundary conditions c(0) and c(10)

%% Plotting solution
figure(1)
plot(x,conc);
title('Concentration of the chemical as a function of distance');
xlabel('distance x');
ylabel('Concentration c');

%% Validation
Cval=A\b;
fprintf('Solution validated:\n')
disp(Cval)