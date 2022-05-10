
excitation = zeros([1 length(Stimulus)]);

for i = 100:length(Stimulus)
    temp = Kernel.*Stimulus(:,i-99:i);
    temp1 = sum( temp , 'all' );
    excitation(i) =  temp1;
end

figure(1);
histogram(excitation);

spike_times = [];
threshold =  1.85*10^(-3)     ;
for i = 1:length(excitation)-1
    
if excitation(i+1)>=threshold && excitation(i)<threshold
        spike_times = [spike_times  i];
end
end    
 
figure(2);
subplot(3,1,1);
imagesc(Stimulus);
colorbar;
xlabel("Time in ms");
ylabel("Log spaced tone frequencies");
colormap(summer);
%colormap(jet);

subplot(3,1,2);
plot(1:length(Stimulus),excitation);
xlabel("Time in ms");
ylabel("Excitatory Drive to Neuron");
yline(threshold,'--', "Linewidth", 2);

subplot(3,1,3);
%xlim([-100 100000]);
ylim([-0.01 0.06]);
line(xlim, [0,0], 'Color', 'k', 'LineWidth', 2);
for i =1:length(spike_times)
    line([spike_times(i) spike_times(i)], [0 0.05], 'Color', 'k', 'LineWidth', 0.5);
end
xlabel("Time in ms");
ylabel("Spikes or Not")

%% Spike Triggered Average (150ms before spike)

sta = zeros([50 length(spike_times)]);
for i =1:length(spike_times)
    sampled = Stimulus(:,spike_times(i)-150:spike_times(i)-1);
    for j=1:50
        temp = sampled(j,:);
        M = mean(temp);
        sta(j,i) = M;
    end
end

figure(3);
surf(1:length(spike_times),logspace(2,4,50),sta,'edgecolor','none');
view(2);
shg;
set(gca, 'fontsize', 16);
set(gca, 'yscale', 'log');
colorbar;
xlabel("Spikes")
ylabel("Frequency on Log Scale")
title("Spike Triggered Average (150ms Before Spike)")


%% Frequency at Spike
sta = zeros([50 length(spike_times)]);
for i =1:length(spike_times)
    sampled = Stimulus(:,spike_times(i));
    for j=1:50
        temp = sampled(j,:);
        M = mean(temp);
        sta(j,i) = M;
    end
end

figure(4);
surf(1:length(spike_times),logspace(2,4,50),sta,'edgecolor','none');
view(2);
shg;
set(gca, 'fontsize', 16);
set(gca, 'yscale', 'log');
colorbar;
xlabel("Spikes")
ylabel("Frequency on Log Scale")
title("At Spike")

%% Spike Triggered Average (150ms before spike - 100ms before spike)

sta = zeros([50 length(spike_times)]);
for i =1:length(spike_times)
    sampled = Stimulus(:,spike_times(i)-150:spike_times(i)-99);
    for j=1:50
        temp = sampled(j,:);
        M = mean(temp);
        sta(j,i) = M;
    end
end

figure(5);
surf(1:length(spike_times),logspace(2,4,50),sta,'edgecolor','none');
view(2);
shg;
set(gca, 'fontsize', 16);
set(gca, 'yscale', 'log');
colorbar;
xlabel("Spikes")
ylabel("Frequency on Log Scale")
title("Spike Triggered Average (150ms - 100ms before Spike)")