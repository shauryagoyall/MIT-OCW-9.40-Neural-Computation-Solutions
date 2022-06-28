%% Part 2
dt = 1e-4; %time step interval in seconds
t = 1; % in seconds
h =  [117;123] ; %input in Hz from t>=0
tau = 18/1000;%time constant in  seconds

V = (1/sqrt(2))*[1 -1;1 1]; %eigenvector of recurrent weights
D = [-0.5 0; 0 0.9]; %eigenvalues of recurrent weights
C = zeros(2, t/dt);
hf = V'*h; 
Cinf = zeros(2, t/dt);
Cinfy = (inv([1 0;0 1]-D))*hf;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%Change 8000 to 10000 for full second of input
for i=1:8000
    Cinf(:,i) = Cinfy;
end
for i = 1:length(C)
    C(:,i+1) = C(:,i) + (dt/tau)*(Cinf(:,i) - C(:,i));  
    C(:,i) = V*C(:,i); %to get firing rate of individual neuron instead of eigenmodes
end
C(:,i+1) = V*C(:,i+1);

figure(1);
hold on;
plot(1:t/dt+1,C(1,:),"LineWidth", 2);
plot(1:t/dt+1,C(2,:),"LineWidth", 2);
yline(50,"--","LineWidth", 1);
yline(110,":","LineWidth", 2);
legend("Eigenvalue -0.5","Eigenvalue 0.9","50 Hz","110 Hz");
yticks([0 20 40 60 80 100 120]);
xticks([0 2000 4000 6000 8000 10000]);
xticklabels({'0','0.2','0.4','0.6','0.8','1'});
xlabel("Time in seconds");
ylabel("Output Firing Rate in Hz");
title("Neuron Firing");
ax = gca; 
ax.FontSize = 12; 
xlim([-500 12000]);
ylim([0 120]);
hold off

%%
clear all;
clc;

%% Part 3 
dt = 1e-4; %time step interval in seconds
t = 1; % in seconds
h =  [117;123] ; %input in Hz from t>=0
tau = 18/1000;%time constant in  seconds
M =[0.2 0.8;0.8 0.2];
[V,D] = eig([0.2 0.8;0.8 0.2]);
C = zeros(2, t/dt);
hf1 = V(:,1)'*h; 
hf2 = V(:,2)'*h; 
Cinf = zeros(2, t/dt);
%Cinfy = (inv([1 0;0 1]-D))*hf;
e1 = 1/1.6;

for i=1:8000
    Cinf(1,i) = hf1*e1;
    Cinf(2,i) = hf2;
end
for i = 1:length(C)
    C(1,i+1) = C(1,i) + (dt/tau)*(Cinf(1,i) - C(1,i)); 
    C(2,i+1) = C(2,i) + (dt/tau)*(Cinf(2,i));
end

figure(2);
hold on;
plot(1:t/dt+1,C(1,:),"LineWidth", 2);
plot(1:t/dt+1,C(2,:),"LineWidth", 2);
title("Eigenmodes firing rate of markov recurrent weight matrix");
legend("Eigval -0.6","Eigval 1");

for i = 1:length(C)
    C(:,i) = V*C(:,i);
end  
figure(3);
hold on;
plot(1:t/dt+1,C(1,:),"--","LineWidth", 4);
plot(1:t/dt+1,C(2,:),":","LineWidth", 4);
%yline(50,"--","LineWidth", 1);
%yline(110,":","LineWidth", 2);
legend("Neuron 1","Neuron 2");
%yticks([0 20 40 60 80 100 120]);
xticks([0 2000 4000 6000 8000 10000]);
xticklabels({'0','0.2','0.4','0.6','0.8','1'});
xlabel("Time in seconds");
%ylabel("Output Firing Rate in Hz");
title("Firing rate of neurons with markov recurrent weight");
ax = gca; 
ax.FontSize = 12; 
hold off

