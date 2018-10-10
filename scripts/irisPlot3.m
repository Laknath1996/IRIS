%Author : Ashwin de Silva
%Iris plot 1 : performs the un-paired two-tailed t-test and visualize the
%variation 

%inputs ==> 
%dataParams : n x m matrix (patient)
%baselines  : n x m matrix (ctrl)
%where m = number of dataParams (default 40), n = number of samples each
%dataParam has)

function irisPlot3(patient, ctrl)%,save_path)
    figure1 = figure('Color',[1 1 1],'Units','normalized','outerposition',[0 0 1 1]);
    n = size(patient{1},2); % number of features
    num_rings = numel(patient);
    a = linspace(pi/2 + 15*pi/180, pi/2 + 15*pi/180 + 330*pi/180, 10*n+1); 
    % b = linspace(pi/2 + 15*pi/180 + (330/(2*n))*pi/180, pi/2+ 15*pi/180 + 330*pi/180 + (330/(2*n))*pi/180, n+1); 
    
    b = [pi/2 + 15*pi/180 + (330/(2*n))*pi/180];
    for i = 1:n-1
        b(end+1) = b(end) + (330/(n))*pi/180;
    end
   
    a = fliplr(a);
    
    r_rings = [1.5,2,2.5,3,3.5,4,4.5,5,5.5]; % define the the ring radii
    r_rings = r_rings(1:num_rings+1); % select the required rings radii
    r_labels = r_rings(end)+0.4; 
    
    % draw the rings
    X = {}; Y = {};
    for i = 1:num_rings+1
        x = r_rings(i)*cos(a);y = r_rings(i)*sin(a);
        X{i} = x; Y{i} = y;
        plot(x, y,'k','LineWidth',3);hold on;
    end
    
    axis equal
    
    % draw the rungs
    for i = 1:num_rings
        plot([X{i}(1:10:end); X{i+1}(1:10:end)], [Y{i}(1:10:end); Y{i+1}(1:10:end)],'k','LineWidth',3);hold on;
        text(-0.01,r_rings(i)+0.3,num2str(i),'Color','k','FontWeight','bold','FontSize',15)   
    end
    hold on;
    color = get(gcf,'Color');
    set(gca,'XColor',color,'YColor',color,'TickDir','out')
    
    % label the blocks
    xl = r_labels*cos(b); yl = r_labels*sin(b);
    for ii = 1:n
        text(xl(n+1-ii),yl(n+1-ii),num2str(ii),'Color','k')   
    end
    
    %add the section labels
    legend1(figure1);
    
    %plottools(figure1);
    for i = 1:num_rings
        fill_blocks(X{i},X{i+1},Y{i},Y{i+1},patient{i},ctrl{i},n);
    end
    
    cf = pwd;
    %cd(save_path);
    %saveas(gcf,'IP.jpg');
    %cd(cf);
end
