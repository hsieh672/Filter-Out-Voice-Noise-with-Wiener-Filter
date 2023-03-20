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




