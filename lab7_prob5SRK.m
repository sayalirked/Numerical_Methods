%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 7, Problem 5 (Sayali Kedari)

%% Problem Description: Solving for the system of linear equations by Cramer's rule

clear; clc; close all

A=[0, -2, 1, 2, 0, 0;
   0, 0, 0, -2, 1, 2;
   0, 0, 0, 0, 0, 2;
   1, -1, -1, 0, 0, 0;
   0, 0, 1, -1, -1, 0;
   0, 0, 0, 0, 1, -1];                       %coefficient matrix
b = [0; 0; 15; 0; 0; 5];

%% Cramer's rule
detA=det(A);                            %determinant of coefficient matrix
x = zeros(length(b),1);                 %memory assigned to solution matrix

for i=1:length(b)
    Ab = A;
    Ab(:,i)=b(:);
    
    x(i)=det(Ab)/detA;
end

%% print output
fprintf('Solution of the system of linear algebraic equations:\n')
disp(x)

%% Validation
y=A\b;
fprintf('Solution validated:\n')
disp(y)