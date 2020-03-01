%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 4, Problem 1 (Sayali Kedari)

%% Problem Description: determine the interest rate that you are paying

function [root,fx,ea,iter]=lab4_prob1SRK(func,xl,xu,es,maxit,varargin)
% uses bisection method to find the root of func
% input:
% func = name of function
% xl, xu = lower and upper guesses
% es = desired relative error (default = 0.0001%)
% maxit = maximum allowable iterations (default = 50)
% output:
% root = real root
% fx = function value at root
% ea = approximate relative error (%)
% iter = number of iterations

%% inputs

if nargin<5||isempty(maxit), maxit=50;end
if nargin<4||isempty(es), es=0.00005;end
if nargin<3
    fprintf('at least 3 input arguments required\n');
    A = 8500; %$
    P = 35000; %$
    n = 7; %years
    varargin = {A,P,n};
    func = @(i,varargin) (P * (i*(i+1).^n)./((i+1).^n - 1)) - A;
    xl = 0.01;
    xu = 0.3;
end

iter = 0; xr = xl; ea = 100;

%% iterations
for i = 1:maxit
%while (1)
    xrold = xr;
    xr = (xl + xu)/2;
%     iter = iter + 1;
    if xr ~= 0,ea = abs((xr - xrold)/xr) * 100;end
    test = func(xl,varargin{:})*func(xr,varargin{:});
    if test < 0
    xu = xr;
    elseif test > 0
    xl = xr;
    else
    ea = 0;
    end
%     if ea <= es || iter >= maxit,break,end
    if ea <= es,break,end
end

root = xr; fx = func(xr,varargin{:});
fprintf('The value of interest rate by bisection method is %10.4f\n',root);
fprintf('The approximate relative error value is %10.8f\n',ea);

end