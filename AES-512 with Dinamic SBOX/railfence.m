function R = railfence(state)
    for z=1:8
        State(1,(z*8)-7:(z*8))=state(z,1:8);
    end
    R = zeros(1,64);
    i=1;
    j=1;
    while ((j<=16)&&(i<=64))
            R(j)=State(i);
            j=j+1;
            i=i+4;
    end
    i=2;
    j=17;
    while ((j<=48)&&(i<=64))
            R(j)=State(i);
            j=j+1;
            i=i+2;
    end
    i=3;
    j=49;
    while ((j<=64)&&(i<=64))
            R(j)=State(i);
            j=j+1;
            i=i+4;
    end
    R=reshape(R,8,[])';
end