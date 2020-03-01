%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 8, Problem 1 (Sayali Kedari)

%% Problem Description: Solve the pentadiagonal system of equations 
% using Naive Gauss Elimination without pivoting

function [x,y] = lab8_prob1SRK(A, b)

if nargin < 2
    A=[8 -2 -1 0 0;
       -2 9 -4 -1 0;
       -1 -3 7 -1 -2;
       0 -4 -2 12 -5;
       0 0 -7 -3 15];                       %coefficient matrix
    b=[5;2;1;1;5];
%only for testing the algorithm
%     A=[1,1,1;0,1,1;0,0,1];
%     b=[3;2;1];
end

%% Gauss elimination without pivoting

[m,n] = size(A);
if m~=n, error('Matrix A must be square'); end
nb = n+1;
Aug = [A b];
% forward elimination
for k = 1:n-1
    for i = k+1:n
        factor = Aug(i,k)/Aug(k,k);
        Aug(i,k:nb) = Aug(i,k:nb)-factor*Aug(k,k:nb);
    end
end
% back substitution
x = zeros(n,1);
x(n) = Aug(n,nb)/Aug(n,n);
for i = n-1:-1:1
    x(i) = (Aug(i,nb)-Aug(i,i+1:n)*x(i+1:n))/Aug(i,i);
end

%% print output
fprintf('Solution of the pentadiagonal system of linear algebraic equations:\n')
disp(x)

%% Validation
y=A\b;
fprintf('Solution validated:\n')
disp(y)

end