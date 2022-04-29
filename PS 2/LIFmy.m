function [V,I,t,spikeTimes] = LIFmy(amp)

%Cell Parameters

C =  0.2005;     	% Capacitance in nF
R = 100;         	   	% Resistance in MegaOhm
Vrest = -75 ;      	   		% Leakage current reversal potential in mV
Vreset = -70 ;            % Reset potential in mV   
Vth = -50;                 %Threshold voltage     

% Integration parameters

dt = 0.01;          		% integration time-step in ms
Tdur = 1000;       		% simulation total time in ms
V0 = -70;             		% initial condition in mV
k = ceil(Tdur/dt); 		% total number of iterations
V = zeros(1,k+1);  		% Voltage vector in mV
V(1)= V0;           % assign to the first element of array V, the initial condition V0

% time vector

t = dt.*(0:k);     		% time vector in ms


% Current pulse parameters    

Tstart = 200;         		% curent pulse start time in ms
Tstop = 700;          		% curent pulse stop time in ms
Iamplitude = amp;     		% current pulse amplitude in nA


I = zeros(1,k+1);  		% current vector in nA
I(t>=Tstart & t<Tstop) = Iamplitude; % Assign amplitude when current is on 
   
spikeTimes=[];
z = 1;
% Integration with Exponential Euler loop
    for j = 1 : k
        Vinf = Vrest + (R*I(:,j))	;  		% Update V infinity value at j iteration    
        V(j+1) = Vinf + ((V(j) - Vinf)*(exp(-dt/(R*C)))); 		% Compute V at iteration j+1 with Exponential Euler rule  
        if V(j+1) >= Vth
           V(j+1) = Vreset;
           spikeTimes(z) = j;
           z = z + 1;
        end
    end

end

