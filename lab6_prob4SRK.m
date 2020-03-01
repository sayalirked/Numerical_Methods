%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 6, Problem 4 (Sayali Kedari)

%% Problem Description: Determine the 

function [x,fx,ea,iter]=lab6_prob4SRK(f,xl,xu,es,maxit)
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
    f = @(x) (x.^4 + 2*x.^3 + 8.*x.^2 + 5.*x);
    xl = -2;
    xu = 1;
end
if nargin<5||isempty(es), es=0.01;end
if nargin<6||isempty(maxit), maxit=50;end

%% plot
figure(1)
x=linspace(-2,1);
plot(x,f(x))
title('Function f vs x');
xlabel('x');
ylabel('f(x)');
grid

%% fminbd
options = optimset('display','iter');
[xmax,fval]=fminbnd(@(x) (x.^4 + 2*x.^3 + 8.*x.^2 + 5.*x),xl,xu,options);
fprintf('The point of maximum deflection by fminbd are %10.4e\n',xmax);
fprintf('The value of maximum deflection by fminbd are %10.4e\n',fval);

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
x=xopt;fx=f(xopt);

fprintf('The point of minima by golden-section method are %10.4e\n',xopt);
fprintf('The value of minima by golden-section method are %10.4e\n',fx);
fprintf('The approximate relative error value is %10.8f\n',ea);
end