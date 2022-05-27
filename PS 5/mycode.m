load('EEGepilepsy.mat');

%% Visualizing the Epileptic signal

figure(1);
plot(epileptic);
xlabel("Time in ms");
ylabel("Amplitude");
title("Raw Epileptic Signal");

%% Auto correlation Plot

figure(2);
plot(xcorr(epileptic));
xticks([0:1000:10000]);
xticklabels([-5000:1000:5000 ]);
xlabel("Lag in ms");
title("Autocorrelation of Epileptic Signal");


%% Periodogram Code

dt = 1 ;              %sampling interval in ms
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period
N = 5000;             % no of samples in time

% Nyquist Frequency is 500 Hz

U=fft(epileptic);

fvals = Fs*(0:(N/2))/N;  % for the x ticks
%Frequency resolution is 0.2 Hz

mag=abs(U).^2/N;
P1 = mag(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure(3);
subplot(3,1,1);
plot(fvals(1:401),P1(1:401)); %restricting frequency to 80 Hz
xlabel('Frenquency in Hz'); 
ylabel('Power'); 
title('Power spectrum by FFT method in linear');

subplot(3,1,2);
plot(fvals(1:401),10*log10(P1(1:401)));
xlabel('Frenquency in Hz'); 
ylabel('Power  in dB');
title('Power spectrum by FFT method in dB');

subplot(3,1,3);
semilogx(fvals(1:401),10*log10(P1(1:401)));
xlabel('Frenquency in Hz'); 
ylabel('Power  in dB');
title('Power spectrum by FFT method in dB');

%% Removing 60 Hz contaminatin
figure(4);

Ushift = fftshift(U);
Umag = abs(Ushift).^2/N;

subplot(2,1,1);
plot(Umag);
xlabel("Frequency");
ylabel("Absolute Value");
title("Raw");

% Removing 60 Hz signal

for i = 1:length(U)
    if Umag(i) >= 900
        Ushift(i) = 0;
        Umag(i) = 0;
    end
end

subplot(2,1,2);
plot(Umag);
xlabel("Frequency");
ylabel("Absolute Value");
title("Filtered");

%% Inverse Fourier Transform
filtered = ifft(fftshift(Ushift)); %taking fftshift as Ushift has been cleaned

figure(5);
plot(filtered);
xlabel("Time in ms");
ylabel("Amplitude");
title("Filtered Epileptic Signal");

%% Filtered Periodogram

figure(6);
plot(fvals(1:401),Umag(2501:2901),"k."); %restricting frequency to 80 Hz
xlabel('Frenquency in Hz'); 
ylabel('Power'); 
title('Power spectrum by FFT method in linear');

%% Padded Periodogram
dt = 1 ;              %sampling interval in ms
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period
N = 5000*5;             % no of samples in time

% Nyquist Frequency is 500 Hz
padded = [filtered zeros(1,5000*4)];
U=fft(padded);

fvals = Fs*(0:(N/2))/N;  % for the x ticks
%Frequency resolution is 0.2 Hz

mag=abs(U).^2/N;
P1 = mag(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure(7);
plot(fvals(1:2001),P1(1:2001),"k."); %restricting frequency to 80 Hz
xlabel('Frenquency in Hz'); 
ylabel('Power'); 
title('Power spectrum by FFT method in linear');

%% Spectrum with Zero Pad = 0
figure(8);
TW = [1.5 2 5];
for i = 1:length(TW)
    [ Spec,Fvec ] = WSpec( filtered,TW(i),1,0,1000);
    subplot(3,1,i);
    plot(Fvec(1:80),Spec(1:80));
    xlabel("Frequency");
    ylabel("Spectrum");
end
%% Spectrum with Zero Pad = 5
figure(9);
TW = [1.5 2 5];
for i = 1:length(TW)
    [ Spec,Fvec ] = WSpec( filtered,TW(i),1,5,1000);
    subplot(3,1,i);
    plot(Fvec(1:400),Spec(1:400));
    xlabel("Frequency");
    ylabel("Spectrum");
end

%% Spectogram of Epileptic
figure(10);
[ Specgram,Fvec, Tvec ] = WSpecgram( filtered,2,1,0.05,5,1000);
surf(Tvec,Fvec,Specgram,'edgecolor','none');
view(2);
shg;
set(gca, 'fontsize', 16);
colorbar;
xlabel("Time in sec");
ylabel("Frequency in Hz");
title("Spectogram of Epileptic Signal");
ylim([0 30]);

%% Visualizing the Normal signal

figure(11);
plot(normal);
xlabel("Time in ms");
ylabel("Amplitude");
title("Normal Signal");
%% Auto correlation Plot

figure(12);
plot(xcorr(normal));
xticks([0:1000:10000]);
xticklabels([-5000:1000:5000 ]);
xlabel("Lag in ms");
title("Autocorrelation of Normal Signal");


%% Spectogram of Normal
figure(13);
[ Specgram,Fvec, Tvec ] = WSpecgram( normal,2,1,0.05,5,1000);
surf(Tvec,Fvec,Specgram,'edgecolor','none');
view(2);
shg;
set(gca, 'fontsize', 16);
colorbar;
xlabel("Time in sec");
ylabel("Frequency in Hz");
title("Spectogram of Normal Signal");
ylim([0 30]);