% Simulation 1D random walk

% Parameters
numParticles = 500; % Number of parttcles
maxTime = 1000; % end time of simulation in msec

% Time vector
t = 0 : 1 : maxTime;

% Initial position (columnn vector of 0's) 
x0 = zeros(numParticles,1);   

% Matrix to store positions
X = zeros(numParticles, maxTime+1);

% Assign initial condition (position) to first column of X 
X(:,1) = x0; % This is redundant for this particular example
             % but illustrates a general principle.

 %  Main For Loop
    for idx = 2 : 1 : maxTime + 1 % Iterate through time to update position
        
        % Calulate displacement at this time point by generating random
        % numbers. We are flipping 500 coins and mapping heads to 
        % movement to the right and tails to the left (+1 and -1 
        % respectively) 
        dX = 2 * binornd(1,0.5, numParticles,1)-1;  
        
        % Update position at current time: old position + displacement(dX)
        X(:,idx) = X(:,idx-1) + dX;
    end
    
% Plot dynamic histogram
bins = -50.5 : 1 : 50.5;
figure;
shg;
ax = gca;
ax.YLim = [0 0.2];
 for idx = 1 : maxTime + 1
     histogram(ax, X(:,idx), bins, 'Normalization', 'probability');
     ax.YLim = [0 0.2];
     pause(0.01);
 end
