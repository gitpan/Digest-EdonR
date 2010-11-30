use strict;
use warnings;
use Test::More tests => 68;
use Digest::EdonR qw(edonr_512 edonr_512_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::EdonR->new(512)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            edonr_512_hex($data), $digest,
            "edonr_512_hex: $len bits of $msg"
        );
        ok(
            edonr_512($data) eq pack('H*', $digest),
            "edonr_512: $len bits of $msg"
        );
    }

    my $md = Digest::EdonR->new(512)->add_bits($data, $len)->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $len bits of $msg");
}
continue { $len++ }

__DATA__
00|C57F7E17FDC1CE5074CC748C9BD38F9F51EBE88FBE6EDA3190C4314CAFB1ABB2980FAC582D6E4BA8C641947D944BC56B74FB15DE5546AD4F77934FCA00052719
00|8B558D3668E41B51A7E8178E6BB94F93E1A8AB3F39B1E5BCAB6CB9647C13077CE51EA3ADFCA154BF3579AD10EB7B7678A94DD25D64AC2CE0FC515F544DD99ABA
C0|1043ED21841C3FA96C07281173070D77B01A8DF4D13A7252DD7BAE38004027D6B995402DAF72CA4880319FD959C4AC5DC0389D52811D91CA874A26DFAB9A60CA
C0|7903308A7788FE729489486217BB4D9CC608741C32A95172356CF2350E28CE492AEC1FA9D8C0A8AE123B7B125BFDB88E2D535A50098152A020FB86ECCB38B2D7
80|6B59D9DB6773C6B18332FD85C995D8E4486EA5408F826AD5FAF6831E23204893736A4A98372E87FF8BD8899FB475FF978146B27E833F9088A20CC8E30F93C0DE
48|C283256D63742923250E49EDA6CD5BD0C141653E76B9FD76385A1789131EFA961DF9B0A8CC76EF52E6E6F7C4595ED12B7582CF5C2C6D2E5EE3E7F7E336142571
50|A394F46A9D6C687EAA79173722FBBEC7B2EBD68F664F32B089AF65C7EC7BE8FF63C27A503CB22FED8CCA2AA3C1919B7832B7A363AF2C173708104E97C39F3725
98|2C9B446BD278CB70419927FFE869698FA4E769C64E7F72E3B043631013B75B6B0913BCCC9EE2CF535498EB4EE518BB1AF271C7BDF5A85CC31AA3109900F4293D
CC|5AD53D6B89063F8D22F7B3E7B2B9FFF4B3A56E9CBFD74E2AB42D6FA8F94D9BEF55CB1834B9DF5B40301D8E94502A7C9D1C796CD8C58205C953225E451FFBB5EF
9800|E56A5810A4284C0C1CFDEE9FD343E801D206D2434816196B5283A3C712DA9DEFC8052448976190F8992497336532D9CF9D56A58600F6BE487BF36954C33BCA6C
9D40|D8E2EE8FD2B02208C84AB78F6033A63EF438017AA24609CE46BBA9E1A49005DFC9E70315B3E5A89568F14D08BB16E72BD9C0822B9F28A7BBAE8B0EBB7B4279F5
AA80|8AAA5C7B7A6409DBB5CE454CB12F2B993F5CB9DBE5B687FBE64C2949C5AB98533F6142D989C122F38CA82B1DC6CE9BA9D7D4FC359A605F690D1941E92987CB29
9830|F1B0A52AD5451FE125C3E2F300E6F7EE15ECF1E9F17951F3C2A9ECAEB1C10F56EDB83E8417E6D93DA57B668654FAEA3B523F2A8F199324C1852BB163F55C811B
5030|F4BD4CCB6B4DA9D40B0EFB1941A4A75C10B46AE9C2E5E8C391EBB83260AB3A3A4D81B8114555350C2C99A98377610CC3669BB8E83958D1B617FBFA614A4CDAC8
4D24|BAB3B9875FAB56DFCDDABBDF3BD3841B8F03563F7E28C18405927FF8152529F490B8DCB0713707FC4281AB9C81D3C96A33EED37722BE35AE3605D3C3DD84952D
CBDE|86902FBB79DB4A7F3FCCE14623669F9490B68920B4BB9279CF95798B540FD8BD8A98712C0B3179852E077F1BDF6EBA6EA54586F55B161C8D8F41FFF7010CA10F
41FB|9935E992062A580EB769A22F02C26227CD4591955D31FB8821E820FB0E71B538B221960F4955D55E0C80EC7073FEB373CED191916CA6A056F6F1B11CA3B9C4D4
4FF400|1E2411A6E683F1D705EE3BC548922144A649F6017CF941C0FE45B45F2D94CD03D8A6BBACB268796D591A7E944AFA5127998B3BFD5909CB193AC258931F25B904
FD0440|E8FAFCDDCA0C0E47189B84ADDD113A238A9139FBD741CB9CAA8A04248DE20C12D692D80EDAE783218EB75ED0E707010085B6DAC5A6A085A9987A4DD3ED73DFB8
424D00|03B7E52D39CC15F967C6B89B3114960825BFEAC21E1CC5EC6E860498BDB1297696EEFB056AB1F2805FAFC52387FEEABA39287DA0665B1D9C9A02F3D3EB03336E
3FDEE0|DFE967755BA194F9A099E8B3C925E9570A4382BE4C33550BD5924EC20AD3E23FBD20BD5FE5F4502F8998E62FE8D5D7E03302CAEF43D5A92A6D1D32FE05B4F403
335768|C88BEAC17C21ED8D1D2054AD21A0C2BC17566A3F7F9810C5899152058F5F6DA39C8851957A9FE51F88A14CEDFF650AD628A7B4581B0B07DF4A1678816C621DA1
051E7C|E239FEAFCCA94F8E8A83B732724432923CCECE868A92EBAD0AD9BFD6D4CB73A5E03A8434D5DBF2742B1001D89AF79AE03A42F32B7AF023FC357CC807F17F8FFC
717F8C|21A2FDCCDE02FB412F2F8AF5A16010D6E870FE0A0B7687CEBCC1DD902CCFFEE97F7D272BC9D5D791E8E2255296C77B4D0A72EDBE4B96CA2BCB4C3B1022214403
1F877C|A629E863F410EF2ED2B261CCEEF0F89177E37E27B6306DBC5167BFE7207444A7BF74EAA7673A54BAD55C66AE1B229FCF5BE4C2CF6D3DBF27DE42BD4B6F3F2D0A
EB35CF80|B408E2E8715C7E85EA3D0643D5CE216533E77DD4EE7EB1B7F6176AE2F5AD13FC047A4721BC8C124F30CA69EFE8104A588DE592E6D1374D50E21CDD7210B26EAD
B406C480|A60140852DF6DC2FA06AE32CD3A0F5B8E4840CA53861135534B5F331D1720A4F00557D079789F5ED797CD37982D8F64258C76B12F79CF08E8DEEDA2DF0DA4C42
CEE88040|D77191395A681C60E2E96B04E83D6D55ED06ED31149E240F198E63E87C416AC88E7DBE65220493461B58B32A081CFD6C783E1056AD4E208A772703A308B34787
C584DB70|26BD9636373E84233DB1C6E494CC83EA4C39560CEEF587694FE2AAC4F77C3749B6EEC60B62C491F4C939B4437D898F8178D1BD746125249A5818A35A6715A82D
53587BC8|AABAF8CE64C2FBA19381628BB035FBEFA3820AB4BF4C4D2E2C76863CFA2E666C15824B940867BE357C9A9B117396EB090E490723910AEA6FA39EEC2F597B1F4D
69A305B0|617DBB76E24DE1186FA6C10C2CC20DF1AAEC983CC845ECE8C87C54A249FAB7019346F24BA1D031593A0D0F5411A547A858680A2EE2BE65CCF4F07EF0AA1C67CB
C9375ECE|F85C7F854287DB3A8F49ECED881B84B9356B0A36346ACD5C5C8529E5B8516DEA52B65B79E50F835CBF43D018554AC75AEDE7E930295F9098DA6602D684BC7908
C1ECFDFC|59370518CAE8ECE479A7C82D386582B061BB8D90D47FC26DD3F54C7F2ECD7E695C8F74A25EB27EC82E9B715FEAB09FAC14A8FD9C327340B26CB7C09C240AFA0A
8D73E8A280|63CECD6C0EDA482E91950DE8EF46E35B13F3D357E68526A5E0459D38A4932132F5531C073A22F7B67360BC1E7AA0B25664E4D9EAE46B1279CE5D777AEF58D6C7
06F2522080|CD19BE7665C463D83A3E9DE7EB3CCE2D25452144BBFAE35C7CF553225B0F5F84D6FA3E624D3BF0BC29FA143161ED1FBA0AED8A6DE219B7062BE607FCE179F5DD
3EF6C36F20|95F68D5D4F4F2C694D4448DA0C303099EC27AB9E6F4002AB351D53ED47D7A0EE3339A3F81D611ECE0E8E903C27515C78E161073B870008E35793DC723FC079E3
0127A1D340|899123B71E928949E7394569139A33AC4BD6C4C18479A69EA80715A6813F963DE713AF67F760E5AE7BB8D35C20AFA32A758A4F85D3692126909167605FAB6B84
6A6AB6C210|DE55E9C6B1113EE0806EFD9B7FDF912603D07DFB1C33B40E02F87EED01B657F6967AC784BFFD9B51CFC3EDDE2B1B2ABE39CC60F9AE879C1ABC7DD64ACFD8849D
AF3175E160|EA0FFEDAEE8390B1B2EA6CBBC908F37698934C68332FE2331A8D5B0A55550C734AE31D1E52767AE823EED4A875C041C3E8704663D800D6A9B299EC92BF63A252
B66609ED86|8DD1A9546B414FE846A528E34C98A73564CFD24EE1DA3F9BCBEAFF9BE748B129B5351839EC930C566AB9B9AA684433F3CFE8AFEDA08CA4EB11C5D47E64FD3F29
21F134AC57|120964B67652E531E931DDC48A571DF878B50DB9316244F2008871DAA8E0D5030D3BC2F127E8BDE30A07FD2BC3F529352E189C0A7FD72D90F62AEF22984F5911
3DC2AADFFC80|29F22A5573D00FA919F6C400F7BEE91C8132EB16E61923FD8680C5ED28FAC56735FA4772AF03469AED431D6AAAD5A5C508D74BE4DAE0FC871DBDFF739AB65C97
9202736D2240|D0A9F48B9692CF1E96E81604037FD718C47BB7036604DE8B4F888CFEA8A898B219DE4A488387DD37B3FAECEE76B174BC19E8E03B35D468C5009CF698144749B6
F219BD629820|3A4878C6E76BC743EB524E5C588A1AA8DAD1C53DD7123CC806D54C5A74B38F022EDC953F0D58F516940DD9209266621EC087CFE6B430AF093E2E80EE067715D2
F3511EE2C4B0|A53B172D631D53321815516BAF242D58A06D3BCB43B5029AC61CDC8AC78120940E23AA4A61401A43CE44F4057BB3862DBEC0002B6187D50B0E864469C8FF0FC2
3ECAB6BF7720|27B158CA82C1CFD885B6B087FD18BB3B12D2CFF2F505C1A85AE18E3299DBFDDA69FC10F36E4F0ED32AA5E21A3F0EAF1EF0BDC4661774F6184F3F8589175A7B7B
CD62F688F498|BA8CEDD7A06CD6FA9D2EF369BF27A893CF76C2760D660644C213BF86F1AFBABCA7C8D50B02E1DA4C09DD466530AA9A8035E46C49AFE2DA2F0AC9FE26DADB838F
C2CBAA33A9F8|F91BB48245AEDD67D36F18F910B045802A1BD541E769A449531DB246C07027D5EF10E74877CB38EDF92FBC8C9CDB94C3148307362849093635210616BFBE73F8
C6F50BB74E29|2F183CA1063881187018C7EA8BD84A766E376BD79B88D21B2913A7723D4CEA065B7EDFCD64EF966AB28F1F754400A5E8D563708B2A0A51D3B43679F85C6190DD
79F1B4CCC62A00|C579BE93B0C85FA75EC9A1EB889B6CADA7D96B92EE957A54B3051E872C18536C71B11E24524638B97697CD59F5DC93EF7C2950FF44470A99B9B5124853E2524D