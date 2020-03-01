%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 1, Problem 1 (Sayali Kedari)

%% Problem Description: Calculate volume of horizontal cylinder

function lab1_prob1SRK(r, L, plot_title)
% volume of horizontal cylinder
% inputs:
% r = radius
% L = length
% plot_title = string holding plot title

h = linspace(0,2*r);
V = (r^2*acos((r-h)./r)-(r-h).*sqrt(2*r*h-h.^2))*L;
figure(1)
grid
plot(h, V)
title(plot_title);
xlabel('Height, h');
ylabel('Volume, V');

end
