function state = SubBytes4(state)
Sbox=[  '08171C10990004AE5B6A0C4095BCC01D';...
        'A1E9A21691322C9BC6BFC9C4F7CF19AB';...
        'DC96F84D5D549CA75FCE8E9A1AB35A7E';...
        '6FAC48A873FD6EF16C79EB89804CD91E';...
        '62E84771700531CB3950BDD8428844EF';...
        '38BA6B864B97DA3001A0D552212733A4';...
        'BB84C190282658EE2E9269143B57F4C3';...
        '3AC82BE4F9F6539ED7DDB14A7B9498B9';...
        'A667788734FC2F7CAFCC15560F367218';...
        '0BEA24B74941FBE32D85D37FB53560B0';...
        '8B595161226D4F37A9B8C709FAFE8F12';...
        '8CA35C06E6BE25C2073D9F810E11C563';...
        'D1134E4577CDDFAD83B61F7420D6E0E1';...
        '1B55DE0D23689D650A5E3CD2EDAA76F5';...
        '8A93F37A02B2E5FFF075EC82A53E43B4';...
        'E7CAE266D48D29032AF24664DB3FD07D'];
Sbox=reshape(hex2dec(reshape(Sbox',2,[])'),16,16); 
state=Sbox(state+1);
end