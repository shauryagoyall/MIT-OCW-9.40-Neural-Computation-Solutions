function rate=betan(v)
% input: v: membrane potential in mV
% output: rate: rate constant in ms^-1
theta = (v+70)/80;
rate=0.125*exp(-theta);
end
