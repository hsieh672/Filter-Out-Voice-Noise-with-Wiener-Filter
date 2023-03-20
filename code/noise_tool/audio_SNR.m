function [x,fs]=audio_SNR(music,noise,time,SNR2)
s=['fileName=' '''' music ''';'];  	%音樂檔案
eval(s);
[y, fs]=audioread(fileName);          %抓取音樂
s=['fileName=' '''' noise ''';'];   %雜訊檔案
eval(s);
[noise, fs2]=audioread(fileName);     %抓取noise

SNR=SNR2;                           %雜訊比
[col, row]=size(noise);
if row==1
    noise(:,2)=noise(:,1);
end
T2=col;
T=fs*time;%輸出的矩陣大小
mod_num=mod(T,col);
copy_num=fix(T/col);
temp=repmat(noise,copy_num,1);
count=copy_num*col+1;
count_1=1;
for i=count:T                           %改變雜訊時間，配合播放時間
    temp(i,:)=noise(count_1,:);
    count_1=count_1+1;
end
noise=temp;
out_signal=zeros(T,2);                 %建置輸出大小
A_signal_left=sqrt(sum(y(1:T,1).^2));  %計算音樂左聲道的均方根
A_signal_right=sqrt(sum(y(1:T,2).^2)); %計算音樂右聲道的均方根
A_noise_left=sqrt(sum(noise(:,1).^2));    %計算noise左聲道的均方根
A_noise_right=sqrt(sum(noise(:,2).^2));   %計算noise右聲道的均方根
SNR_of=20*log10(A_signal_left^2/A_noise_left^2);    %計算左聲道原本的的雜訊比
SNR_or=20*log10(A_signal_right^2/A_noise_right^2);  %計算右聲道原本的的雜訊比
noise(:,1)=sqrt(10^((SNR_of-SNR)/20))*noise(:,1);   %改變noise聲左聲道的聲音大小
noise(:,2)=sqrt(10^((SNR_or-SNR)/20))*noise(:,2);   %改變noise聲右聲道的聲音大小
out_signal(:,1)=y(1:T,1)+noise(:,1);         %將原本的聲音加入雜訊
out_signal(:,2)=y(1:T,2)+noise(:,2);         %將原本的聲音加入雜訊
out_signal(:,1)=out_signal(:,1)/max(out_signal(:,1)); %將左聲道正規化
out_signal(:,2)=out_signal(:,2)/max(out_signal(:,2)); %將右聲道正規化

audioFile='output1.wav';  %檔案輸出
audiowrite(audioFile,out_signal,fs)

x=out_signal;
fs=fs;
end
