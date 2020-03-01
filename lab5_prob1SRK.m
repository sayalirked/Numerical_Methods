%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 5, Problem 1 (Sayali Kedari)

%% Problem Description: Solving for angular frequency of the system

function [root_method,root_fzero] = lab5_prob1SRK(method, func, xl, xu, es, maxit, varargin)
% uses fzero function, Newton Raphson and secant method
% to find the root of function
% input:
% method = type of open method
% R, C, L, Z = input variables for function (varargin)
% func = name of function
% xl, xu = lower and upper guesses
% es = desired relative error (default = 0.01%)
% maxit = maximum allowable iterations (default = 50)
% output:
% root_method = real root by method
% root_fzero = root by fzero

%% inputs

if nargin<5
    fprintf('initial guesses required\n');
    xl = 1;
    xu = 1000;
    es=0.01;
    maxit=50;
    fprintf('function arguments required\n');
    R = 225; %ohm
    C = 0.6 * 10^(-6); %F
    L = 0.5; %H
    Z = 100; %ohm
	varargin = {R,C,L,Z};
    func = @(i,varargin) (sqrt(1/(R*R) + (i*C - 1./(i*L)).^2) - 1/Z);
end
if nargin<1 || isempty(method)
    method = input('Enter 0 for Newton Raphson; 1 for secant method or any other integer for modified secant method\n');
end

% root_fzero = fzero('0.01-sqrt(1/50625+(.6e-6*x-2./x).^2)',[1 1000]);
root_fzero = fzero(func,[xl xu]);
fprintf('The value of root by fzero function is %10.8f\n',root_fzero);

if method == 0
    %% Newton-Raphson method
    %guess
    xr = 1.0;

    dfdx = @(i, varargin) (1./(sqrt(1/(R*R) + (i*C - 1./(i*L)).^2)) * ...
                            (i*C - 1./(i*L)) * (C + 1./(i*i*L)) );

    ea = 100;

    for i=1:maxit
        %x1 = fofx(x0)+x0;
        xrn = xr-func(xr,varargin{:})/dfdx(xr,varargin{:});
        if xr ~= 0
            ea = abs((xrn-xr)/xrn)*100;
        end
        xr = xrn;
        fprintf('i    Root       Error\n %i  %0.6f  %0.6f\n',i,xr,ea);
        if ea < es
            break;
        end
    end
    root_method = xr;
    fprintf('The value of root by Newton-Raphson method is %10.8f\n',root_method);

elseif method == 1
    %% Secant method
    %guess
    xr = 1;
    xrold = 3;
    iter = 0;
    while (1)
	    xrn = xr - func(xr,varargin{:})*(xrold - xr)/...
						(func(xrold,varargin{:}) - func(xr,varargin{:}));
	    iter = iter + 1;
	    if xrn ~= 0, ea = abs((xrn - xr)/xrn) * 100; end
	    if ea <= es || iter >= maxit, break, end
	    xrold = xr;
	    xr = xrn;
	    fprintf('i    Root       Error\n %i  %0.6f  %0.6f\n',iter,xr,ea);
    end
    root_method = xrn;
    fprintf('The value of root by Secant method is %10.8f\n',root_method);

else
    %% Modified secant method
    %guess
    xr = 1;
    delt = 0.114;
    xrold = xr + delt;
    iter = 0;
    while (1)
	    xrn = xr - func(xr,varargin{:})*(delt)/...
						(func(xrold,varargin{:}) - func(xr,varargin{:}));
	    iter = iter + 1;
	    if xrn ~= 0, ea = abs((xrn - xr)/xrn) * 100; end
	    if ea <= es || iter >= maxit, break, end
	    xrold = xr;
	    xr = xrn;
	    fprintf('i    Root       Error\n %i  %0.6f  %0.6f\n',iter,xr,ea);
    end
    root_method = xrn;
    fprintf('The value of root by Modified Secant method is %10.8f\n',root_method);

end
end
