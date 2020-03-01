%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 9, Problem 1 (Sayali Kedari)

%% Problem Description: Solve the system of equations 
% using Cramer's rule and Gauss elimination with pivoting
% Truss sum
function x = lab9_prob1SRK(A,b)

if nargin < 2
%     AB, BC, AD, BD, CD, DE, CE, Ax, Ay, and Ey
    A = [0,0,1,0,0,0,0,1,0,0;...
        1,0,0,0,0,0,0,0,1,0;...
         0,1,0,0.6,0,0,0,0,0,0;...
         -1,0,0,-0.8,0,0,0,0,0,0;...
         0,-1,0,0,0,0,0.6,0,0,0;...
         0,0,0,0,-1,0,-0.8,0,0,0;...
         0,0,-1,-0.6,0,1,0,0,0,0;...
         0,0,0,0.8,1,0,0,0,0,0;...
         0,0,0,0,0,-1,-0.6,0,0,0;...
         0,0,0,0,0,0,0.8,0,0,1];
    b = [0; 0;-74;0;0;24;0;0;0;0];
% only for testing the algorithm
%     A=[1,1,1;0,1,1;0,0,1];
%     b=[3;2;1];
end

%% Cramer's rule

% detA=det(A);                               %determinant of coefficient matrix
% x = zeros(length(b),1);                 %memory assigned to solution matrix
% 
% for i=1:length(b)
%     Ab = A;
%     Ab(:,i)=b(:);
%     
%     x(i)=det(Ab)/detA;
% end

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
% disp(x)
X= table(x,'VariableName',{'Value'},'RowName',{'AB', 'BC', 'AD', 'BD', 'CD', 'DE', 'CE', 'Ax', 'Ay', 'Ey'});
disp(X)
%% Validation
y=A\b;
fprintf('Solution validated:\n')
disp(y)

end