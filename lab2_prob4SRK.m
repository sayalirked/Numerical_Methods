%% Applied Computational Methods (MET 4076) Spring 2018:
% Lab Assignment 2, Problem 4 (Sayali Kedari)

%% Problem Description: determine the true value, true and approximate 
%                       percent relative errors for the Maclaurin series
%                       of cosine function

function [fx,et,ea,iter] = lab2_prob4SRK(x,es,maxit)
% input:
% x = value at which series evaluated
% es = stopping criterion (default = 0.0001)
% maxit = maximum iterations (default = 50)
% output:
% fx = estimated value
% et = true relative error (%)
% ea = approximate relative error (%)
% iter = number of iterations

format long

%% default inputs:

if nargin<3||isempty(maxit),maxit=1000;end
if nargin<2||isempty(es),es=0.01;end
if nargin<1||isempty(x),x=pi/4;end

%% True value of cosine function for value 'x'
true_val = cos(x);
fprintf('The true value of cos(%f) is %10.8f\n', x, true_val);

%% initialization
iter = 1; sol = 1; ea = 100;

%% iterative calculation
while (1)
    solold = sol;
    if true_val ~= 0
        et = abs((true_val - sol)/true_val)*100;
    end
    sol = sol + (-1)^iter * (x ^ (2*iter)) / factorial(2*iter);
    iter = iter + 1;
    if sol~=0
        ea = abs((sol - solold)/sol)*100;
    end
    if ea<=es || iter>=maxit,break,end
end

fx = sol;

%% True and approximate percent relative errors 
fprintf('The true percent relative error is %10.8f\n', et);
fprintf('The approximate percent relative error is %10.8f\n', ea);

end