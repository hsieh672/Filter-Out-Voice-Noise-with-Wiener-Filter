# Filter-out-voice-noise-with-Wiener-filter
Eliminate noise by passing the voice signal with noise through a wiener filter and calculate the SSNR of the voice signal, using SSNRI to evaluate the quality of the speech.  
## Clean speech mixed with noise
Use the audio_SNR.m program to mix clean speech into noise speech with a specified noise ratio.  
The equation of the SNR is as the following figure:  
![SNR](https://media.licdn.com/dms/image/C4E12AQE1WRvtwlHJBg/article-cover_image-shrink_423_752/0/1520060174636?e=1684972800&v=beta&t=Cw4LcouOmFYWvcmCdUjEQaK-l-Lj81rLgkZRlpR66is)
## Passes noisy speech through Wiener filter
##### The following figure is the bode plot and frequency response of the clean speech(1.wav):  
![1.wav](https://github.com/hsieh672/Filter-out-voice-noise-with-Wiener-filter/blob/main/imag/1.png)  
#### The following figure is the bode plot and frequency response of the noise speech(horn.wav):  
![horn.wav](https://github.com/hsieh672/Filter-out-voice-noise-with-Wiener-filter/blob/main/imag/horn.png)  
#### The following figure is the bode plot and frequency response of the noisy speech(mix.wav):  
![noisy](https://github.com/hsieh672/Filter-out-voice-noise-with-Wiener-filter/blob/main/imag/noisy.png)  
After mixing in the horn.wav noise, the waveform is obviously more complicated than the original file, because horn.wav is a sound file that has been maintained at a high level of loudness, so after extending horn.wav seconds and adding 1.wav, you can see that the amplitude is around plus or minus 0.25, and the waveform of the original horn.wav is superimposed on 1.wav.  

#### The following figure is the bode plot and frequency response of the noisy speech passed through the wienwe filter:  
![filter](https://github.com/hsieh672/Filter-out-voice-noise-with-Wiener-filter/blob/main/imag/pass%20filter.png)  
After the noise is removed from the file with horn noise mixed in, the original waveform in the plus or minus 0.25 range is significantly reduced, making the entire sound file sounds cleaner.  
## Calculate the SSNRI
The SSNRI value is calculated by comparing the speech which passed the filter with the original noise speech as the speech evaluation index.  
```sh
function ssnri=SSNRI(fileName,noise,time,IS)
 
[x,fs1]=audioread(fileName)
[D2,fs2]=audio_SNR(fileName,noise,5,time)
D1=WienerScalart96(D2,fs2,IS)
x=x(1:length(D1),1)
D2=D2(1:length(D1),1)
N=180
m=length(D1)/N
x=reshape(x,N,m)
D1=reshape(D1,N,m)
D2=reshape(D2,N,m)
y=(sum(10*log10(sum(x.^2)./sum((x-D1).^2))))*(1/m)
w=(sum(10*log10(sum(x.^2)./sum((x-D2).^2))))*(1/m)
ssnri=y-w
end

```
