%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = (imread('cameraman.tif'));
figure
imshow(imread('cameraman.tif'))
axis on?
grid on?
title('Original image');
theta=0.1;
trans=[1 0 0;0 1 0; 10 10 1];
rot=[cos(0.1) sin(0.1) 0;-1*sin(0.1) cos(0.1) 0? 0 0 1]?
A=[2 0 0?0 2 0? 0 0 1]?
[M,N]=size(I)?
[u,v]=meshgrid(1:M,1:N)?
p=( (A(1)*(u+trans(3))).*cos(theta) ­ (A(5)*(v+trans(6))).*sin(theta) )?
q=( (A(1)*(u+trans(3))).*sin(theta)+(A(5)*(v+trans(6))).*cos(theta))?
[M1,N1]=size(double(imread('cameraman.tif')))?
[p1,q1]=meshgrid(­50:2*M1+100,­10:2*N1+100)?
Vq = griddata(p,q,double(I),p1,q1)?
figure,
imshow(Vq,[]),axis on,grid on,title('final image')?
%%%%%%%%%%%%%%%%%%%%%%%%%