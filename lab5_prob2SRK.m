%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 5, Problem 2 (Sayali Kedari)

%% Problem Description: Solving for depth of the tank

function [root_method] = lab5_prob2SRK(method, func, xl, xu, es, maxit, varargin)
% uses Newton Raphson and/or secant method
% to find the root of function
% input:
% method = type of open method
% R, V = input variables for function (varargin)
% func = name of function
% xl, xu = lower and upper guesses
% es = desired relative error (default = 0.01%)
% maxit = maximum allowable iterations (default = 50)
% output:
% root_method = real root by method

%% inputs

if nargin<6
    fprintf('initial guesses required\n');
    xl = 0;
    xu = 3;
		es=0.01;
		maxit=50;
    fprintf('function arguments required\n');
    R = 3; %m
    V = 30; %m^3
	varargin = {R,V};
    func = @(h, varargin) ((pi*h*h * (3*R - h)/3) - V);
end
if nargin<1 || isempty(method)
%     method = input('Enter 0 for Newton Raphson or any other integer for secant method\n');
    method = menu('Select your method', 'Newton Raphson', 'Secant');
end

root_fzero = fzero(func,[xl xu]);
fprintf('The value of root by fzero function is %10.8f\n',root_fzero);

if method == 1
    %% Newton-Raphson method
    %guess
    xr = 1.0;

    dfdx = @(h, varargin) ( 2*pi*h*R - pi*h^2 );

    ea = 100;

    for i=1:maxit

        xrn = xr-func(xr, varargin{:})/dfdx(xr, varargin{:});
        if xrn ~= 0
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

elseif method == 2

    %% Secant method
    %guess
    xr = 0;
    xrold = 1;
    iter = 0;
    while (1)
	    xrn = xr - func(xr, varargin{:})*(xrold - xr)/...
						(func(xrold, varargin{:}) - func(xr, varargin{:}));
	    iter = iter + 1;
	    if xrn ~= 0, ea = abs((xrn - xr)/xrn) * 100; end
	    if ea <= es || iter >= maxit, break, end
	    xrold = xr;
	    xr = xrn;
	    fprintf('i    Root       Error\n %i  %0.6f  %0.6f\n',iter,xr,ea);
    end
    root_method = xrn;
    fprintf('The value of root by Secant method is %10.8f\n',root_method);

end

fprintf('The most efficient numerical method is ...(fill in) because ...');

end
