% Generate some sample data (e.g., a sine wave with some noise)
t = linspace (0, 1, 10000); % Time vector from 0 to 1 second with 1000 points
f = 50;                    % Frequency of the sine wave in Hz
y = sin (2 * pi * f * t) + 0.2 * randn(size(t)); % Sine wave with added noise
Y = fft (y); % Perform the FFT

% Calculate the frequency vector
n = length(y);
fs = 1 / (t(2) - t(1)); % Sampling frequency
f = (0:n-1) * (fs/n);

%
% Plots
%
figure;
subplot (3,1,1);
plot    (t,y  );
xlim    ([0 1]);
xlabel  ('Time (S)'  );
ylabel  ('Magnitude' );
title   ('sin(2*pi*f*5) + 2');

subplot (3,1,2);
plot    (f, abs(Y)/n );
xlim    ([0 fs/2]    );
xlabel  ('Frequency (Hz)'    );
ylabel  ('Magnitude'         );
title   ('Magnitude Spectrum');

subplot (3,1,3);
plot    (f, angle(Y));
xlim    ([0 fs/2]   );
xlabel  ('Frequency (Hz)' );
ylabel  ('Phase (radians)');
title   ('Phase Spectrum' );

set(gcf, 'color', 'w');          % Set figure background to white
print -djpeg 'imgs/fft_plot.jpg' % This will save as a JPEG image
