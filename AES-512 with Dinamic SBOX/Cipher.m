function Out = Cipher(key,In,PRNG)
%PRNG secventa initiala din lfsr
w=KeyExpansion(key);%
state=reshape(In,8,[])';
state=AddRoundKey(state,w(:,1:8));
for k=2:11
    if((PRNG>=0) && (PRNG<=100))
    state=SubBytes(state);
    end
    if((PRNG>=101) && (PRNG<=200))
    state=SubBytes2(state);
    end
    if((PRNG>=201) && (PRNG<=300))
    state=SubBytes3(state);
    end
    if((PRNG>=301) && (PRNG<=400))
    state=SubBytes4(state);
    end
    if((PRNG>=401) && (PRNG<=511))
    state=SubBytes5(state);
    end
    state=railfence(state);
    state=MixColumns(state);
    state=AddRoundKey(state,w(:,8*(k-1)+1:8*k));
end
Out=state(:,:);
%Out=lower(dec2hex(Out(1:length(In)))');%
%Out=Out(:)';%
end