Gs = 1;
Gd = Gs;
Gst = Gs/9 ;  %for G*
alphas = [0, 0.2, 0.5, 1, 2, 5];
Ee = 100; % in mV

x = logspace(-2,3, 100000);
figure(1);
hold on;

for i = 1:length(alphas)
    alpha = alphas(i);
    Gi = alpha * Gd;
    y = [];
    for j = 1:length(x)
       Ge = x(j);
       Vs = (Ge * Gst * Ee)/(Gst*Gd + Gs*Gd + Gs*Gst + Ge*(Gst +Gs) + Gi*(Gs + Gst));
       y(end+1) = Vs;
    end
    semilogx(x, y);
end
set(gca, 'XScale', 'log');
xlabel('Excitory Conductance (G_e)','FontSize', 12);
ylabel('Membrane Potential at Soma (V_s)','FontSize', 12);
yline(9);
ylim([-0.5 12]);
xlim([0 100000]);
xticks([0.01 0.1 1 10 100 1000]);
legend('\alpha = 0','\alpha = 0.2','\alpha = 0.5','\alpha = 1','\alpha = 2','\alpha = 5','FontSize', 10) ;
hold off
f = gcf;
exportgraphics(f,'q2_dendritic_inhibition.png','Resolution',300)