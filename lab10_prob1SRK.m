%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 10, Problem 1 (Sayali Kedari)

%% Problem Description: Solve linear system of equations by
% LU factorization without pivoting

function [U,L] = lab10_prob1SRK(A)
% LU decomposition without pivoting.
% input:
% A = coefficient matrix
% output:
% L = lower triangular matrix
% U = upper triangular matrix
if nargin < 1
    A=[8 5 1;
       3 7 4;
       2 3 9];                       %coefficient matrix
end

[m,n] = size(A);
if m~=n, error('Matrix A must be square'); end
L = eye(n);
U = A;
% forward elimination
for k = 1:n-1
    for i = k+1:n
        L(i,k) = U(i,k)/U(k,k);
        U(i,k) = 0;
        U(i,k+1:n) = U(i,k+1:n)-L(i,k)*U(k,k+1:n);
    end
end
fprintf('L and U matrices:\n');
disp(L)
disp(U)

fprintf('built-in functions:\n');
%built in functions
[L U] = lu(A);
fprintf('L and U matrices:\n');
disp(L)
disp(U)

detA = det(A);
fprintf('Determinant of A matrix\n');
disp(detA)
detU = det(U);
fprintf('Determinant of U matrix\n');
disp(detU)
detL = det(L);
fprintf('Determinant of L matrix\n');
disp(detL)

% L*U
%b=[100;250;100];
% d = L\b;
% x = U\b;
end