function E = NernstPotential(Cin, Cout,z,T)
%NERNSTPOTENTIAL: Computes Nernst potential at specified T in celsius
%
% Input Arguments:
% Cin: internal ionic concteration
% Cout: external ionic concentation
% z: ion valence (with sign)
% T : temperature in degres Celsius
%
% Output:
% E: Nernst potential in mV
%
% Note : Cin are Cout need to be in the same units

    T = T + 273.15; %temperature celsius to kelvin
    q = 1.6 * 10^(-19); %charge of a monovalent ion in coulomb 
    k = 1.38 * 10^(-23); %Boltzmann constant in J/K
    E = ((k * T) / (z * q))* log( Cout / Cin ) * 1000; %Nernst potential formula in mV
end

%Potassium 
%Kout = 4.8; %in mM
%Kin = 186;  %in mM 
%Kz = 1;
%T = 37; %in celsius
%disp("Potential of potassium") 
%NernstPotential( 186, 4.8, 1, 37)
%Kpotential = NernstPotential( Kin, Kout, Kz, T)

%Calcium
%Caout = 1.5; %in mM
%Cain = 0.00005; %in mM 
%Cz = 2;
%T = 37; %in celsius
%disp("Potential of calcium") 
%Capotential = NernstPotential( Cain, Caout, Caz, T)




