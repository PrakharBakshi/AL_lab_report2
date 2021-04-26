clear all;
close all;
i = imread("cameraman.tif");
[M,N] = size(i);

i=im2double(i)+randn(size(i))*0.1;
inew=i;

iter_max = 1000;
lamda = 5;
mu = .1;

for iteration=1:iter_max
    E1 = sum((inew-i).^2);
    E2 = sum(sum(diff(inew,11).^2))+sum(sum(diff(inew,1,2).^2));
   
    z1 = inew-i; 
    s1 = sqrt(10);
    z2 = 2*inew-circshift(inew,-1,1)-circshift(inew,-1,2); 
    s2 = sqrt(10);
    Grad = 2*z1./(z1.^2+2*s1^2) + lamda*2*z2./(z2.^2+2*s2^2);
    inew = inew - mu*Grad;
end

figure(1);
subplot(1,2,1);imshow(i);
subplot(1,2,2);imshow(inew);