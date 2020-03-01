%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 2, Problem 3 (Sayali Kedari)

%% Problem Description: Solving for depth of the liquid in the storage tank 

function [depth] = lab2_prob3SRK(fin_time,init_time,delt,A,Q,depth0)

% Inputs:
% fin_time = final time
% init_time = start time
% delt = step size
% A = surface area
% Q = flow rate
% depth0 = depth at t=0
% Outputs:
% depth = array of depth values

if nargin < 6
    fin_time = input('Final time : \n'); %day
    init_time = 0; %day
    delt = 0.5; %day
    A = 1250; %m^2
    Q = 450; %m^3/day
    depth0 = 0; %m
end

tlin=init_time:delt:fin_time;
depth = zeros(1,length(tlin));
depth(1) = depth0;
num_int = ((fin_time-init_time)/delt);
for i=1:num_int
    depth(i+1) = depth(i) + (3.0*Q/A*(sin(tlin(i)) * sin(tlin(i))) - Q/A)*delt;
end

%% Plotting solution
figure(1)
plot(tlin,depth);
grid
title('Solution - Depth of the storage tank versus time');
xlabel('Time (days)');
ylabel('Depth (m)');
end