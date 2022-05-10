function PlayStim(M, freq, dt)
[m, N] = size(M);
Tdur = N*dt; 
fs = 40000; % sampling rate for sound playback
Waves = zeros(m, Tdur*fs); 
Amps = Waves; 
ModWaves = Waves; 
t = (1:Tdur*fs)/fs; 
M(M<0) = 0; 
for mi = 1:m
    Waves(mi,:) = sin(2*pi*freq(mi)*t); % pure tone
    Amps(mi,:) = interp1((1:N)*dt, M(mi,:), t, 'spline');% amplitude modulation
    ModWaves(mi,:) = Waves(mi,:).*Amps(mi,:); % Modulated sound
end



Stim = sum(ModWaves, 1); % sum over all frequency bands
Stim = Stim./max(abs(Stim));% Normalization

sound(Stim, fs)% Play sound
