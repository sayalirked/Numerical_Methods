%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 7, Problem 3 (Sayali Kedari)

%% Problem Description: Solving for the system of linear equations by Cramer's rule

clear; clc; close all

A=[8 -2 -1 0 0;
   -2 9 -4 -1 0;
   -1 -3 7 -1 -2;
   0 -4 -2 12 -5;
   0 0 -7 -3 15];                       %coefficient matrix
b=[5;2;1;1;5];

%% Cramer's rule
detA=det(A);                            %determinant of coefficient matrix
x = zeros(length(b),1);                 %memory assigned to solution matrix

for i=1:length(b)
    Ab = A;
    Ab(:,i)=b(:);
    
    x(i)=det(Ab)/detA;
end

%% print output
fprintf('Solution of the pentadiagonal system of linear algebraic equations:\n')
disp(x)

%% Validation
y=A\b;
fprintf('Solution validated:\n')
disp(y)