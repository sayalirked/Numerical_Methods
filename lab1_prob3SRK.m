%% Applied Computational Methods (MET 4076) Summer 2018:
% Lab Assignment 1, Problem 3 (Sayali Kedari)

%% Problem Description:	Measuring machine epsilon of your computer

function [mchn_eps] = lab1_prob3SRK()
% Outputs:
% mchn_eps = variable to store precision

format long

mchn_eps=1.0;                       

%% perform iterations
for i = 1:1000
  if (mchn_eps + 1 <= 1)
    mchn_eps = mchn_eps * 2;        % adjust for epsilon
    break
  else
    mchn_eps=mchn_eps/2;
  end
end

% while mchn_eps+1>1
% mchn_eps = mchn_eps/2;
% end
% mchn_eps = 2*mchn_eps;

fprintf('The precision of this computer is \n');			%print results
disp(mchn_eps);

eps_builtin = eps;
fprintf('The precision by built-in function is \n');		%print results
disp(eps_builtin);

end
