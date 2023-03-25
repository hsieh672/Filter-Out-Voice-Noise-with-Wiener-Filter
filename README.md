# Filter-out-voice-noise-with-Wiener-filter
Eliminate noise by passing the voice signal with noise through a wiener filter and calculate the SSNR of the voice signal, using SSNRI to evaluate the quality of the speech.  
## Clean speech mixed with noise
Use the audio_SNR.m program to mix clean speech into noise speech with a specified noise ratio.  
The equation of the SNR is as the following figure:  
![SNR](https://media.licdn.com/dms/image/C4E12AQE1WRvtwlHJBg/article-cover_image-shrink_423_752/0/1520060174636?e=1684972800&v=beta&t=Cw4LcouOmFYWvcmCdUjEQaK-l-Lj81rLgkZRlpR66is)
```sh
for i=1:10
 fileName=[num2str(i),'.wav']
 x1=SSNRI(fileName,'horn.wav',10,0.5)
 y1=SSNRI(fileName,'horn.wav',50,0.5)
 x2=SSNRI(fileName,'mouse.wav',10,0.5)
 y2=SSNRI(fileName,'mouse.wav',50,0.5)
 x3=SSNRI(fileName,'whitenoise.wav',10,0.5)
 y3=SSNRI(fileName,'whitenoise.wav',50,0.5)
 a{i}={x1,y1;x2,y2;x3,y3}
end
```
