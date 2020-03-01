%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 11, Problem 1 (Sayali Kedari)

%% Problem Description: Solve linear system of equations by
% Gauss Seidel method without relaxation

% input:
% m+2,n+2 = dimensions of T matrix
% es = stop criterion (default = 0.05%)
% maxit = max iterations (default = 50)
% bc_w,bc_n,bc_e,bc_s = boundary conditions
% output:
% T = temperature values at the nodes

clc;clear
format long

maxit=100;
es=0.001;
m=5; n=5; %number of unknowns in the T matrix
if m~=n, error('Matrix A must be square'); end
L=1;
delx=L/(m+1); dely=L/(n+1);
bc_w = 100; bc_n = 25; bc_e = 0; bc_s = 75;

rhs = 0;
T = zeros(m+2,n+2);
T(1:m+2,1)=bc_w;
T(1:m+2,n+2)=bc_e;
T(1,2:n+1)=bc_s;
T(m+2,2:n+1)=bc_n;
W=dely^2;
S=delx^2;
P=2*(delx^2+dely^2);
N=delx^2;
E=dely^2;

iter=0;
while(1)
    iter = iter+1;
    Told = T;
    for k=2:n+1
        for q=2:m+1
            T(q,k)=(rhs-W*T(q,k-1)-E*T(q,k+1)-S*T(q-1,k)-N*T(q+1,k))/(-P);
            if T(q,k) ~= 0
                ea(q,k) = abs((T(q,k) - Told(q,k))/T(q,k)) * 100;
            end
        end
    end
    if max(ea(:))<=es || iter >= maxit, break, end
end

clf
figure(1)
x = 0:delx:L;
y = 0:dely:L;
[X, Y] = meshgrid(x);
surf(X,Y,T); %(3D surface plot)
% contour(X,Y,T); %(isolines of matrix T)
title('2-D Laplace''s equation')
xlabel('Spatial co-ordinate (x) \rightarrow')
ylabel('{\leftarrow} Spatial co-ordinate (y)')
zlabel('Solution profile (u) \rightarrow')
