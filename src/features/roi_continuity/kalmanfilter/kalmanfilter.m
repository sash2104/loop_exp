%   Copyright 2010 The MathWorks, Inc.
function [y, x_est_ret, p_est_ret] = kalmanfilter(z, x_est, p_est, Q, R)
%#codegen
dt=1;
% Initialize state transition matrix
A=[ 1 0 dt 0;...     % [x  ]
    0 1 0 dt;...     % [y  ]
    0 0 1 0 ;...     % [Vx]
    0 0 0 1 ];       % [Vy]
H = [ 1 0 0 0; 0 1 0 0]; % Initialize measurement matrix
%A=[ 1 0 dt 0 0 0;...     % [x  ]
%    0 1 0 dt 0 0;...     % [y  ]
%    0 0 1 0 dt 0;...     % [Vx]
%    0 0 0 1 0 dt;...     % [Vy]
%    0 0 0 0 1 0 ;...     % [Ax]
%    0 0 0 0 0 1 ];       % [Ay]
%H = [ 1 0 0 0 0 0; 0 1 0 0 0 0 ]; % Initialize measurement matrix
% Predicted state and
% covariance
x_prd = A * x_est;
p_prd = A * p_est * A' + Q;
% Estimation
S = H * p_prd' * H' + R;
B = H * p_prd';
klm_gain = (S \ B)';
% Estimated state and
% covariance
x_est = x_prd + klm_gain * (z - H * x_prd);
p_est = p_prd - klm_gain * H * p_prd;
% Compute the estimated
% measurements
y = H * x_est;
x_est_ret = x_est;
p_est_ret = p_est;
end                % of the function...
