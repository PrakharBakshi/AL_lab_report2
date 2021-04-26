clear all;
close all;

%i = imread("noisy_checkerboard_mrf.jpg");
%[M,N] = size(i);

i(1:100,1:50) = 150+10*randn(100,50);
i(1:100,51:100) = 50 + 10*randn(100,50);

inew = i;
iter_max = 1000;
lamda = 5;
mu = .1;

for iteration=1:iter_max
    E1 = sum(sum((inew-i).^2));
    E2 = sum(sum(diff(inew,1,1).^2))+sum(sum(diff(inew,1,2).^2));
    E(iteration)=E1+E2;
    z1 = inew-i; 
    s1 = sqrt(10);
    z2 = 2*inew-circshift(inew,-1,1)-circshift(inew,-1,2); 
    s2 = sqrt(10);
    Grad = 2*z1./(z1.^2+2*s1^2) + lamda*2*z2./(z2.^2+2*s2^2);
    inew = inew - mu*Grad;
end

figure(1);
subplot(1,2,1);imshow(uint8(i));
subplot(1,2,2);imshow(uint8(inew));