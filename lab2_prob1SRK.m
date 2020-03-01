%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 2, Problem 1 (Sayali Kedari)

%% Problem Description: Calculating velocity of water in a 
% rectangular open channel using Manning's equation

function lab2_prob1SRK(tableval)
% Inputs:
% tableval = [n (unitless), S (unitless), B (m), H (m)]

if nargin < 1
    tableval = [0.035, 0.0001, 10, 2;
                0.020, 0.0002, 8, 1;
                0.015, 0.0010, 20, 1.5;
                0.030, 0.0007, 24, 3;
                0.022, 0.0003, 15, 2.5];
end

%Manning's equation:
% U = tableval(:,5) %m/s
tableval(:,5) = sqrt(tableval(:,2))./tableval(:,1).*(tableval(:,3).*tableval(:,4)./(tableval(:,3)+2*tableval(:,4))).^(2/3);
% fprintf('\n n S B H U\n');
% fprintf('%8.3f %8.4f %10.2f %10.2f %10.4f\n',tableval');

tableval2=array2table(tableval,'VariableNames',{'n', 'S', 'B', 'H', 'U'});
disp(tableval2)

end