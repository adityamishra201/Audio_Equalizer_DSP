% Simple Audio Equalizer in MATLAB

% Load audio file
filename = 'your_audio_file.wav';
[x, fs] = audioread(filename);

% Define equalizer bands (low, mid, high)
low_band = [100 400];   % Low-frequency band (Hz)
mid_band = [400 1600];  % Mid-frequency band (Hz)
high_band = [1600 6400];% High-frequency band (Hz)

% Design FIR filters for each band
order = 100; % Filter order
low_pass_filter = fir1(order, 2*low_band/fs);
mid_pass_filter = fir1(order, 2*mid_band/fs);
high_pass_filter = fir1(order, 2*high_band/fs);

% Apply filters
y_low = filter(low_pass_filter, 1, x);
y_mid = filter(mid_pass_filter, 1, x);
y_high = filter(high_pass_filter, 1, x);

% Sum up the filtered signals
y = y_low + y_mid + y_high;

% Normalize the output to prevent clipping
y = y / max(abs(y));

% Play original and equalized audio
sound(x, fs); % Original audio
pause(length(x)/fs); % Wait for original audio to finish
sound(y, fs); % Equalized audio

% Plot frequency responses of filters
freqz(low_pass_filter, 1, 1024, fs);
hold on;
freqz(mid_pass_filter, 1, 1024, fs);
freqz(high_pass_filter, 1, 1024, fs);
legend('Low-pass Filter', 'Mid-pass Filter', 'High-pass Filter');
title('Equalizer Frequency Response');
hold off;
