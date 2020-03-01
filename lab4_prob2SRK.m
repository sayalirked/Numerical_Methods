%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 4, Problem 2 (Sayali Kedari)

%% Problem Description: determine the doping density in silicon
% uses bisection method and false position method to find the root of func

%% clean up (in command window)
% clc; clear; close all

function [root,fx,ea,iter]=lab4_prob2SRK(xl,xu,method,es,maxit,func_rho,varargin)

%% input:
% func_rho = name of function
% xl, xu = lower and upper guesses
% rho_desired = desired value of rho
% es = desired relative error (default = 0.0001%)
% maxit = maximum allowable iterations (default = 50)
% method = option of a bracketing method
% output:
% root = real root
% fx = function value at root
% ea = approximate relative error (%)
% iter = number of iterations

%% inputs

if nargin<5||isempty(maxit), maxit=50;end
if nargin<4||isempty(es), es=0.00005;end
if nargin<3
    T0 = 300; % K
    T = 1000; % K
    mu0 = 1360; % cm^2 (Vs)^-1
    q = 1.7e-19; % C
    n_i = 6.29e9; % cm^-3
    rho_desired = 6.5e6; % V s cm/C
    % functions
    n = @(N) (N + sqrt(N.^2 + 4*n_i^2))/2;
    mu = mu0 * (T/T0)^(-2.42);
    varargin = {T0,T,mu0,q,n_i,rho_desired,n,mu};
    func_rho = @(N,varargin) (1./(q*n(N)*mu)) - rho_desired;
    xl = 0;
    xu = 2.5e10;
    method = input('Enter 0 for bisection or any other integer for false position method\n');
end

iter = 0; xr = xl; ea = 100;

% check
test = func_rho(xl,varargin{:})*func_rho(xu,varargin{:});
if test > 0, error('no sign change'); end

if method == 0
    %% bisect iterations
    for i = 1:maxit
    %while (1)
        xrold = xr;
        xr = (xl + xu)/2;
    %     iter = iter + 1;
        if xr ~= 0,ea = abs((xr - xrold)/xr) * 100;end
        test = func_rho(xl,varargin{:})*func_rho(xr,varargin{:});
        if test < 0
        xu = xr;
        elseif test > 0
        xl = xr;
        else
        ea = 0;
        end
%         if ea <= es || iter >= maxit,break,end
        if ea <= es,break,end
    end

    root = xr; fx = func_rho(xr,varargin{:});

    % results
    fprintf('The value of N by bisection method is %10.4f\n',root);
    fprintf('The value of func by bisection method is %10.8f\n',fx);
    fprintf('The approximate relative error value is %10.8f\n',ea);

else
    
    %% false position iterations
    for i = 1:maxit
    %while (1)
        xrold = xr;
        xr = xl + (-func_rho(xl,varargin{:})/(func_rho(xu,varargin{:})-func_rho(xl,varargin{:})) * (xu-xl));
    %     iter = iter + 1;
        if xr ~= 0,ea = abs((xr - xrold)/xr) * 100;end
        test = func_rho(xl,varargin{:})*func_rho(xr,varargin{:});
        if test < 0
        xu = xr;
        elseif test > 0
        xl = xr;
        else
        ea = 0;
        end
%         if ea <= es || iter >= maxit,break,end
        if ea <= es,break,end
    end

    root = xr; fx = func_rho(xr,varargin{:});

    % results
    fprintf('The value of N by false position method is %10.4f\n',root);
    fprintf('The value of func by FP method is %10.8f\n',fx);
    fprintf('The approximate relative error value is %10.8f\n',ea);
end

end