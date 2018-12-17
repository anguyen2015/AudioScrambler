% Load some speech(filename, samples)
[x,Fs] = audioread('original.wav');
% Shuffle a 25 ms Window, within a range of 250ms from the original
% position (framming)
y = shuffle(x,round(Fs*.025),round(Fs*.25));
% Write the Scrambled Audio
audiowrite('scrambled.wav',y,Fs);
% Play back the scrambled audio & save the sample size 
soundsc(y,Fs);

% Testing Function to Plot Magnitude and Phase
ydft = fft(x);
% Assume Y has equal length
ydft = ydft(1:length(x)/2+1);
% Create a Freq. vector
freq = 0:Fs/length(x):Fs/2;
% Plot Magnitude
subplot(211);
plot(freq,abs(ydft));
% Plot Phase
subplot(212);
plot(freq,unwrap(angle(ydft))); 
xlabel('Hz');