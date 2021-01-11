function state = SubBytes2(state)
Sbox=[ '051A111D940D09A35667014D98B1CD10';...
      'ACE4AF1B9C3F2196CBB2C4C9FAC214A6';...
      'D19BF540505991AA52C3839717BE5773';...
      '62A145A57EF063FC6174E6848D41D413';...
      '6FE54A7C7D083CC6345DB0D54F8549E2';...
      '35B7668B469AD73D0CADD85F2C2A3EA9';...
      'B689CC9D252B55E3239F6419365AF9CE';...
      '37C526E9F4FB5E93DAD0BC47769995B4';...
      'AB6A758A39F12271A2C1185B023B7F15';...
      '06E729BA444CF6EE2088DE72B8386DBD';...
      '86545C6C2F60423AA4B5CA04F7F3821F';...
      '81AE510BEBB328CF0A30928C031CC86E';...
      'DC1E43487AC0D2A08EBB12792DDBEDEC';...
      '1658D3002E659068075331DFE0A77BF8';...
      '879EFE770FBFE8F2FD78E18FA8334EB9';...
      'EAC7EF6BD980240E27FF4B69D632DD70'];
Sbox=reshape(hex2dec(reshape(Sbox',2,[])'),16,16); 
state=Sbox(state+1);
end