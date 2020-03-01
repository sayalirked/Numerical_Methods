%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 1, Problem 2 (Sayali Kedari)

%% Problem Description: Solving for concentration of the contaminant 
%                       for the reactor

function [concn, slope] = lab1_prob2SRK(k, delt, concn0, init_time, fin_time)
% Inputs:
% k = constant with units of day^(-1)
% delt = step size
% concn0 = concentration at t=0
% init_time = start time
% fin_time = final time;
% Outputs:
% concn = values of concentration for all times
% slope = value of slope of graph

if nargin < 5
    k = 0.175;
    delt = 0.1;
    concn0 = 100;
    init_time = 0;
    fin_time = 1;
end

tlin = (init_time:delt:fin_time);
concn = zeros(1,length(tlin));   %preallocate array
concn(1) = concn0;
num_int = ((fin_time-init_time)/delt);
for i=1:num_int
    concn(i+1) = concn(i) + (-k*concn(i))*delt;
end

%% Plotting solution
figure(1)
grid
semilogy(tlin,concn);
title('Concentration of the contaminant over time');
xlabel('Time (days)');
ylabel('ln c');

%% Calculation of slope
coefficients = polyfit(tlin,concn, 1);
% Now get the slope, which is the first coefficient in the array:
slope = coefficients(1);
fprintf(['Slope of the graph = ' num2str(slope) '\n']);

%% Interpret the results
fprintf('The concentration of the contaminant reduces with increase in time, hence the negative slope \n');
end