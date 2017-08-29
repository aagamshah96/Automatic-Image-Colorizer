test_image = imread('../data/train/10.jpeg');

gray_im = rgb2gray(test_image);
    
[l, Am, Sp, d] = slic(test_image, k_factor,m_factor,seradius);  % getting superpixels.
    
centroids = regionprops(l,'centroid'); % return the centroids from the label matrix

for i =[1:length(centroids)] % for some unknown reason centroid's x and y cordinates are comming swapped
    centroids(i).Centroid = round(fliplr(centroids(i).Centroid));
end

final_im = zeros(size(test_image));
    
for i =[1:length(centroids)] % getting boxes around centroid

    x = centroids(i).Centroid(1); % xcordinate of centroid
    y = centroids(i).Centroid(2); % ycordinate of centroid
    if ( ([x-w_size/2,y-w_size/2]>=[1,1])==[1,1]  ) % checking lower limit
        if ( ([x+w_size/2,y+w_size/2]<=[size(im,1),size(im,2)])==[1,1]  ) % checking upper limit 
            imdash_gray = gray_im(x-w_size/2:x+w_size/2,y-w_size/2:y+w_size/2,:); % our required subimage
            imdash_gray = reshape(imdash_gray,1,[]); % converting image to a linear vector
            ff = fft(imdash_gray);
            real_ff = arrayfun(@(x)real(x),ff); % getting real part
            imag_ff = arrayfun(@(x)imag(x),ff); % getting imaginary part
            ff = [real_ff ; imag_ff]; % next two lines for making alternate real and 
            ff = ff(:)' ;
            y_val = mean(imdash_gray);
            test;
            uv;
            rgb = yuv2rgb([y_val uv(1) uv(2)]);
            rgb
            final_im(x-w_size/2:x+w_size/2,y-w_size/2:y+w_size/2,1) = rgb(1);
            final_im(x-w_size/2:x+w_size/2,y-w_size/2:y+w_size/2,2) = rgb(2);
            final_im(x-w_size/2:x+w_size/2,y-w_size/2:y+w_size/2,3) = rgb(3);
        end
    end
end
