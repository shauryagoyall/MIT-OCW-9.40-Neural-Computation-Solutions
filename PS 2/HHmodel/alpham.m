function rate=alpham(v)
% input: v: membrane potential in mV
% output: rate: rate constant in ms^-1
theta=(v+45)/10;
rate=1.0*theta ./ (1-exp(-theta));
rate(isnan(rate))=1;
end
   %check for case that gives 0/0
   %in that case use L'Hospital's rule

  
