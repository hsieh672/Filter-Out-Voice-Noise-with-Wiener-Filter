clc;
clear all;
[input,fs]=audioread('1.wav'); % Load wav (2010-2014 wavread)
sound(input,fs)
mic = [1 2 2]; % Microphone location
nn = 1;  % Reflection frequency
src = [2 3 1];  % Loudspeaker location
rm = [5 5 4];   % Room size
a= -1 ; %Reflection coefficient (-1~1)
h=rir(fs, mic, nn, a, rm, src); % Generate impulse response
d=filter(h,1,input);  % Generate echo 

sound(input,fs)
plot(h)