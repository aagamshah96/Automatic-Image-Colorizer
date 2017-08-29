function rgb  = yuv2rgb(a)

b=a;
b = double(b);

mat = [0.299 0.587 0.114 ; -0.14173 -0.28886 0.436 ; 0.615  -0.51499 -0.10001];
mat = inv(mat);

rgb = b*mat;

end