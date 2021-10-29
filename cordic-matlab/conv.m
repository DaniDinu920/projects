clear all;
clc;
close all;

teta_grd=[45,26.5650511771,14.0362434679,7.1250163489,3.5763343750,1.7899106082,0.8951737102,0.4476141709,0.2238105004,0.1119056771,0.0559528919,0.0279764526,0.0139882271,0.0069941135,0.0034970567,0.0017485283,8.742641500000000e-04,4.371320750000000e-04,2.185660375000000e-04,1.092830187500000e-04,5.464150937500000e-05,2.732075468750000e-05,1.366037734375000e-05,6.830188671875000e-06,3.415094335937500e-06,1.707547167968750e-06,8.537735839843750e-07,4.268867919921875e-07,2.134433959960937e-07,1.067216979980469e-07,5.336084899902344e-08,2.668042449951172e-08];

teta_fixed=zeros(1,32);

for i=1:length(teta_grd)
    
    teta_fixed(i)=num2fixpt(teta_grd(i),sfix(18),2^-10);
    
    
end

teta_hex = zeros(1,32);


struct.mode = 'fixed';
struct.roundmode = 'floor';
struct.overflowmode = 'saturate';
struct.format = [18 10];

q = quantizer(struct);
teta_hex = num2bin(q,teta_fixed);

str = strings([1,32]);

for i=1:length(teta_hex)
   
    str(i)=teta_hex(i,:);
    
end

