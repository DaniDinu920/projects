clear all
clc
close all
teta_grd=[45,26.5650511771,14.0362434679,7.1250163489,3.5763343750,1.7899106082,0.8951737102,0.4476141709,0.2238105004,0.1119056771,0.0559528919,0.0279764526,0.0139882271,0.0069941135,0.0034970567,0.0017485283,8.742641500000000e-04,4.371320750000000e-04,2.185660375000000e-04,1.092830187500000e-04,5.464150937500000e-05,2.732075468750000e-05,1.366037734375000e-05,6.830188671875000e-06,3.415094335937500e-06,1.707547167968750e-06,8.537735839843750e-07,4.268867919921875e-07,2.134433959960937e-07,1.067216979980469e-07,5.336084899902344e-08,2.668042449951172e-08];
x_in=-3;
y_in=4;
z_in=0;
d_sign=0;
x_reg=zeros(1,32);
y_reg=zeros(1,32);
z_reg=zeros(1,32);
for i=1:length(teta_grd)
 if (i==1)
 if(y_in>=0)
 d_sign=-1;
 else
 d_sign = 1;
 end
 x_reg(i)=x_in-d_sign*2^(-i+1)*y_in;
 y_reg(i)=y_in+d_sign*2^(-i+1)*x_in;
 z_reg(i)=z_in-d_sign*teta_grd(i);
 else
 if (y_reg(i-1)>=0)
 d_sign=-1;
 else
 d_sign=1;
 end
 x_reg(i)=x_reg(i-1)-d_sign*(2^(-i+1)*y_reg(i-1));
 y_reg(i)=y_reg(i-1)+d_sign*(2^(-i+1)*x_reg(i-1));
 z_reg(i)=z_reg(i-1)-d_sign*teta_grd(i);
 end
end