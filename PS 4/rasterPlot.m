function rasterPlot(r,dt, t_on, t_off)

    [trials, intervals] = size(r);

    k = 1;
    for i = trials : -1 : 1
        
        j = find(r(i,:) ~= 0);
        
        if ~isempty(j)
            for t = j

                plot([t*dt t*dt], [k k+.7], 'k', 'LineWidth',1.2);
               
                hold on;
            end
        end
        
        k = k + 1;
    end
    if nargin>2
    area ([t_on t_off], [trials+5 trials+5], trials+1,'ShowBaseLine','off');
    end
    hold off
    xlim([dt intervals*dt])
    ylim([1 trials+10])
    box off
    set(gcf, 'color', 'w')
   
    
end