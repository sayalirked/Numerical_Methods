%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 9, Question 3 (Sayali Kedari)

%% Problem Description: Solve linear system of equations by
% special case of Naive Gauss Elimination for pentadiagonal system

function x = lab9_prob3SRK(L2,L1,C,R1,R2,b)
% input:
% L2 = left vector to the subdiagonal vector
% L1 = subdiagonal vector
% C = diagonal vector
% R1 = superdiagonal vector
% R2 = right vector to the superdiagonal vector
% b = right hand side vector
% output:
% x = solution vector
% L2 L1 |C  R1 R2 0  0 | 0  0;
% 0  L2 |L1 C  R1 R2 0 | 0  0;
% 0  0  |L2 L1 C  R1 R2| 0  0;
% 0  0  |0  L2 L1 C  R1| R2 0;
% 0  0  |0  0  L2 L1 C | R1 R2;                       %coefficient matrix

if nargin < 6
    L2 = [0; 0; -1; -4; -7];
    L1 = [0; -2; -3; -2; -3];
    C = [8; 9; 7; 12; 15];
    R1 = [-2; -4; -1; -5; 0];
    R2 = [-1; -1; -2; 0; 0];
    b=[5; 2; 1; 1; 5];
%     d=[0;0;diag(A,-2)];
%     e=[0;0;diag(A,-1)];
%     f=diag(A);
%     g=diag(A,1);
%     h=diag(A,2);
end

A=[8 -2 -1 0 0;
   -2 9 -4 -1 0;
   -1 -3 7 -1 -2;
   0 -4 -2 12 -5;
   0 0 -7 -3 15];                       %coefficient matrix

%% Solution check
y=(A)\b;
fprintf('Solution checked by left-division operator:\n')
disp(y)
%% Gauss elimination without pivoting (similar to code for tridiagonal system)

n=length(C);

% forward elimination
for k = 3:n
    factor = L2(k)/L1(k-1);
    L1(k) = L1(k) - factor*C(k-1);
    C(k) = C(k) - factor*R1(k-1);
    R1(k) = R1(k) - factor*R2(k-1);
    b(k) = b(k) - factor*b(k-1);
end
% forward elimination
for k = 2:n
    factor = L1(k)/C(k-1);
    R1(k) = R1(k) - factor*R2(k-1);
    C(k) = C(k) - factor*R1(k-1);
    b(k) = b(k) - factor*b(k-1);
end
% back substitution
x(n) = b(n)/C(n);
x(n-1)=(b(n-1) - R1(n-1)*x(n))/C(n-1);
for k = (n-2):-1:1
    x(k) = (b(k) - R1(k)*x(k+1) - R2(k)*x(k+2))/C(k);
end

%% Print output
fprintf('Solution by the algorithm:\n')
disp(x)
end