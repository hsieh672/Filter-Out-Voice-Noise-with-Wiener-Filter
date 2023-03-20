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