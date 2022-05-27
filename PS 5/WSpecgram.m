function [ Specgram,Fvec, Tvec ] = WSpecgram( DataIn,P,Twin,Tstep,Zpad,Fs)
%WSpecgram Computes the spectrogram of DataIn from overlapping windows of
% length Twin. 
%
% WSpecgram( DataIn,P,Twin,Tstep,Zpad,Fs)
% P is the Time-Bandwidth product for the tapers
% Twin is the length of the short-time window, in seconds
% Tstep is the step increment of the sliding window in seconds
% Fs is the sampling rate in Hertz
% 
% Returns the spectrogram in matrix Specgram
% Returns the frequencies in array Fvec
% Returns the times in array Tvec
% To plot the spectrogram use surf as in problem set 4 part 3 but use
% linear scale for the y-axis
%

Data=DataIn(:)';                        % make Data into a row vector 
DataLength=length(Data) ;                % length of entire data vector
WindowLength=floor(Fs*Twin);             % length of window in samples
Step_size=floor(Fs*Tstep);               % step size for the sliding window, samples

% find the length of the FFT window
if Zpad == 0
    Nfft=WindowLength;                  % if Zpad=0 use original window
else
    Nfft=2^nextpow2(WindowLength*Zpad); % otherwise use next power of 2
end
%
df=Fs/Nfft;
Numsteps=floor((DataLength-WindowLength)/Step_size)-1; % number of steps of the sliding window that fit into L
Specgram=zeros(Nfft/2, Numsteps);
[E,V]=dpss(WindowLength,P);         % get dpss tapers of length WindowLength
                            % E's are normalized so the variance over the window sums to one
k=2*P-1;                    % how many tapers to keep for time bandwidth product P
% loop through non-overlapping windows of length nwin
for i1=1:Numsteps                                      
    iwin=1+Step_size*(i1-1);
    % loop through tapers
    tmpSpec=zeros(1,Nfft);      % fill an array for summing up spectrograms
    zero_padded=zeros(1,Nfft);  % fill a zero_padding array with zeros
    DataWindow=Data(iwin:iwin+WindowLength-1);
    %
    for j1=1:k
        %multiply windowed data by taper
        zero_padded(1:WindowLength)=DataWindow.*E(:,j1)'; 
        % compute FFT and accumulate, averaging over k tapers
        tmpSpec=tmpSpec+(abs(fft(zero_padded)).^2)/k;   
    end
    Specgram(:, i1)=2*tmpSpec(1:Nfft/2)/Fs;
end
% Specgram now has units of variance per unit frequency.
%
epsilon = 1e-7;
Specgram = Specgram + epsilon;% removes noisy background when ploting
Fvec=df*[0:Nfft/2-1];
Tvec = Tstep*(0:1:Numsteps-1);
end

