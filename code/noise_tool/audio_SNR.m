function [x,fs]=audio_SNR(music,noise,time,SNR2)
s=['fileName=' '''' music ''';'];  	%�����ɮ�
eval(s);
[y, fs]=audioread(fileName);          %�������
s=['fileName=' '''' noise ''';'];   %���T�ɮ�
eval(s);
[noise, fs2]=audioread(fileName);     %���noise

SNR=SNR2;                           %���T��
[col, row]=size(noise);
if row==1
    noise(:,2)=noise(:,1);
end
T2=col;
T=fs*time;%��X���x�}�j�p
mod_num=mod(T,col);
copy_num=fix(T/col);
temp=repmat(noise,copy_num,1);
count=copy_num*col+1;
count_1=1;
for i=count:T                           %�������T�ɶ��A�t�X����ɶ�
    temp(i,:)=noise(count_1,:);
    count_1=count_1+1;
end
noise=temp;
out_signal=zeros(T,2);                 %�ظm��X�j�p
A_signal_left=sqrt(sum(y(1:T,1).^2));  %�p�⭵�֥��n�D�������
A_signal_right=sqrt(sum(y(1:T,2).^2)); %�p�⭵�֥k�n�D�������
A_noise_left=sqrt(sum(noise(:,1).^2));    %�p��noise���n�D�������
A_noise_right=sqrt(sum(noise(:,2).^2));   %�p��noise�k�n�D�������
SNR_of=20*log10(A_signal_left^2/A_noise_left^2);    %�p�⥪�n�D�쥻�������T��
SNR_or=20*log10(A_signal_right^2/A_noise_right^2);  %�p��k�n�D�쥻�������T��
noise(:,1)=sqrt(10^((SNR_of-SNR)/20))*noise(:,1);   %����noise�n���n�D���n���j�p
noise(:,2)=sqrt(10^((SNR_or-SNR)/20))*noise(:,2);   %����noise�n�k�n�D���n���j�p
out_signal(:,1)=y(1:T,1)+noise(:,1);         %�N�쥻���n���[�J���T
out_signal(:,2)=y(1:T,2)+noise(:,2);         %�N�쥻���n���[�J���T
out_signal(:,1)=out_signal(:,1)/max(out_signal(:,1)); %�N���n�D���W��
out_signal(:,2)=out_signal(:,2)/max(out_signal(:,2)); %�N�k�n�D���W��

audioFile='output1.wav';  %�ɮ׿�X
audiowrite(audioFile,out_signal,fs)

x=out_signal;
fs=fs;
end
