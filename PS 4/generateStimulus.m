

m = 50; % number of frequencies
freq = logspace(2, 4, m); % vector of frequencies log spaced from 100 to 10000
dt = .001; % dt that stim matrix is sampled at, in s
Tdur = 1000; % stimulus length in s
Stimulus = zeros(m, Tdur/dt); 

% cosine ramping
t=0:.01:.04;
y = 1-cos(2*5*t*pi).^2;
filler = ones(1,30);
filler(1:5)=y;
filler(26:30)=fliplr(y);

% Start random number generator
rng('shuffle');
for i = 1: Tdur/.03; 
    prob = find(rand(m,1)>0.9);
    tonD = ceil(.03/dt); 
     for k = 1 : length(prob)
         Stimulus(prob(k), (1+(i-1)*tonD):i*tonD) = filler;
     end
  
end

figure(1); imagesc(Stimulus);shg; 
xlabel('time(msec)')
ylabel('Frequency bands')
