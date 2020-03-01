%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 9, Problem 2 (Sayali Kedari)

%% Problem Description: Solving for the system of linear equations by 
% Gauss elimination with pivoting

function x = lab9_prob2SRK(A,b)

if nargin < 2
    A=[0, -2, 1, 2, 0, 0;
       0, 0, 0, -2, 1, 2;
       0, 0, 0, 0, 0, 2;
       1, -1, -1, 0, 0, 0;
       0, 0, 1, -1, -1, 0;
       0, 0, 0, 0, 1, -1];                       %coefficient matrix
    b = [0; 0; 15; 0; 0; 5];
% only for testing the algorithm
%     A=[1,1,1;0,1,1;0,0,1];
%     b=[3;2;1];
end

%% Gauss elimination with pivoting
[m,n]=size(A);
if m~=n, error('Matrix A must be square'); end
nb=n+1;
Aug=[A b];
% forward elimination
for k = 1:n-1
% partial pivoting
    [~,i]=max(abs(Aug(k:n,k)));
    ipr=i+k-1;
    if ipr~=k
        Aug([k,ipr],:)=Aug([ipr,k],:);
    end
    for i = k+1:n
        factor=Aug(i,k)/Aug(k,k);
        Aug(i,k:nb)=Aug(i,k:nb)-factor*Aug(k,k:nb);
    end
end
% back substitution
x=zeros(n,1);
x(n)=Aug(n,nb)/Aug(n,n);
for i = n-1:-1:1
    x(i)=(Aug(i,nb)-Aug(i,i+1:n)*x(i+1:n))/Aug(i,i);
end

%% print output
fprintf('Solution of the system of linear algebraic equations:\n')
disp(x)

%% Validation
y=A\b;
fprintf('Solution validated:\n')
disp(y)

end