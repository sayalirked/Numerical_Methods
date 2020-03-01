%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 3, Problem 3 (Sayali Kedari)

%% Problem Description: Using the Taylor Series expansion, we obtain the 
% following 1st, 2nd, 3rd, 4th, 5th and 6th order Taylor Series functions

format long
x=0:0.001:3.2;
f=x-1-0.5*sin(x);
subplot(3,2,1);
plot(x,f);grid;title('f(x)=x-1-0.5*sin(x)');hold on

%% first-order
f1=x-1.5;
e1=abs(f-f1); 
%Calculates the absolute value of the difference/error
subplot(3,2,2);
plot(x,e1);grid;title('1st Order Taylor Series Error');

%% second/third order
f2=x-1.5+0.25.*((x-0.5*pi).^2);
e2=abs(f-f2);
subplot(3,2,3);
plot(x,e2);grid;title('2nd/3rd Order Taylor Series Error');

%% fourth/fifth order
f4=x-1.5+0.25.*((x-0.5*pi).^2)-(1/48)*((x-0.5*pi).^4);
e4=abs(f4-f);
subplot(3,2,4);
plot(x,e4);grid;title('4th/5th Order Taylor Series Error');hold off

%% sixth order
f6=x-1.5+0.25.*((x-0.5*pi).^2)-(1/48)*((x-0.5*pi).^4)+(1/1440)*((x-0.5*pi).^6);
e6=abs(f6-f);
subplot(3,2,5);
plot(x,e6);grid;title('6th Order Taylor Series Error');hold off

%% result
fprintf('4th/5th Order Taylor Series is the highest order Taylor series expansion resulting in a maximum error of 0.015\n')