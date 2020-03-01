%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 6, Problem 1 (Sayali Kedari)

%% Problem Description: Finding the optimum(maximum) of f using 
% Newton-Raphson method and fminbd

f = @(x) (-1.5.*x.^6 - 2.*x.^4 + 12.*x);
figure(1)
x=linspace(-150,150);
plot(x,f(x))
title('Function f vs x');
xlabel('x');
ylabel('f(x)');
grid

% options = optimset('display','iter');
[xmax,fval]=fminbnd(@(x) -(-1.5.*x.^6 - 2.*x.^4 + 12.*x),-100,100);

fprintf('The value of x for obtaining the maximum of f is %f\n',xmax);

%% Newton-Raphson method
%guess
xr = 10;
%differentiating the 'function f'
func = @(x) (-9.*x.^5 - 8.*x.^3 + 12);
dfdx = @(x) (-45.*x.^4 -24.*x.^2);
figure(2)
x=linspace(-50,50);
plot(x,dfdx(x))
title('Double Derivative d^2f/dx^2 vs x');
xlabel('x');
ylabel('d^2(f(x))/dx^2');
grid

ea = 100; es = 0.001; maxit = 50;

for i=1:maxit
    xrn = xr-func(xr)/dfdx(xr);
    if xrn ~= 0
        ea = abs((xrn-xr)/xrn)*100;
    end
    xr = xrn;
    fprintf('i \t Root\t Error\n %i \t %0.3e \t %0.6f\n',i,xr,ea);
    if ea < es
        break;
    end
end
xopt_method = xr; fx=f(xopt_method);
fprintf('The value of x for obtaining the maximum of f  by Newton-Raphson method is %10.8f\n',xopt_method);
fprintf('The value of function f is %10.8f',fx);