function rate=betah(v)
% input: v: membrane potential in mV
% output: rate: rate constant in ms^-1
theta = (v+40)/10;
rate= 1.0 ./ (1+exp(-theta));
end
