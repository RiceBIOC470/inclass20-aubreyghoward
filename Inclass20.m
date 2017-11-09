%Inclass 20
clear all
%In this folder you will find a .mat file with x and y data
load ('data.mat')
% For all of the questions below, use any options as necessary to get a
% good fit - starting points, lower bounds etc. 

% 1. Define a custom model and try to fit the data to a Michaelis function 
% y = V*x/(K+x). 
figure(1);
plot(xx,yy,'r.');
xlabel('x data'); ylabel('y data');
fit_str = 'V*x/(K+x)';
fit_model = fittype(fit_str);
coeffid = {coeffnames(fit_model)};

yy_shift = yy+0.1191;%shift 0 point to avoid negative y values. 
[BestFit] = findBestFit (xx,yy_shift,fit_model)

figure(2);
plot(BestFit.fit_out,xx,yy_shift);

% 2. Use a custom model to try to fit the data to a Hill function with
% exponent 2: y = V*x^2/(K^2+x^2)
fit_str2 = 'V*x^2/(K^2+x^2)';
fit_model2 = fittype(fit_str2);
coeffid2 = {coeffnames(fit_model2)};
[BestFit2] = findBestFit (xx,yy_shift,fit_model2)
figure(3);
plot(BestFit2.fit_out,xx,yy_shift);

% 3. Now treat the exponent as a free parameter and perform the fit again,
% that is fit to the model y = V*x^n/(K^n+x^n)
figure(3);
plot(xx,yy_shift,'b.');
hold on;
for n = 1:10
fit_str3 = ['V*x^' num2str(n) '/(K^' num2str(n) '+x^' num2str(n) ')'];
fit_model3 = fittype(fit_str3);
[BestFit3] = findBestFit (xx,yy_shift,fit_model3);
plot(BestFit3.fit_out)
hold on;
end
% 4. Redo parts 1 and 2, but using your model from 3 and fixing the value of
% n to either 1 or 2.
n = 2;
fit_str4 = ['V*x^' num2str(n) '/(K^' num2str(n) '+x^' num2str(n) ')'];
fit_model4 = fittype(fit_str4);
[BestFit4] = findBestFit (xx,yy_shift,fit_model4);
figure(4);
plot(BestFit4.fit_out,xx,yy_shift)
