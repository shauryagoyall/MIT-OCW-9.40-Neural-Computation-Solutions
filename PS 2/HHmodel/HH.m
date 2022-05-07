% Hodgkin Huxley model 
% Numerically integrated with an Exponential Euler Scheme 

%Units:
%voltage is in millivolts (mV)
%current is in microamperes (uA)
%capacitance is in microfarads (uF)
%conductance is in millisiemens (mS)
%area is in centimeters squared (cm^2)
%time is in milliseconds (ms)

% Area of cell
A = 1; %cm^2
%membrane capacitance per unit area:
C = 1.0;      % (uF/cm^2)
%max possible Na+ conductance per unit area:
gNabar = 120; % (mS/cm^2)
%max possible K+ conductance per unit area:
gKbar = 36;   % (mS/cm^2)
%leakage conductance per unit area:
gLbar = 0.3;  % (mS/cm^2)
%Na+ equilibrium potential:
ENa = 45;   %   (mV)
%K+ equilibrium potential:
EK = -82;   %   (mV)
%leakage channel reversal potential:
EL = -59;   %   (mV)

%initialize time step and experiment duration:
dt = 0.1;     % time step duration (ms)
tmax = 100;    %duration of experiment (ms)

%total number of time steps in the experiment:
niter = ceil(tmax/dt);

%initialize arrays that hold data for plotting:
m_plot = zeros(1,niter);
h_plot = zeros(1,niter);
n_plot = zeros(1,niter);
V_plot = zeros(1,niter);
t_plot = (0:niter-1)*dt;% time vector in ms

%voltage just at t=0: initial condition
vstart = -70;
V_plot(1) = vstart;
% In fact we are assuming V was at -70 before experiment to set m,h,n to 
% their steady state values at -70

% minf, hinf, ninf at -70  for initial condition
m_plot(1) = alpham(V_plot(1))/(alpham(V_plot(1))+betam(V_plot(1)));
h_plot(1) = alphah(V_plot(1))/(alphah(V_plot(1))+betah(V_plot(1)));
n_plot(1) = alphan(V_plot(1))/(alphan(V_plot(1))+betan(V_plot(1)));

% Current injected
Ie = zeros(1, niter);
% square pulse of current starts at 30 ms and ends at 40 ms
Ie(t_plot>= 30 & t_plot<= 40) = 10; % (uA/cm^2)

% Main for loop to numerically integrate the HH model 
for k = 1: niter-1
  % taus for m,h,n
    tau_m = 1 /(alpham(V_plot(k))+betam(V_plot(k)));
    tau_h = 1 /(alphah(V_plot(k))+betah(V_plot(k)));
    tau_n = 1 /(alphan(V_plot(k))+betan(V_plot(k)));
  
  % Steady state values for m, h, n
    m_inf = alpham(V_plot(k))/(alpham(V_plot(k))+betam(V_plot(k)));
    h_inf = alphah(V_plot(k))/(alphah(V_plot(k))+betah(V_plot(k)));
    n_inf = alphan(V_plot(k))/(alphan(V_plot(k))+betan(V_plot(k)));  
  
  % Update m, h, and n using the Exponential-Euler method
    m_plot(k+1) = m_inf+(m_plot(k)-m_inf)*exp(-dt/tau_m);
    h_plot(k+1) = h_inf+(h_plot(k)-h_inf)*exp(-dt/tau_h);
    n_plot(k+1) = n_inf+(n_plot(k)-n_inf)*exp(-dt/tau_n);
  
  % Update conductances
    gNa = gNabar*(m_plot(k+1)^3)*h_plot(k+1);    %sodium conductance
    gK = gKbar*(n_plot(k+1)^4);                  %potassium conductance
    g = gNa+gK+gLbar;                            %total conductance
    gE = gNa*ENa+gK*EK+gLbar*EL;                 %gE=g*E
    
  % update vinf
    V_inf = (gE + Ie(k)/A) / g;
  % update tauv
    tau_V = C/g;
  % exponential euler for updating membrane potential
    V_plot(k+1) = V_inf + (V_plot(k)-V_inf)*exp(-dt/tau_V);
end


figure (1)
subplot(3,1,1)
plot(t_plot, V_plot, 'linewidth',2); ylim([-110 40]);legend('Vm');
%xlabel('time(ms)', 'fontsize', 20)
ylabel('V_m (mV)', 'fontsize', 20)
subplot(3,1,2)
plot(t_plot,Ie, 'LineWidth',2)
%xlabel('time(ms)', 'fontsize', 20)
ylabel('I_e (\muA/cm^2)', 'fontsize', 20)
gating = [m_plot;h_plot;n_plot];
subplot(3,1,3)
plot(t_plot, gating, 'linewidth',2);legend('m', 'h', 'n');
xlabel('time(msec)', 'fontsize', 20)

figure (2)
plot(V_plot,h_plot)
xlim([-100 100])
ylim([0 0.65])
xlabel('V_m (mV)', 'fontsize', 20)
ylabel('gating variable h_{inf}', 'fontsize', 20)