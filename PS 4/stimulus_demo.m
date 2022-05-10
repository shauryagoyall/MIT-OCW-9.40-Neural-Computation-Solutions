phi=0; % start with 0 phase
while isempty(get(gcf,'currentcharacter')) % wait for key press
x=sin(5*(0:pi/1000:2*pi)+phi); imagesc(x);
colormap(gray);
title('PRESS ANY KEY TO STOP'); drawnow;
pause(0.001);
phi=phi+pi/100; % increment phase end
end