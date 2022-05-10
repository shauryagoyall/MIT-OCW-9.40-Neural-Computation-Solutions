
dt = .001;% time steps
m = 50;% number of freqwuencies
durK = .1; % kernel duration in seconds
% means
mu1 = [durK/2/dt 10];
mu2 = [durK/2/dt+1 40]; 
mu3 = [durK/2/dt+1 10];
mu4 = [durK/2/dt 40];
% covariance matrix
theta =0; 
R = [cos(theta) -sin(theta); sin(theta) cos(theta)]; 
Sigma =  20*inv(R)*[40 0 ; 0 1]*R; 
x1 = 1:(durK/dt); x2 = 1:m;
% generates kernel
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu1,Sigma)+ mvnpdf([X1(:) X2(:)],mu2,Sigma)...
    -mvnpdf([X1(:) X2(:)],mu3,Sigma)-mvnpdf([X1(:) X2(:)],mu4,Sigma);
F = reshape(F,length(x2),length(x1));

Kernel = F;

%Plot commands
figure(2)
surf(1:100,logspace(2,4,50),Kernel,'edgecolor','none'); axis tight;
view(0,90);shg
set(gca, 'fontsize', 16)
set(gca, 'yscale', 'log')
xlabel('time before spike (msec)', 'fontsize', 20)
ylabel('Frequency (Hz)','fontsize', 20 )
colorbar;
set(gca,'XTIckLabel', num2cell(80:-20:0));