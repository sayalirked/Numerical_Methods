%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 6, Problem 3 (Sayali Kedari)

%% Problem Description: Determine the value of concentration
% at which growth is maximum

function [xopt,fx,ea,iter]=lab6_prob3SRK(method,f,xL,xU,xrold,xr,es,maxit)
% uses secant method to find the maximum of f
% input:
% f = name of function
% xl, xu = lower and upper guesses
% es = desired relative error (default = 0.0001%)
% maxit = maximum allowable iterations (default = 50)
% output:
% x = location of minimum
% fx = minimum function value
% ea = approximate relative error (%)
% iter = number of iterations
% varargin = [w0,E,I,L];

if nargin<6
    method = menu('Select the method','Golden-section', 'Secant');
    f = @(c) (2.*c./(4 + 0.8.*c + c.^2 + 0.2.*c.^3));
    xL = -1;
    xU = 5;
    xrold = 1;%guess
    xr = 2.5;
end
if nargin<7||isempty(es), es=0.0001;end
if nargin<8||isempty(maxit), maxit=50;end

%% fminbd
options = optimset('display','iter');
[xmax,fval]=fminbnd(@(c) -(2.*c./(4 + 0.8.*c + c.^2 + 0.2.*c.^3)),0,600,options);
fprintf('The point of minima by fminbd are %10.4e\n',xmax);
fprintf('The value of minima by fminbd are %10.4e\n',fval);

if method==1
    %% Golden-section search method
    f = @(c) -(2.*c./(4 + 0.8.*c + c.^2 + 0.2.*c.^3));
    phi=(1+sqrt(5))/2;
    iter=0;
    %iteration
    while(1)
        d = (phi-1)*(xU - xL);
        x1 = xL + d;
        x2 = xU - d;
        if f(x1) < f(x2)
            xopt = x1;
            xL = x2;
        else
            xopt = x2;
            xU = x1;
        end
        iter=iter+1;
        if xopt~=0, ea = (2 - phi) * abs((xU - xL) / xopt) * 100;end
        if ea <= es || iter >= maxit,break,end
    end
    x=xopt;fx=f(xopt);

    fprintf('The point of maximum deflection by golden-section method are %10.4e\n',x);
    fprintf('The value of maximum deflection by golden-section method are %10.4e\n',fx);
    fprintf('The approximate relative error value is %10.8f\n',ea);

elseif method==2
    %% Secant method
    %differentiate the 'function f' in the question
    func = @(c) (200 - 50.* c^2 - 20.* c.^3)./(20 + 4 .*c + 5.* c.^2 + c.^3).^2;
    iter = 0;
    while (1)
    xrn = xr - func(xr)*(xrold - xr)/(func(xrold) - func(xr));
    iter = iter + 1;
    if xrn ~= 0, ea = abs((xrn - xr)/xrn) * 100; end
    if ea <= es || iter >= maxit, break, end
    xrold = xr;
    xr = xrn;
    fprintf('i    Root       Error\n %i  %0.3e  %0.6f\n',iter,xr,ea);
    end
    xopt = xrn; fx=f(xopt);
%     if func2(xopt) < 0 (func2(xopt must be double derivative of f here)
%         fprintf('Maxima is obtained\n');
%     else
%         fprintf('Minima is obtained\n');
%     end
    fprintf('The value of concentration by Secant method is %10.8e\n',xopt);
end
end