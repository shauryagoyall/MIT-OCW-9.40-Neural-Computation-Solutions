function [ Spec,Fvec ] = WSpec( DataIn,P,Twin,Zpad,Fs )
% WSpec Computes the spectrum of Data from non-overlapping windows of
% duration Twin. Windows are zero-padded by a factor of Zpad
%
% WSpec( DataIn,P,Twin,Zpad,Fs )
% P is the Time-Bandwidth product for the tapers
% Twin is the length of the short-time window, in seconds
% Fs is the sampling rate in Hertz%  
% Returns the spectrum in Spec, and the array of frequencies in F

Data=DataIn(:)';                        % make Data into a row vector
DataLength=length(Data);                % length of entire data vector
WindowLength=floor(Fs*Twin);            % length of Data window in samples
% find the length of the FFT window
if Zpad == 0
    Nfft=WindowLength;                  % if Zpad=0 use original window
else
    Nfft=2^nextpow2(WindowLength*Zpad); % otherwise use next power of 2
end
df=Fs/Nfft;                             % delta F in the resulting spectrum
NumWindows=floor(DataLength/WindowLength);      % number of windows of length WindowLength that fit into the data
[E,V]=dpss(WindowLength,P);         % get dpss tapers of length nwin
                            % E's are normalized so the variance over the window sums to one
k=2*P-1;                    % how many tapers to keep for time bandwidth product P
tmpSpec=zeros(1,Nfft);      % fill an array for summing up spectrograms
zero_padded=zeros(1,Nfft);  % fill a zero_padding array with zeros
% loop through non-overlapping windows of length nwin
for i1=1:NumWindows                                      
    iwin=1+WindowLength*(i1-1);
    % 'average variance per input data
    % loop through tapers
    tmp=zeros(1,Nfft);
    for j1=1:k
        %multiply windowed data by taper
        zero_padded(1:WindowLength)=Data(iwin:iwin+WindowLength-1).*E(:,j1)'; 
        % compute FFT and accumulate, averaging over k tapers
        tmp=tmp+(abs(fft(zero_padded)).^2)/k;   
    end
    %
    % accumulate, averaging over Nw windows
    tmpSpec=tmpSpec+tmp/NumWindows;
end
% extract positive frequency part of spectrum
Spec=2*tmpSpec(1:Nfft/2+1)/Fs;
% Spec now has units of variance per unit frequency.
%
% To compute variance of the input signal from the spectrum , integrate 
% over a portion of the spectrum (e.g. df*sum(Spec(1:100))),where
% df=Fs/nfft.
%
% For a noise input signal, the variance will be given by the sum over the full
% spectrum. df*sum(Spec)
%
% For a sine wave, the integral over the peak will be the
% average variance of the sine wave (0.5*A^2), where A is the 
% amplitude of the sine wave.
%
% compute frequency vector
Fvec=df*[0:Nfft/2];

end

