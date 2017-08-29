images = dir('../data/train/*.*jpeg');
data = [];
u_value=[];
v_value=[];
k_factor = 250;
m_factor = 40; 
seradius = 1;
w_size = 16;

disp('total training images are '); 
disp(size(images)); % showing total number of images.

for i =[1:size(images)]
    i
    im = imread(strcat('../data/train/',images(i).name));
    gray_im = rgb2gray(im); % we will be taking fft of gray image .
    
    [l, Am, Sp, d] = slic(im, k_factor,m_factor,seradius);  % getting superpixels.
    
    centroids = regionprops(l,'centroid'); % return the centroids from the label matrix

    for i =[1:length(centroids)] % for some unknown reason centroid's x and y cordinates are comming swapped
        centroids(i).Centroid = round(fliplr(centroids(i).Centroid));
    end
    
    for i =[1:length(centroids)] % getting boxes around centroid
        x = centroids(i).Centroid(1); % xcordinate of centroid
        y = centroids(i).Centroid(2); % ycordinate of centroid
        if ( ([x-w_size/2,y-w_size/2]>=[1,1])==[1,1]  ) % checking lower limit
            if ( ([x+w_size/2,y+w_size/2]<=[size(im,1),size(im,2)])==[1,1]  ) % checking upper limit 
                imdash_col = im(x-w_size/2:x+w_size/2,y-w_size/2:y+w_size/2,:); % our required subimage
                imdash_gray = gray_im(x-w_size/2:x+w_size/2,y-w_size/2:y+w_size/2,:); % our required subimage
                imdash_gray = reshape(imdash_gray,1,[]); % converting image to a linear vector
                imdash_col = reshape(imdash_col,1,[],3); % converting image to a linear vector
                mean_color = mean(imdash_col);
                mean_color_yuv = rgb2yuv(mean_color);
                ff = fft(imdash_gray);
                real_ff = arrayfun(@(x)real(x),ff); % getting real part
                imag_ff = arrayfun(@(x)imag(x),ff); % getting imaginary part
                ff = [real_ff ; imag_ff]; % next two lines for making alternate real and 
                ff = ff(:)' ;
                data =  [data; ff];
                u_value = [u_value; mean_color_yuv(2)];
                v_value = [v_value; mean_color_yuv(3)];
            end
        end
    end
    
end