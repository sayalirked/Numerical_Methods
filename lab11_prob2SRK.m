%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 11, Problem 2 (Sayali Kedari)

%% Problem Description: Solve linear system of equations by
% Gauss Seidel method without relaxation and Jacobi method

function x = lab11_prob2SRK(A,b,es,maxit,method)
% input:
% A = coefficient matrix
% b = right hand side vector
% es = stop criterion (default = 0.05)
% maxit = max iterations (default = 50)
% output:
% x = solution vector

if nargin<5||isempty(maxit),maxit=50;end
if nargin<4||isempty(es),es=0.05;end
if nargin<3
    fprintf('matrices A and b required\n');
%     A = [10, 2, -1; -3, -6, 2; 1, 1, 5];
%     b = [27; -61.5; -21.5];
    A = [8, 20, 16; 20, 80, 50; 16, 50, 60];
    b = [100;250;100];
    method=menu('Select your method','Gauss-Seidel','Jacobi');
end

format long
[m,n] = size(A);
if m~=n, error('Matrix A must be square'); end
C = A;
for i = 1:n
    C(i,i) = 0;
    x(i) = 0;
end
x = x';
    
if method==1
    %Gauss-Seidel method
    for i = 1:n
        C(i,1:n) = C(i,1:n)/A(i,i);
    end
    for i = 1:n
        d(i) = b(i)/A(i,i);
    end
    iter = 0;
    while (1)
        xold = x;
        for i = 1:n
            x(i) = d(i)-C(i,:)*x;
            if x(i) ~= 0
                ea(i) = abs((x(i) - xold(i))/x(i));
            end
        end
        iter = iter+1;
        if max(ea)<=es || iter >= maxit, break, end
    end

    fprintf('Solution of the linear system of algebraic equations by Gauss-Seidel method:\n')
    disp(x)
else
    %Jacobi method
    ea=Inf;
    iter=0;
    %% Algorithm: Jacobi Method
    while max(ea)>es
        xold=x;
        for i=1:n
            sigma=0;
            for j=1:n
                if j~=i
                    sigma=sigma+A(i,j)*x(j);
                end
            end
            x(i)=(1/A(i,i))*(b(i)-sigma);
        end
        iter=iter+1;
        ea=abs(xold-x);
    end
    %% results
    fprintf('Solution of the system by Jacobi method is : \n');
    disp(x)
end
%% Validation
y=A\b;
fprintf('Solution validated:\n')
disp(y)
end