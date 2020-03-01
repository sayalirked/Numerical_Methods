%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 10, Question 2a (Sayali Kedari)

%% Problem Description: Solve linear system of equations by
% cholesky decomposition without pivoting

function U = lab10_prob2SRK(A)
% cholesky(A):
% cholesky decomposition without pivoting.
% input:
% A = coefficient matrix
% output:
% U = upper triangular matrix
if nargin < 1
    A = [8,20,16;20,80,50;16,50,60];
end

b=[100;250;100];
[m,n] = size(A);
if m~=n, error('Matrix A must be square'); end
for i = 1:n
    s = 0;
    for k = 1:i-1
        s = s + U(k, i) ^ 2;
    end
    U(i, i) = sqrt(A(i, i) - s);
    for j = i + 1:n
        s = 0;
        for k = 1:i-1
            s = s + U(k, i) * U(k, j);
        end
        U(i, j) = (A(i, j) - s) / U(i, i);
    end
end
fprintf('Solution by algorithm:\n');
disp(U)

%% Test using a built-in chol function
fprintf('Solution by built-in chol function:\n');
U_test = chol(A);
disp(U_test)

d=U_test'\b;
disp(d)
x=U\d;
disp(x);

end