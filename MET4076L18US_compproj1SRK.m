%% Applied Computational Methods (MET 4076) Summer 2018:
% Computer Project 1 (Sayali Kedari)

%% Problem Description: Solving for Darcy friction factor 

function [fricfact] = MET4076L18US_compproj1SRK(func, x1, x2, x3, method)
% uses fzero function and secant method 
% to find the root of function
% input:
% Re, e_d = input variables for function
% func = name of function
% x1, x2 = initial guesses
% output:
% fricfact = real root by the numerical method
% root_fzero = root by fzero

%% inputs
% es = desired relative error (default = 0.001%)
% maxit = maximum allowable iterations (default = 50)
es=0.001;
maxit=100;

if nargin<4
    fprintf('initial guesses required\n');
    x1 = 0.01;  %guess
    x2 = 0.02;   %guess
    x3 = 0.0099;
    fprintf('function arguments required\n');
    func = @(i,Re,e_d) (1./sqrt(i) + 2.*log10(e_d./3.7 + (2.51)./(Re.*sqrt(i))));
end
if nargin<5 || isempty(method)
    method = menu('Select your method', 'Secant', 'Newton Raphson');
end

format long
%% Secant method

Re = logspace(1,8,100);
% e_d = [0,0.0001,0.001,0.01];
e_d = [0,logspace(-4,-2,3)];
fricfact = zeros(length(Re),length(e_d));
dfdx=@(x,Re,e_d) -(((4.03329)./((e_d*Re*x.^1.5)+(9.287*x)))+(1./(2.*x.^1.5)));

for itr_Re = 1:length(Re)
    for itr_ed=1:length(e_d)
        if method==1
            xr = x1;        %guess for each case of Re and e_d
            xrold = x2;     %guess
            iter = 0;
            while (1)
            xrn = xr - func(xr,Re(itr_Re),e_d(itr_ed))*(xrold - xr)/...
                (func(xrold,Re(itr_Re),e_d(itr_ed)) - func(xr,Re(itr_Re),e_d(itr_ed)));
            iter = iter + 1;
            if xrn ~= 0, ea = abs((xrn - xr)/xrn) * 100; end
            if ea <= es || iter >= maxit, break, end
            xrold = xr;
            xr = xrn;
            end
        elseif method ==2
            for i=1:maxit
                xr = x3;        %guess for each case of Re and e_d
                xrn = xr-func(xr, Re(itr_Re),e_d(itr_ed))/dfdx(xr, Re(itr_Re),e_d(itr_ed));
                if xrn ~= 0
                    ea = abs((xrn-xr)/xrn)*100;
                end
                xr = xrn;
                if ea < es
                    break;
                end
            end
        end
        fricfact(itr_Re,itr_ed) = xrn;
    end
end

%% Plotting solution
clf
figure(1)
for itr_ed = 1:length(e_d)
    grid
    loglog(Re,fricfact(:,itr_ed));
    legend(sprintf('\\epsilon/D = %f',e_d(1)),sprintf('\\epsilon/D = %f',e_d(2)),...
        sprintf('\\epsilon/D = %f',e_d(3)),sprintf('\\epsilon/D = %f',e_d(4)),...
        'location','southwest');  
    hold on
end
ylim([1e-3,1e-1]);
xlim([2e3,1e8]);
title('Darcy friction factor as a function of Re');
xlabel('Re');
ylabel('f');

end
