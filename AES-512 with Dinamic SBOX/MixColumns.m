function State = MixColumns(state)
State=zeros(8,8);
for a=1:8:57
    State(a)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(xtime(state(a),2),state(a+1)),xtime(state(a+2),3)),state(a+3)),state(a+4)),state(a+5)),state(a+6)),state(a+7));
    State(a+1)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(state(a),xtime(state(a+1),3)),state(a+2)),state(a+3)),state(a+4)),state(a+5)),state(a+6)),xtime(state(a+7),2));
    State(a+2)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(xtime(state(a),3),state(a+1)),state(a+2)),state(a+3)),state(a+4)),state(a+5)),xtime(state(a+6),2)),state(a+7));
    State(a+3)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(state(a),state(a+1)),state(a+2)),state(a+3)),state(a+4)),xtime(state(a+5),2)),state(a+6)),xtime(state(a+7),3));
    State(a+4)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(state(a),state(a+1)),state(a+2)),state(a+3)),xtime(state(a+4),2)),state(a+5)),xtime(state(a+6),3)),state(a+7));
    State(a+5)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(state(a),state(a+1)),state(a+2)),xtime(state(a+3),2)),state(a+4)),xtime(state(a+5),3)),state(a+6)),state(a+7));
    State(a+6)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(state(a),state(a+1)),xtime(state(a+2),2)),state(a+3)),xtime(state(a+4),3)),state(a+5)),state(a+6)),state(a+7));
    State(a+7)=bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(bitxor(state(a),xtime(state(a+1),2)),state(a+2)),xtime(state(a+3),3)),state(a+4)),state(a+5)),state(a+6)),state(a+7));
end
end