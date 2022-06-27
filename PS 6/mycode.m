Rt = R' ;

M = mean(Rt, 1);
means = repmat (M, length(Rt),1);



centered = Rt - means;
covariances = cov(centered);
[F,V] = eig(covariances);
[vars,ind] = sort(diag(V)); %decreasing order of variance
vars = flip(vars);
ind = flip(ind);
cum_var = cumsum(vars); %cumulative variance percent

figure(1);
x = 1:143;
scatter(x,cum_var/cum_var(143),"filled");
xlabel("Eigenvalue Number");
ylabel("Fraction of Variance"); 

%% Neuron 6 and 7 matches or not
figure(2);

c = jet(8);

co=[];
for i = 1:length(centered)
    temp = c(direction(i),:);
    co = [co; temp];
end

scatter(centered(:,7),centered(:,8),50,co,'filled')
title("Neuron 6 and 7 Check");
xlabel("Neuron 7");
ylabel("Neuron 8");
colormap(c);
colorbar('Ticks',[0.05 0.175 0.3 0.425 0.55 0.69 0.82 0.94],'TickLabels',["0 deg" "45 deg" "90 deg" "135 deg" "180 deg" "225 deg" "270 deg" "315 deg"])

%% PCA
figure(3);
F = F(:,ind);
basis = F(:,1:2);
proj = centered * basis;
scatter(proj(:,1),proj(:,2),50,co,'filled');
title("PCA on Motor Neurons");
colormap(c);
colorbar('Ticks',[0.05 0.175 0.3 0.425 0.55 0.69 0.82 0.94],'TickLabels',["0 deg" "45 deg" "90 deg" "135 deg" "180 deg" "225 deg" "270 deg" "315 deg"])

%% Motor Arm, Only A, Move up

up = [];
for i=1:length(direction)
    if direction(i,:) == 3
        up = [up i];
    end
end

Va=[];
for i =1:length(up)
    Va = [Va; basis(:,1)'*centered(up(i),:)'];
end
disp("The mean and standard deviation of Voltage at A is");
disp(mean(Va));
disp(std(Va));

%% Motor Arm, Only B, Move up

Vb=[];
for i =1:length(up)
    Vb = [Vb; basis(:,2)'*centered(up(i),:)'];
end
disp("The mean and standard deviation of Voltage at B is");
disp(mean(Vb));
disp(std(Vb));