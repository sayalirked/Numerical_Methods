%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 7, Problem 1 (Sayali Kedari)

%% Problem Description: Calculate the matrix products

clc; clear

A = [6, -1; 12, 7; -5, 3];
B = [4, 0; 0.6, 8];
C = [1, -2; -6, 1];

fprintf('Matrix product of [A] and [B]:\n');
disp(A*B)
fprintf('Matrix product of [B] and [C]:\n')
disp(B*C)
fprintf('Matrix product of [C] and [A]:\n');
disp(A*B)

fprintf('Matrix product of [B] and [A]:\n');
if size(B,2)==size(A,1)
    disp(B*A)
else
    fprintf('Error in [B][A] because inner matrix dimensions must agree\n');
end
fprintf('Matrix product of [C] and [B]:\n');
disp(B*C)
fprintf('Matrix product of [A] and [C]:\n');
disp(A*B)

if size(A,2)==size(A,1)
    disp(A*A)
else
    fprintf('Error in [A]^2 because inner matrix dimensions must agree\n');
end
fprintf('Matrix product of [B] and [B]:\n');
disp(B^2)
fprintf('Matrix product of [C] and [C]:\n');
disp(C^2)