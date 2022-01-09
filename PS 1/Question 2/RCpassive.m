%Cell Parameters

C = ( 144 * pi * ( 10^(-3) ) );     % Capacitance in nF
R = ( ( 10^(4) ) / ( 144 * pi ) ); % Resistance in MegaOhm
Vrest = -70 ;      	   		    % Leakage current reversal potential in mV


% Integration parameters

dt = 0.1;          		% integration time-step in ms
Tdur = 1000;       		% simulation total time in ms
V0 = Vrest ;            % initial condition in mV
k = ceil(Tdur/dt); 		% total number of iterations
V = zeros(1,k+1);  		% Voltage vector in mV
V(1)= V0;             	% assign to the first element of array V, the initial condition V0

% time vector

t = dt.*(0:k);     		% time vector in ms


% Current pulse parameters    

Tstart = 100 ;         		% curent pulse start time in ms
Tstop = 200 ;          		% curent pulse stop time in ms
Iamplitude = 0.1;     		% current pulse amplitude in nA


I = zeros(1,k+1);  		% current vector in nA
I(t>=Tstart & t<Tstop) = Iamplitude; % Assign amplitude when current is on 

%Tstart = 400 ;         		% curent pulse start time in ms
%Tstop = 500 ;          		% curent pulse stop time in ms
%I(t>=Tstart & t<Tstop) = Iamplitude; % Assign amplitude when current is on 
    



 
% Integration with Exponential Euler loop
    for j = 1 : k
        Vinf = Vrest + ( R * I(j))	;  		% Update V infinity value at j iteration    
        V(j+1) = Vinf + (( V(j) - Vinf) * exp( -1* dt / (C*R) ) ) ; 		% Compute V at iteration j+1 with Exponential Euler rule  
 
    end

%For time constant
Vmax=max(V);       %the maximum occuring value of voltage
Vdecay = Vrest + ((Vmax-Vrest)/exp(1)); %Only 1/e times the voltage change is left at t= time constant 

figure;
plot( t , V );

hold on;
y = Vdecay;
line( [t(1), t(3000)] , [y,y] , 'Color' , 'red'); %plot the voltage that is there at t= time constant after spike
hold off;

legend('Voltage Spike', 'Decay voltage amount')
xlabel("Time in ms");
ylabel("Voltage in mV");
title(" Voltage as a function of Time");

figure;
plot( I.*I , V );
xlabel("Current in nA");
ylabel("Voltage in mV");
title(" Voltage as a function of Square Current")


