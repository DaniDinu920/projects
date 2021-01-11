function w = KeyExpansion(key)
w=reshape(key,8,[]);
count=0;
for i=8:87
% for i=8:15
     temp=w(:,i);
    if mod(i,8)==0
        temp=circshift(temp,-1);
        temp=SubBytes(temp);
        if(count==8)
            temp=bitxor(temp,[27,0,0,0,0,0,0,0]');
        elseif(count==9)
            temp=bitxor(temp,[54,0,0,0,0,0,0,0]');
        elseif(count<8)
            temp=bitxor(temp,[2^(i/8-1),0,0,0,0,0,0,0]');
        end
        count=count+1;
    end
    w(:,i+1)=bitxor(w(:,i-7),temp);
end
end