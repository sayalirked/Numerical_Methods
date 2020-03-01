%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 7, Problem 2 (Sayali Kedari)

%% Problem Description: Solve the linear algebraic equations

clc; clear; close all

A = [0, -6, 5; 0, 2, 7; -4, 3, -7];
b = [50; -30; 50];

x = A\b;
% x = inv(A)*b;

fprintf('Transpose of the coefficient matrix:\n')
disp(transpose(A))

fprintf('Solution of the linear algebraic equations:\n')
disp(x)
