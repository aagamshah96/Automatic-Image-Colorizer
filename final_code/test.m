
    vec_test = ff' ;
    uv =[];
    
    for count1 = 1:size(vec_test,2)
        temp = 0;
        for count2 = 1:size(alpha_u,1)
            temp1 = sum((vec_test(:,count1) - tot_data(:,count2)).^2);
            temp = temp + alpha_u(count2)*exp(-temp1/2);
        end
        uv = [uv temp];
    end
    
    for count1 = 1:size(vec_test,2)
        temp = 0;
        for count2 = 1:size(alpha_v,1)
            temp1 = sum((vec_test(:,count1) - tot_data(:,count2)).^2);
            temp = temp + alpha_v(count2)*exp(-temp1/2);
        end
        uv = [uv temp];
    end
    
