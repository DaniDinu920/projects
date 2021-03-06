function state = SubBytes3(state)
Sbox=[  '0718131F960F0BA15465034F9AB3CF12';...
        'AEE6AD199E3D2394C9B0C6CBF8C016A4';...
        'D399F742525B93A850C1819515BC5571';...
        '60A347A77CF261FE6376E4868F43D611';...
        '6DE7487E7F0A3EC4365FB2D74D874BE0';...
        '37B564894498D53F0EAFDA5D2E283CAB';...
        'B48BCE9F272957E1219D661B3458FBCC';...
        '35C724EBF6F95C91D8D2BE45749B97B6';...
        'A96877883BF32073A0C31A5900397D17';...
        '04E52BB8464EF4EC228ADC70BA3A6FBF';...
        '84565E6E2D624038A6B7C806F5F1801D';...
        '83AC5309E9B12ACD0832908E011ECA6C';...
        'DE1C414A78C2D0A28CB9107B2FD9EFEE';...
        '145AD1022C67926A055133DDE2A579FA';...
        '859CFC750DBDEAF0FF7AE38DAA314CBB';...
        'E8C5ED69DB82260C25FD496BD430DF72'];
Sbox=reshape(hex2dec(reshape(Sbox',2,[])'),16,16); 
state=Sbox(state+1);
end