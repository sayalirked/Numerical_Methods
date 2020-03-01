%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 8, Problem 3 (Sayali Kedari)

%% Problem Description: Solve the pentadiagonal system of equations 
% using Naive Gauss Elimination without pivoting

function [c,y] = lab8_prob3SRK(A, b, D,U,k, c_init,c_finl)

if nargin < 7
    D=2;
    U=1;
    k=0.2;
    % c(0)=80;
    c_init=80;
    % c(10)=10;
    c_finl = 10;
    % A = 9x9 coefficient matrix
    A = [(-2*D+U-k), (D-U)    , 0        ,  0       ,   0      ,   0      ,   0      ,  0       ,   0     ;...
          D        ,(-2*D+U-k), (D-U)    ,  0       ,   0      ,   0      ,   0      ,  0       ,   0     ;...
          0        ,   D      ,(-2*D+U-k), (D-U)    ,   0      ,   0      ,   0      ,  0       ,   0     ;...
          0        ,   0      ,   D      ,(-2*D+U-k), (D-U)    ,   0      ,   0      ,  0       ,   0     ;...
          0        ,   0      ,   0      ,   D      ,(-2*D+U-k), (D-U)    ,   0      ,  0       ,   0     ;...
          0        ,   0      ,   0      ,   0      ,   D      ,(-2*D+U-k), (D-U)    ,  0       ,   0     ;...
          0        ,   0      ,   0      ,   0      ,   0      ,   D      ,(-2*D+U-k), (D-U)    ,   0     ;...
          0        ,   0      ,   0      ,   0      ,   0      ,   0      ,   D      ,(-2*D+U-k), (D-U)   ;...
          0        ,   0      ,   0      ,   0      ,   0      ,   0      ,   0      ,  D      ,(-2*D+U-k)];

    % b = 9x1 matrix
    b = [(-D*c_init); 0; 0; 0; 0; 0; 0; 0; ((U-D)*c_finl)];

%only for testing the algorithm
%     A=[1,1,1;0,1,1;0,0,1];
%     b=[3;2;1];
end
delx = 1; %using dx=1
x=0:delx:10;
    
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
c = zeros(n,1);
c(n) = Aug(n,nb)/Aug(n,n);
for i = n-1:-1:1
    c(i) = (Aug(i,nb)-Aug(i,i+1:n)*c(i+1:n))/Aug(i,i);
end

%% print output
fprintf('Solution of the system of linear algebraic equations:\n')
disp(c)

%% Validation
y=A\b;
fprintf('Solution validated:\n')
disp(y)

%% Plotting solution
conc = [c_init;c;c_finl];               %including boundary conditions c(0) and c(10)
figure(1)
plot(x,conc);
grid
title('Concentration of the chemical as a function of distance');
xlabel('distance x');
ylabel('Concentration c');
end