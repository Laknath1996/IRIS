
function fill_blocks(xi,xo,yi,yo,dataParams,baselines,n)
j = 1;
    for i = 1:10:(n-1)*10+1
        
        %select the section
        x = [xo(i:i+10),xi(i+10:-1:i)];
        y = [yo(i:i+10),yi(i+10:-1:i)];
        
        %define the sample variables
        X = dataParams(:,j);Y = baselines(:,j);
        
        %run the paired t test in right tail and left tail at sig. level 5%
        [h_mid,p_mid] = ttest2(X,Y); % perform the two sample unapaired t-test
        
        if (p_mid < 0.0001)
            fill(x,y,[0 0.5 0]);
        elseif (p_mid <= 0.001)
            fill(x,y,[0.1 1 0.1]);
        elseif (p_mid <= 0.01)
            fill(x,y,[0.4 1 0.4]);
        elseif (p_mid <= 0.05)
            fill(x,y,[0.8 1 0.8]);
        else
            fill(x,y,[1 1 1]);
        end
       
        j = j + 1;
    end
end