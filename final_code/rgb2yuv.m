function yuv  = rgb2yuv(b)

b=[b(1) b(2) b(3)];

b = double(b);

mat = [0.299 0.587 0.114 ; -0.14173 -0.28886 0.436 ; 0.615  -0.51499 -0.10001];

yuv = mat*b';

end