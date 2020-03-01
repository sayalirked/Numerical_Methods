%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 2, Problem 2 (Sayali Kedari)

%% Problem Description: Calculating annual payment

function lab2_prob2SRK(P, ir, n)

% Inputs:
% P = amount of money
% ir = interest rate
% Outputs:
% A = annual payment

if nargin < 3
    P = 100000; %$
    ir = 0.033; %unitless
    n = 5; %unitless
end
    
nn = 1:n;
A = P*ir*(1+ir).^nn./((1+ir).^nn-1);
y = [nn;A];
% fprintf('\n year \t annual payment\n');
% fprintf('%5d \t %14.2f\n',y);

y2=array2table(y','VariableNames',{'Num_annualpayment', 'Annual_payment'});
disp(y2)

end