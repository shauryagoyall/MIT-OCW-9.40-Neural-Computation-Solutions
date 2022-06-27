%% Program to demonstrate perceptron learning rule
%
%rng(50);                 % Seed random number generator for reproducibility
m1=1000;                 % number of samples in set 1
m2=m1;                	 % number of samples in set 2
m=m1+m2;				 % total number of samples
%
a=4;					 % Cluster 1 centered at position (4,4) 
b=0;					 % Cluster 2 centered at position (0,0) 
c1=repmat([a ; a], 1, m1);    % center of cluster 1 (4,4)
c2=repmat([b ; b], 1, m2);    % center of cluster 2 (0,0)
%
x1=c1+randn(2, m1);      % set 1 is a Gaussian cluster centered at c1
x2=c2+randn(2, m2);      % set 2 is a Gaussian cluster centered at c2

T1=ones(1, m1) ;         % Classes coded as 1 and 0
T2=zeros(1,m2);

T=cat(2,T1,T2);% Class labels
x=cat(2,x1,x2); % data points
%

fg =figure(1);
plot(x1(1,:), x1(2,:), 'ob')
hold on
plot(x2(1,:), x2(2,:), 'or')
ax = gca;
ax.XAxisLocation='origin';
ax.YAxisLocation='origin';
ax.LineWidth=2;
ax.FontSize=14;
box off
fg.Color='w';


j=randperm(m);% Random permutation of the data points
T=T(j);
x=x(:,j);

theta=1;% Threshold
eta=0.05;% learning rate

w=[0;0];                % initial guess for weight vector  
 

% Visit the data points in random sequence to learn the weights
for i=1:m
   
   output = sum( x(:,i)' * w );
   
   if output >= theta
       fire = 1;
   else
       fire = 0;
   end
   
   %Updating weights if guess is wrong
   if fire == T(i)
   
   %weight vector is moved towards the point in each case    
   else
       %If blue but found red
       if T(i) == 1
           w = w + ( eta * x(:,i) );
           
       %If red but found blue
       else
           w = w - ( eta * x(:,i) );
       end
   end

end

%%% Decision boundary%%%

xmax = max( x(1,:));
xmin = min( x(1,:));

x = xmin : 0.5 : xmax;
y = ( 1 - w(1)*x ) / w(2); % W*U = Theta therefore w1x1 + w2x2 = theta

plot(x,y, 'g-', 'LineWidth', 2);


hold off


