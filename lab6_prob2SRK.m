%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 6, Problem 2 (Sayali Kedari)

%% Problem Description: Determine the point of maximum deflection 
% using the golden-section search method

function [x,fx,ea,iter]=lab6_prob2SRK(method, f,xl,xu,es,maxit, varargin)
% goldmin: minimization golden section search
% [x,fx,ea,iter]=goldmin(f,xl,xu,es,maxit,p1,p2,...):
% uses golden section search to find the minimum of f
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
if nargin<4
    w0 = 2.5; %kN/cm
    E = 50000; %kN/cm^2
    I = 30000; %cm^4
    L = 600; %cm
    varargin = {w0,E,I,L};
    f = @(x, varargin) (w0/(120*E*I*L)*(-x.^5 + 2*L^2*x.^3 - L^4.*x));
    xl = 0;
    xu = L;
    method = menu('Select your method', 'Golden-section', 'Newton Raphson', 'Secant');
end
if nargin<5||isempty(es), es=0.001;end
if nargin<6||isempty(maxit), maxit=50;end

%% plot
figure(1)
x=linspace(0,600);
plot(x,f(x,varargin))
title('Function f vs x');
xlabel('x');
ylabel('f(x)');
grid

%% fminbd
options = optimset('display','iter');
[xmax,fval]=fminbnd(@(x, varargin) (w0/(120*E*I*L)*(-x.^5 + 2*L^2*x.^3 - L^4.*x)),0,600,options);
fprintf('The point of maximum deflection by fminbd are %10.4e\n',xmax);
fprintf('The value of maximum deflection by fminbd are %10.4e\n',fval);

if method == 1
    phi=(1+sqrt(5))/2;
    iter=0;
    %iteration
    while(1)
        d = (phi-1)*(xu - xl);
        x1 = xl + d;
        x2 = xu - d;
        if f(x1) < f(x2)
            xopt = x1;
            xl = x2;
        else
            xopt = x2;
            xu = x1;
        end
        iter=iter+1;
        if xopt~=0, ea = (2 - phi) * abs((xu - xl) / xopt) * 100;end
        if ea <= es || iter >= maxit,break,end
    end
    x=xopt;fx=f(xopt,varargin);

    fprintf('The point of maximum deflection by golden-section method are %10.4e\n',xopt);
    fprintf('The value of maximum deflection by golden-section method are %10.4e\n',fx);
    fprintf('The approximate relative error value is %10.8f\n',ea);

elseif method == 2
    %% Newton-Raphson method
    %guess
    xr = 100;
    func = @(x, varargin) w0/(120*E*I*L)*(-5.*x.^4 + 6*L^2.*x.^2 - L^4);
    dfdx = @(x, varargin) w0/(30*E*I*L)*(-5.*x.^3 + 3*L^2.*x);
    ea = 100;
    for i=1:maxit
        xrn = xr-func(xr,varargin)/dfdx(xr,varargin);
        if xrn ~= 0
            ea = abs((xrn-xr)/xrn)*100;
        end
        xr = xrn;
        fprintf('i \t Root \t Error\n %i \t %0.3e \t %0.6f\n',i,xr,ea);
        if ea < es
            break;
        end
    end
    xopt_method = xr;
    fprintf('The point of maximum deflection by Newton-Raphson method is %10.8e\n',xopt_method);
    
elseif method == 3
    %% Secant method
    %guess
    xr = 200;
    xrold = 100;
    func = @(x, varargin) w0/(120*E*I*L)*(-5.*x.^4 + 6*L^2.*x.^2 - L^4);
    iter = 0;
    while (1)
        xrn = xr - func(xr, varargin)*(xrold - xr)...
            /(func(xrold, varargin) - func(xr, varargin));
        iter = iter + 1;
        if xrn ~= 0, ea = abs((xrn - xr)/xrn) * 100; end
        if ea <= es || iter >= maxit, break, end
        xrold = xr;
        xr = xrn;
        fprintf('i \t Root \t Error\n %i \t %0.3e \t %0.6f\n',iter,xr,ea);
    end
    xopt_method = xrn;
    fprintf('The point of maximum deflection by Secant method is %10.8e\n',xopt_method);

end