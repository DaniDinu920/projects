function state = AddRoundKey(state,w)
for k=1:8
    state(:,k)=bitxor(state(:,k),w(:,k));
end
end