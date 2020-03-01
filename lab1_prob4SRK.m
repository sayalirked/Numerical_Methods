%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 1, Problem 4 (Sayali Kedari)

%% Problem Description: Calculate displacement along the beam

function lab1_prob4SRK(x)
% Inputs:
% x = length of beam

if nargin < 1
    x = 10;
end
xx = linspace(0,x);
n=length(xx);
for i=1:n
    uy(i) = -5/6.*(sing(xx(i),0,4)-sing(xx(i),5,4));
    uy(i) = uy(i) + 15/6.*sing(xx(i),8,3) + 75*sing(xx(i),7,2);
    uy(i) = uy(i) + 57/6.*(xx(i))^3 - 238.25.*xx(i);
end
plot(xx,uy,'--')
title('Displacement along the beam');
xlabel('Length of beam, x');
ylabel('Displacement, u_y(x)');

end

function s = sing(xxx,a,n)
    if xxx > a
        s = (xxx - a).^n;
    else
        s=0;
    end
end