%Cell Parameters

C = ;        	   		% Capacitance in nF
R = ;         	   		% Resistance in MegaOhm
Vrest = ;      	   		% Leakage current reversal potential in mV


% Integration parameters

dt = 0.1;          		% integration time-step in ms
Tdur = 1000;       		% simulation total time in ms
V0 = ;             		% initial condition in mV
k = ceil(Tdur/dt); 		% total number of iterations
V = zeros(1,k+1);  		% Voltage vector in mV
V(1)=;             		% assign to the first element of array V, the initial condition V0

% time vector

t = dt.*(0:k);     		% time vector in ms


% Current pulse parameters    

Tstart = ;         		% curent pulse start time in ms
Tstop = ;          		% curent pulse stop time in ms
Iamplitude = ;     		% current pulse amplitude in nA


I = zeros(1,k+1);  		% current vector in nA
I(t>=Tstart & t<Tstop) = Iamplitude; % Assign amplitude when current is on 
    




% Integration with Exponential Euler loop
    for j = 1 : k
        Vinf = 	;  		% Update V infinity value at j iteration    
        V(j+1) = ; 		% Compute V at iteration j+1 with Exponential Euler rule  
        
    end


