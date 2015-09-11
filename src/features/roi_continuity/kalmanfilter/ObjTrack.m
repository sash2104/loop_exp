%   Copyright 2010 The MathWorks, Inc.
function estPt = ObjTrack(position)
%#codegen
% First, setup the figure
numPts = 5;               % Process and plot n samples
% figure;hold;grid;            % Prepare plot window
% x_est = [position(1,1), position(2,1) 0 0 0 0]'; %[x y Vx Vy Ax Ay]'
% p_est = 1000*eye(6);
% Q = eye(6);
x_est = [position(1,1), position(2,1) 0 0]'; %[x y Vx Vy]'
p_est = 100*eye(4);
Q = eye(4);
R = 1000 * eye(2);
% Main loop
pos_est = [];
for idx = 1: numPts
  z = position(:,idx);     % Get the input data
  [y,x_est,p_est] = kalmanfilter(z, x_est, p_est, Q, R);        % Call Kalman filter to estimate the position
  % plot_trajectory(z,y);    % Plot the results
  pos_est = [pos_est y];

end
estPt = pos_est(:,numPts);
%hold;
end   % of the function
