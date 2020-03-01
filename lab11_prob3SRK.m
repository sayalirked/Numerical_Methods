%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 11, Problem 3 (Sayali Kedari)

%% Problem Description: Implement linear and quadratic interpolation

function yint = lab11_prob3SRK(xgiven,ygiven,xx,method)
% input:
% x = independent variable
% y = dependent variable
% xx = value of independent variable at which
% interpolation is calculated
% output:
% yint = interpolated value of dependent variable
% compute the finite divided differences in the form of a
% difference table

if nargin<4
    xgiven=[0.10377 0.11144 0.12547]; %volume v
    ygiven=[6.4147 6.5453 6.7664]; %entropy s
    xx=0.118;
    method=menu('Select method of interpolation','linear','quadratic');
end

if method==1
    %% linear interpolation
    x=xgiven(2:3);
    y=ygiven(2:3);
    n = length(x);
    if length(y)~=n, error('x and y must be same length'); end

    b = zeros(n,n);
    % assign dependent variables to the first column of b.
    b(:,1) = y(:); % the (:) ensures that y is a column vector.
    for j = 2:n
        for i = 1:n-j+1
            b(i,j) = (b(i+1,j-1)-b(i,j-1))/(x(i+j-1)-x(i));
        end
    end
    disp(b)
    % use the finite divided differences to interpolate
    xt = 1;
    yint = b(1,1);
    for j = 1:n-1
        xt = xt*(xx-x(j));
        yint = yint+b(1,j+1)*xt;
    end

    %results
    fprintf('Using linear interpolation, the value of f(0.118) = %5.5f\n',yint);

    %% polyfit and polyval
    pmat=polyfit(x,y,1);
    fp=polyval(pmat,xx);
    fprintf('Using linear polyfit, f(0.118) = %5.5f\n',fp)

elseif method==2
    %% quadratic interpolation
    
    x=xgiven(:);
    y=ygiven(:);
    n = length(x);
    if length(y)~=n, error('x and y must be same length'); end

    b = zeros(n,n);
    % assign dependent variables to the first column of b.
    b(:,1) = y(:); % the (:) ensures that y is a column vector.
    for j = 2:n
        for i = 1:n-j+1
            b(i,j) = (b(i+1,j-1)-b(i,j-1))/(x(i+j-1)-x(i));
        end
    end
    % use the finite divided differences to interpolate
    xt = 1;
    yint = b(1,1);
    for j = 1:n-1
        xt = xt*(xx-x(j));
        yint = yint+b(1,j+1)*xt;
    end
    %results
    fprintf("Using quadratic polynomial, the value of f(0.118) = %5.5f\n",yint);

    %% polyfit and polyval
    pmat=polyfit(x,y,2);
    fp=polyval(pmat,xx);
    fprintf('Using quadratic polyfit, f(0.118) = %5.5f\n',fp)

end