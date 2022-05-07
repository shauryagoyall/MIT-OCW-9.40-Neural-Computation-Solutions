function rate=betam(v)
% input: v: membrane potential in mV
% output: rate: rate constant in ms^-1
theta = (v+70)/18;
rate=4.0*exp(-theta);
end

