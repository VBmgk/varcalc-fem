pkg load signal

%[psi,xval] = morlet(-4,4,1000);
%plot(xval,psi,"linewidth",4)
%grid on

% Generate some sample data (e.g., a sine wave with some noise)
n_pts = 1000
x_min = -4
x_max = 4
t = linspace (x_min, x_max, n_pts); % Time vector from 0 to 1 second with 1000 points
y = morlet   (x_min, x_max, n_pts);

# Perform the FFT
Y = fft (y);

# Calculate the frequency vector
n = length (y);
fs = 1 / (t(2) - t(1));    % Sampling frequency
f = (0:n-1) * (fs/n);

% Plot the magnitude spectrum
figure;

subplot (3,1,1);
plot    (t,y );
xlim    ([x_min x_max]);
xlabel  ('Time (S)'   );
ylabel  ('Magnitude'  );
title   ('Morlet'     );

subplot (3,1,2);
plot    (f, abs(Y)/n);
xlim    ([0 fs/2]   );
xlabel  ('Frequency (Hz)'    );
ylabel  ('Magnitude'         );
title   ('Magnitude Spectrum');

subplot (3,1,3);
plot    (f, angle(Y));
xlim    ([0 fs/2]);
xlabel  ('Frequency (Hz)' );
ylabel  ('Phase (radians)');
title   ('Phase Spectrum' );

% Improve the plot appearance
set (gcf, 'color', 'w'); % Set figure background to white
print -djpeg 'imgs/wavelet_plot.jpg' % This will save as a JPEG image
