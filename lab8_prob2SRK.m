%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 8, Problem 2 (Sayali Kedari)

%% Problem Description: Solve the pentadiagonal system of equations 
% using Naive Gauss Elimination without pivoting

function [x,y] = lab8_prob2SRK(A, b)

if nargin < 2
% shuffled coefficient matrix (only for using the 'without pivoting' method;
% cannot be done for all the other problems
    A=[1, -1, -1, 0, 0, 0;
       0, -2, 1, 2, 0, 0;
       0, 0, 1, -1, -1, 0;
       0, 0, 0, -2, 1, 2;
       0, 0, 0, 0, 1, -1;
       0, 0, 0, 0, 0, 2;];
    b = [0; 0; 0; 0; 5; 15];
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
fprintf('Solution of the system of linear algebraic equations:\n')
disp(x)

%% Validation
y=A\b;
fprintf('Solution validated:\n')
disp(y)

end