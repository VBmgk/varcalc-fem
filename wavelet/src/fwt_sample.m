pkg load ltfat
pkg load signal

%
% chirp
%
t  = linspace(0, 1, 1000);
fs = 1 /(t(2) - t(1));
y = chirp(t, 50, 1, 200); %[f,fs] = greasy;
J = 10;

[w,info] = fwt(y,'db8',J);

figure;

subplot      (2,2,1);
plot         (t ,y );
subplot      (2,2,2);
plotwavelets (w,info,fs,'dynrange',90);

%
% greasy
%
[y,fs] = greasy;
[w,info] = fwt(y,'db8',J);

subplot (2,2,3);
plot    ((1:5880)/16000,greasy);
xlabel  ('Time (s)' );
ylabel  ('Amplitude');

subplot      (2,2,4);
plotwavelets (w,info,fs,'dynrange',90);

print -djpeg 'imgs/fast_wavelet_transform.jpg' % This will save as a JPEG image
