tot_data = data;
lamda = 0.6;

x_in = zeros(size(tot_data,2),size(tot_data,2));

% x_in(i,j) = x_in(j,i) -- Using symmetry of the Kernel

for row = 1:size(x_in,2)
    row
    for col = 1:row
        temp = sum((tot_data(:,row)-tot_data(:,col)).^2);
        temp = temp/1000000;
        x_in(row,col) = temp;
        %x_in(row,col) = exp(-temp/2);
        %x_in(row,col)
    end
end

disp('kernel matrix formed');

x_in = x_in + x_in';

for count = 1:size(x_in,2)
    x_in(count,count) = x_in(count,count)/2;
end


if det(x_in + lamda*eye(size(x_in))) > 1e9
    fprintf('\nThe kernel matrix is poorly scaled. Please choose a better scaling parameter.');
    return
end

alpha_u = inv(x_in + lamda*eye(size(x_in)))*u_value';
alpha_v = inv(x_in + lamda*eye(size(x_in)))*v_value';
