%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 3, Problem 2 (Sayali Kedari)

%% Problem Description: Using the Taylor Series expansion, we obtain the 
% following 1st, 2nd, 3rd order Taylor Series functions

format long
a=1;
x=0:0.001:6;
f=@(x) 25.*x.^3-6.*x.^2+7.*x-88;
subplot(2,2,1);
plot(x,f(x));grid;title('f(x)=25*x^3-6*x^2+7*x-88');hold on

%% zeroth order
f0 = f(a);
e0=abs((f(3)-f0)/f(3))*100; 
fprintf('Zeroth Order Taylor Series Error = %e\n',e0);

%% first-order
f1=@(x) 70.*(x-a) + f(a);
e1=abs((f(3)-f1(3))/f(3))*100; 
fprintf('1st Order Taylor Series Error = %e\n',e1);
%Calculates the absolute value of the difference/error
subplot(2,2,2);
plot(x,f1(x));grid;title('1st Order Taylor Series');

%% second-order
f2=@(x) 138/2.*(x-a).^2 + 70.*(x-a) + f(a);
e2=abs((f(3)-f2(3))/f(3))*100;
fprintf('2nd Order Taylor Series Error = %e\n',e2);
subplot(2,2,3);
plot(x,f2(x));grid;title('2nd Order Taylor Series');

%% third-order
f3=@(x) 150/6.*(x-a).^3 + 138/2.*(x-a).^2 + 70.*(x-a) + f(a);
e3=abs((f(3)-f3(3))/f(3))*100;
fprintf('3rd Order Taylor Series Error = %e\n',e3);
subplot(2,2,4);
plot(x,f3(x));grid;title('3rd Order Taylor Series');hold off