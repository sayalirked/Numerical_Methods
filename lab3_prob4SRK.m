%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 3, Problem 4 (Sayali Kedari)

%% Problem Description: Determine the roots of the functions

%% part a
format long

x=-3:0.001:6;
f=@(x) -2.75.*x.^3+18.*x.^2-21.*x-12;
y= zeros(length(x));
figure(1)
plot(x,f(x),'b-');
hold on
plot(x,y,'k--')
grid;
title('f(x)=-2.75*x^3+18*x^2-21.*x-12');
hold off

fprintf('Graphically, the roots of the polynomial are: ...\n');
r = roots([-2.75 18 -21 -12]);
fprintf('Using built-in function, the roots are:\n');
disp(r)

%% part b
format long

x=0.0:0.001:1;
f=@(x) sin(x) - x.^2;
y= zeros(length(x));
figure(2)
% % plot(x,f(x),'b-');
% % hold on
% % plot(x,y,'k--')
% grid;
% title('f(x)=sin(x) - x^2')
% hold off

fprintf('Graphically, the first non-trivial root of the equation (sin(x) - x^2) is: 0.877\n');

fun = @(n) sin(n)-n^2;
r = fzero(fun,0.75);
fprintf('First non-trivial root of the equation sin(x)-x^2 is: %0.4f\n',r)

plot(x,f(x),x,y,'k--',r,0,'r*','MarkerSize',15);
grid;
title('f(x)=sin(x) - x^2')
hold off