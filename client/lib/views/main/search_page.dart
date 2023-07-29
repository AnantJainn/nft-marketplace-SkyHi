import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:client/views/main/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => DiscoverPageState();
}

class DiscoverPageState extends State<DiscoverPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng indiaLocation = LatLng(28.691293, 77.316701);
  final List<LatLng> _markerPositions = [
    LatLng(23.173622, 77.505211),
    LatLng(23.173622, 77.505661),
    LatLng(23.173212, 77.505211),
    LatLng(23.173622, 77.504761),
    LatLng(23.174042, 77.505621),
    LatLng(23.173202, 77.504801),
    LatLng(23.173202, 77.505621),
    LatLng(23.174042, 77.504801),
    LatLng(23.173812, 77.505461),
    LatLng(23.173432, 77.504961),
    LatLng(43.383537, -79.811247),
    LatLng(43.383921, -79.811629),
    LatLng(43.383054, -79.810746),
    LatLng(43.383279, -79.810916),
    LatLng(43.383625, -79.810443),
    LatLng(43.382982, -79.811449),
    LatLng(43.383393, -79.810157),
    LatLng(43.383815, -79.810909),
    LatLng(43.382830, -79.811747),
    LatLng(43.383134, -79.810440),
    LatLng(33.423046, -111.932390),
    LatLng(33.422927, -111.932503),
    LatLng(33.423070, -111.932569),
    LatLng(33.422968, -111.932372),
    LatLng(33.422992, -111.932307),
    LatLng(22.754620, 75.879555),
    LatLng(22.754430, 75.879698),
    LatLng(22.754789, 75.879351),
    LatLng(22.754264, 75.879876),
    LatLng(22.754578, 75.879192),
    LatLng(13.032345, 77.624512),
    LatLng(13.032735, 77.624952),
    LatLng(13.031913, 77.624175),
    LatLng(13.032158, 77.625045),
    LatLng(13.031780, 77.624458),
    LatLng(13.032485, 77.624225),
    LatLng(13.032972, 77.624682),
    LatLng(13.032607, 77.624995),
    LatLng(13.032271, 77.624757),
    LatLng(13.032647, 77.624372),
    LatLng(23.234567, 77.432109),
    LatLng(23.234987, 77.432531),
    LatLng(23.234321, 77.432765),
    LatLng(23.234876, 77.431987),
    LatLng(23.234678, 77.432876),
    LatLng(37.774300, -122.419400),
    LatLng(37.774600, -122.419100),
    LatLng(37.774200, -122.419800),
    LatLng(37.774900, -122.419200),
    LatLng(37.774400, -122.419500)
  ];

  final List<String> _markerImages = [
    'https://bafybeiesqheapcmqfx3sbtbrqzyii5drcexcq4jxfwn7s463f5zmph526y.gateway.ipfscdn.io/cs1048486361028912.png',
    'https://bafybeiax3gmepodufpxbtmzmnzs7wmscemafnisnkxpc6bbi6olbpmnmf4.gateway.ipfscdn.io/cs1125646615313076.png',
    'https://bafybeigxl7ikwmmemtrxb5kqxfe5sort5xmbcajleyioe2takvjoces33q.gateway.ipfscdn.io/cs10188651804540743.png',
    'https://bafybeigqtnuh3hbiaqk3enoejntww34skdpf62773nxgf25g4xjv5od3xm.gateway.ipfscdn.io/cs10445905019035139.png',
    'https://bafybeic2jxtx7vypillsro6hzqkgwgr6nft53wokcf6jg2ity3gbzaj7iy.gateway.ipfscdn.io/cs10562124521050923.png',
    'https://bafybeifhms2idpo3dainmlb5lcpfv47zeyqmny6a7q75adzw3gj2u7ouvy.gateway.ipfscdn.io/cs10712649413789781.png',
    'https://bafybeihvw577qzmaheo5btuejkxiffsspeaydx5kkud7pxc7fj5bhgjwie.gateway.ipfscdn.io/cs10823521825795415.png',
    'https://bafybeiezefqu53kihvteispw2puy6jvnlsyak7lbnxzpfrpslebxlw4h24.gateway.ipfscdn.io/cs11010345522393046.png',
    'https://bafybeibolkeltpbjq7m2rbjkuksxbnvdlunh36lnq7yvutncw7bi6244oi.gateway.ipfscdn.io/cs11096764340505821.png',
    'https://bafybeiebjsoqfz2m4rpptca6al52wjcoqsvxgedpxmo7lhfzobhxv33av4.gateway.ipfscdn.io/cs11365107979606767.png',
    'https://bafybeib32fgwc2naqxxkzol3w5eb3bxuhzshmheam4hqncuxlbhamopfui.gateway.ipfscdn.io/cs100214067654451312.png',
    'https://bafybeihtuilj3ljv75lo5r6n34aiiqtkli5nynd5jpemcjc7on2dxtpe5e.gateway.ipfscdn.io/cs100279640926771550.png',
    'https://bafybeifbdimbt7ayicqukpsutg7j2nh4ze4aod2ltji5ydkq7bh75kkqae.gateway.ipfscdn.io/cs100367196602765414.png',
    'https://bafybeihpg5o75cr3x5pw6eelklplzoiypx6bn4guunzqdzzolwp5yl4swu.gateway.ipfscdn.io/cs100630750052269087.png',
    'https://bafybeid5dzr4kmvu7g6p6uzpdv57svqaszkq4blpe25x3lkve5n22tlwru.gateway.ipfscdn.io/cs101172805621739638.png',
    'https://bafybeid6cls37kqjd4dkvjlfz2mou64tv5v5sfzwc5zifgkj7q6nfcqq6q.gateway.ipfscdn.io/cs101724504648038815.png',
    'https://bafybeibwjhpeurioigpjmkmseunyudzgkucf5rigdllv4pr2ap6qsgaiay.gateway.ipfscdn.io/cs101767157496046490.png',
    'https://bafybeienfseap2jbcheeu3ysmdozyjft6twygba2ccez5fviv3xj6w3hei.gateway.ipfscdn.io/cs101957715605808227.png',
    'https://bafybeidavdkhc47k7v55ztnvaqf6eypvlkzokpru6yg3gvh6c4uncwcj4u.gateway.ipfscdn.io/cs102400950696764945.png',
    'https://bafybeifrswmqi7xzqq6f3kyys2tcx4uxrnokhdv6pwkykegywfz33mq6fe.gateway.ipfscdn.io/cs102422236815498498.png',
    'https://bafybeiahfb22nvmhkwh6mcjqfibuhtj6x6fmq3trv66r5snuvfoioqbbea.gateway.ipfscdn.io/cs102861240281778234.png',
    'https://bafybeiefufmzfrftukpbpcloyqccajlnx6zopsp3m5ctlgu2p2rhduynbm.gateway.ipfscdn.io/cs102996970073821635.png',
    'https://bafybeifckjczbv4wudxenxuci7cn4zpdlkhdowrbnvgwgeyloffio5sk6i.gateway.ipfscdn.io/cs103078152548071803.png',
    'https://bafybeiapexjlt4bkilyd7evsofcnr6kn66m7hd3f6hbt23tvnwsiohk454.gateway.ipfscdn.io/cs103423283580625484.png',
    'https://bafybeifo2ijiwxybslg7irv3c7wk4zaqlvgyoh2yun2hudozzuyw6sdbwe.gateway.ipfscdn.io/cs103587423973880298.png',
    'https://bafybeidnmzqgu4oibxcfe7fff4s6vrzqcmursn3qmt3jcniduwu4ny6oyi.gateway.ipfscdn.io/cs103659213402785408.png',
    'https://bafybeibty5jx3cxvalfacttldkreqlhehhw7f5om7gqrij37rbibpefhcq.gateway.ipfscdn.io/cs103663933281312281.png',
    'https://bafybeigwhosyylujujrbc663shtc3vbjenwtyhgbbhqamat7h4okweuvne.gateway.ipfscdn.io/cs103822919467497853.png',
    'https://bafybeieq4oui7n7jmm2adi6is6njh6jrwhc74fs4kl2ozuwcyvn43xlinq.gateway.ipfscdn.io/cs104924347815727490.png',
    'https://bafybeiaswlygko2sllmvepjmfukbad4vtedgoykn3zgug6wrokvsldnvey.gateway.ipfscdn.io/cs104968955657654599.png',
    'https://bafybeic3l6boe73272fzxuf6x3kfdnpiwnvoxwj74wnl6jlv23az3i5h6u.gateway.ipfscdn.io/cs104983947614280485.png',
    'https://bafybeibddpzzaxkcftcqc2pgeii74qk2qkzldad5joe6kki4re7cnji3ia.gateway.ipfscdn.io/cs105013173991731446.png',
    'https://bafybeidtrcc7jwq6le3jdtw3udqetebn2zrqaqgqzmrvwsj2wduex724tm.gateway.ipfscdn.io/cs105105240413858862.png',
    'https://bafybeibmjdmrwhhsocq3i4di66uggbvo76ekxflzmzj2gn4lf53el4omwu.gateway.ipfscdn.io/cs105149584509303839.png',
    'https://bafybeib3outvbo25gh2xzh3twmi2xvyq5eyd4vk7ssohm3of2rx5apikhi.gateway.ipfscdn.io/cs105316240118440367.png',
    'https://bafybeianbgjoljbnjitnjuoiwqiym4us2otqqafc4ffxnn2djmikrwbyvi.gateway.ipfscdn.io/cs105479796479016880.png',
    'https://bafybeiewpg6ncfygqadcjulgdeqbjos2dmiewpu3vz2s7ovnmimaaeklvm.gateway.ipfscdn.io/cs106140924474526814.png',
    'https://bafybeibefie7xb6bgbxsf2brvd6iui555ocrtbfe3ndqmdm5hu5dfknkpq.gateway.ipfscdn.io/cs107311176389079257.png',
    'https://bafybeifrdcoob4snf7lb2hb4grwgt5g3hcvrge425ip46rwcy7mnkgigg4.gateway.ipfscdn.io/cs108611842236428884.png',
    'https://bafybeihhdiufkbreg4sls2tflo55kbn6agmstgf5376pbb564beok7acrm.gateway.ipfscdn.io/cs108714949713610007.png',
    'https://bafybeib4sfvj6r5yvufyogdv7m4hg6bfgrajcysmesgqpzhzji7kel6wzi.gateway.ipfscdn.io/cs109057168874288515.png',
    'https://bafybeia2enwwqkjczbr6ptx5cxzp4ktasvochcfvml3ya23zwtqbrqvoqa.gateway.ipfscdn.io/cs109230125219233296.png',
    'https://bafybeiavn4albzxyrpbxhpzxwcnfn7nis6yvzvn635pahkgk3uqrt7d7qy.gateway.ipfscdn.io/cs109328847176380298.png',
    'https://bafybeig6u46imxhk4fyoetqn3act2z7gls3ln6pqvr34gu674ldg6j6f4a.gateway.ipfscdn.io/cs110023709536839282.png',
    'https://bafybeifjcg2zcdxi5nqo2bior6ipxpg6rggnqobzmhy6ma6tqelm44pdai.gateway.ipfscdn.io/cs110563931557499787.png',
    'https://bafybeics6iwyr63vozuc3kulle5pthvamcos6f7cpsmk63kihfygc7ijte.gateway.ipfscdn.io/cs110790626714649728.png',
    'https://bafybeiaxllssw4btyiftutzi5hnuwv4knvw72tlptvgwvpkgj5lked6afa.gateway.ipfscdn.io/cs110848211297309264.png',
    'https://bafybeifntegggc7ljv7yqm5lh7mpjjshas45rn3wowsmndfpr2ukthiutu.gateway.ipfscdn.io/cs110895378980355805.png',
    'https://bafybeiduwtkoukif32u5xyqqghbqd7mlmtxwe3znriwqc7b45bazsyhtua.gateway.ipfscdn.io/cs111730397949486489.png',
    'https://bafybeibpmwezzrc3l6tmomscepc4hjy2722sfl4z7v2o4vm4tkbspno7vy.gateway.ipfscdn.io/cs112531926704693505.png',


  ];
  List<Marker> _markers = [];
  late Position _currentPosition;
  bool _isInRange = false;
  List<String> _purchasedImages = [];
  // Add a list of URLs for each image
  final List<String> _markerUrls = [
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/0#5feceb66ffc86f38d952786c6d696c79c2dbc239dd4e91b46729d73a27fb57e9',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/1#6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/2#d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/3#4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/4#4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/5#ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/6#e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/7#7902699be42c8a8e46fbbb4501726517e86b22c56a189f7625a6da49081b2451',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/8#2c624232cdd221771294dfbb310aca000a0df6ac8b66b696d90ef06fdefb64a3',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/9#19581e27de7ced00ff1ce50b2047e7a567c76b1cbaebabe5ef03f7c3017bb5b7',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/10#4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/11#4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/12#6b51d431df5d7f141cbececcf79edf3dd861c3b4069f0b11661a3eefacbba918',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/13#3fdba35f04dc8c462986c992bcf875546257113072a909c162f7e470e581e278',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/14#8527a891e224136950ff32ca212b45bc93f69fbb801c3b1ebedac52775f99e61',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/15#e629fa6598d732768f7c726b4b621285f9c3b85303900aa912017db7617d8bdb',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/16#b17ef6d19c7a5b1ee83b907c595526dcb1eb06db8227d650d5dda0a9f4ce8cd9',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/17#4523540f1504cd17100c4835e85b7eefd49911580f8efff0599a8f283be6b9e3',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/18#4ec9599fc203d176a301536c2e091a19bc852759b255bd6818810a42c5fed14a',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/19#9400f1b21cb527d7fa3d3eabba93557a18ebe7a2ca4e471cfe5e4c5b4ca7f767',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/20#f5ca38f748a1d6eaf726b8a42fb575c3c71f1864a8143301782de13da2d9202b',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/21#6f4b6612125fb3a0daecd2799dfd6c9c299424fd920f9b308110a2c1fbd8f443',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/22#785f3ec7eb32f30b90cd0fcf3657d388b5ff4297f2f9716ff66e9b69c05ddd09',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/23#535fa30d7e25dd8a49f1536779734ec8286108d115da5045d77f3b4185d8f790',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/24#c2356069e9d1e79ca924378153cfbbfb4d4416b1f99d41a2940bfdb66c5319db',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/25#b7a56873cd771f2c446d369b649430b65a756ba278ff97ec81bb6f55b2e73569',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/26#5f9c4ab08cac7457e9111a30e4664920607ea2c115a1433d7be98e97e64244ca',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/27#670671cd97404156226e507973f2ab8330d3022ca96e0c93bdbdb320c41adcaf',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/28#59e19706d51d39f66711c2653cd7eb1291c94d9b55eb14bda74ce4dc636d015a',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/29#35135aaa6cc23891b40cb3f378c53a17a1127210ce60e125ccf03efcfdaec458',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/30#624b60c58c9d8bfb6ff1886c2fd605d2adeb6ea4da576068201b6c6958ce93f4',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/31#eb1e33e8a81b697b75855af6bfcdbcbf7cbbde9f94962ceaec1ed8af21f5a50f',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/32#e29c9c180c6279b0b02abd6a1801c7c04082cf486ec027aa13515e4f3884bb6b',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/33#c6f3ac57944a531490cd39902d0f777715fd005efac9a30622d5f5205e7f6894',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/34#86e50149658661312a9e0b35558d84f6c6d3da797f552a9657fe0558ca40cdef',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/35#9f14025af0065b30e47e23ebb3b491d39ae8ed17d33739e5ff3827ffb3634953',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/36#76a50887d8f1c2e9301755428990ad81479ee21c25b43215cf524541e0503269',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/37#7a61b53701befdae0eeeffaecc73f14e20b537bb0f8b91ad7c2936dc63562b25',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/38#aea92132c4cbeb263e6ac2bf6c183b5d81737f179f21efdc5863739672f0f470',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/39#0b918943df0962bc7a1824c0555a389347b4febdc7cf9d1254406d80ce44e3f9',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/40#d59eced1ded07f84c145592f65bdf854358e009c5cd705f5215bf18697fed103',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/41#3d914f9348c9cc0ff8a79716700b9fcd4d2f3e711608004eb8f138bcba7f14d9',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/42#73475cb40a568e8da8a045ced110137e159f890ac4da883b6b17dc651b3a8049',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/43#44cb730c420480a0477b505ae68af508fb90f96cf0ec54c6ad16949dd427f13a',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/44#71ee45a3c0db9a9865f7313dd3372cf60dca6479d46261f3542eb9346e4a04d6',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/45#811786ad1ae74adfdd20dd0372abaaebc6246e343aebd01da0bfc4c02bf0106c',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/47#31489056e0916d59fe3add79e63f095af3ffb81604691f21cad442a85c7be617',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/48#98010bd9270f9b100b6214a21754fd33bdc8d41b2bc9f9dd16ff54d3c34ffd71',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/49#0e17daca5f3e175f448bacace3bc0da47d0655a74c8dd0dc497a3afbdad95f1f',
    'https://skyhi-web.vercel.app/token/0xCD53E3d52E6F257a7ea277926C03eC12508F0477/50#1a6562590ef19d1045d06c4055742d38288e9e6dcd71ccde5cee80f1d5a774eb',
  ];
//     'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/4#4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a',

  @override
  void initState() {
    super.initState();
    // _calculateMarkerPositions();
    _initMarkers();
    _getCurrentLocation();
  }

  Future<void> _initMarkers() async {
    for (int i = 0; i < _markerPositions.length; i++) {
      final Uint8List markerIcon = await _getBytesFromUrl(_markerImages[i]);
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('marker$i'),
            position: _markerPositions[i],
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(
              title: 'Image $i',
              snippet: 'Click here to enlarge',
              onTap: () => _onInfoWindowTap(i),
            ),
          ),
        );
      });
    }
  }

  Future<Uint8List> _getBytesFromUrl(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      final Uint8List bytes = response.bodyBytes;
      final ui.Codec codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: 375, // Half the original width
      );
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image resizedImage = frameInfo.image;
      final ByteData? data =
          await resizedImage.toByteData(format: ui.ImageByteFormat.png);
      return data!.buffer.asUint8List();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void _removeMarker(int index) {
    setState(() {
      _markers.removeAt(index);
    });
  }

  bool _checkRange() {
    for (LatLng position in _markerPositions) {
      double distance = Geolocator.distanceBetween(
        _currentPosition.latitude,
        _currentPosition.longitude,
        position.latitude,
        position.longitude,
      );

      if (distance <= 25) {
        return true;
      }
    }
    return false;
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      debugPrint("Permission not granted");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    setState(() {
      _currentPosition = position;
      _isInRange = _checkRange();
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
    );
  }

  // void _calculateMarkerPositions() {
  //   double latOffset = markerDistance;
  //   double lngOffset = markerDistance;

  //   for (int i = 1; i < _markerPositions.length; i++) {
  //     _markerPositions[i] = LatLng(
  //       _markerPositions[i - 1].latitude + latOffset,
  //       _markerPositions[i - 1].longitude + lngOffset,
  //     );
  //     latOffset += markerDistance;
  //     lngOffset += markerDistance;
  //   }
  // }

  void _onInfoWindowTap(int index) {
    if (_isInRange) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enlarge Image'),
            content: Image.network(
              _markerImages[index],
              errorBuilder: (context, error, stackTrace) {
                return const Text('Image not found');
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle purchasing logic here
                  setState(() {
                    _purchasedImages.add(_markerImages[index]);
                  });
                  _launchURL(_markerUrls[index]);
                },
                child: const Text('Buy'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Out of Range'),
            content: const Text('You are not in range to purchase this image.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _launchURL(String url) async {
    if (await launchUrl((Uri.parse(url)))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SkyHi',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: indiaLocation,
              zoom: 14.0,
            ),
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String imageUrl;

  const ProfilePage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          errorBuilder: (context, error, stackTrace) {
            return const Text('Image not found');
          },
        ),
      ),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:client/views/main/profile_page.dart';
// import 'package:url_launcher/url_launcher.dart';

// class DiscoverPage extends StatefulWidget {
//   const DiscoverPage({Key? key}) : super(key: key);

//   @override
//   State<DiscoverPage> createState() => DiscoverPageState();
// }

// class DiscoverPageState extends State<DiscoverPage> {
//   final Completer<GoogleMapController> _controller = Completer();
//   static const LatLng indiaLocation = LatLng(28.691293, 77.316701);
//   final double markerDistance = 0.000180; // Approximately 20 meters
//   final List<LatLng> _markerPositions = [
//     LatLng(28.6813123, 77.3135387), // Image 0 coordinates
//     LatLng(28.6813125, 77.3135887), // Image 1 coordinates
//     LatLng(28.6813127, 77.3135887), // Image 2 coordinates
//     LatLng(28.6813129, 77.3135887), // Image 3 coordinates
//     LatLng(28.6813131, 77.3135887), // Image 4 coordinates
//   ];

//   final List<String> _markerImages = [
//     'https://ipfs-public.thirdwebcdn.com/ipfs/QmcXu931njCstLjEWQUNmoqGbZuTddPXkjHg4U35K8VPxu/100%20x%20100.png',
//     'https://ipfs-public.thirdwebcdn.com/ipfs/QmVNVgo3hu6r7uu9Tt8rFUctGeaJsLAuq1qo5NEHX9ZwC1/Frame%2034153.png',
//     'https://ipfs-public.thirdwebcdn.com/ipfs/QmZkkbBMLD8dEBr94JxGU4tpxQ5CSSdQw43PKJJSWsbC8y/Frame%2034155.png',
//     'https://ipfs-public.thirdwebcdn.com/ipfs/QmQP6VCW16hfBQ28FVbB68gXiddvn7h4uTWPdZUsqGAoMx/Frame%2034157.png',
//     'https://ipfs-public.thirdwebcdn.com/ipfs/QmeJ6ytFgue8nvpXr8KJYZ6AkvKTtACaQ7FHMeTsrN6RRt/Frame%2034159.png',
//   ];
//   List<Marker> _markers = [];
//   late Position _currentPosition;
//   bool _isInRange = false;
//   List<String> _purchasedImages = [];
//   // Add a list of URLs for each image
//   final List<String> _markerUrls = [
//     'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/0#5feceb66ffc86f38d952786c6d696c79c2dbc239dd4e91b46729d73a27fb57e9',
//     'https://sky-hi-nft-marketplace-pyj9.verconst app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/1#6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b',
//     'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/2#d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35',
//     'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/3#4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce',
//     'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/4#4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a',
//   ];
//   //     'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/4#4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a',

//   @override
//   void initState() {
//     super.initState();
//     _calculateMarkerPositions();
//     _initMarkers();
//     _getCurrentLocation();
//   }

//   Future<void> _initMarkers() async {
//     for (int i = 0; i < _markerPositions.length; i++) {
//       final Uint8List markerIcon = await _getBytesFromUrl(_markerImages[i]);
//       setState(() {
//         _markers.add(
//           Marker(
//             markerId: MarkerId('marker$i'),
//             position: _markerPositions[i],
//             icon: BitmapDescriptor.fromBytes(markerIcon),
//             infoWindow: InfoWindow(
//               title: 'Image $i',
//               snippet: 'Click here to enlarge',
//               onTap: () => _onInfoWindowTap(i),
//             ),
//           ),
//         );
//       });
//     }
//   }

//   Future<Uint8List> _getBytesFromUrl(String url) async {
//     try {
//       http.Response response = await http.get(Uri.parse(url));
//       final Uint8List bytes = response.bodyBytes;
//       final ui.Codec codec = await ui.instantiateImageCodec(
//         bytes,
//         targetWidth: 375, // Half the original width
//       );
//       final ui.FrameInfo frameInfo = await codec.getNextFrame();
//       final ui.Image resizedImage = frameInfo.image;
//       final ByteData? data =
//           await resizedImage.toByteData(format: ui.ImageByteFormat.png);
//       return data!.buffer.asUint8List();
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   void _removeMarker(int index) {
//     setState(() {
//       _markers.removeAt(index);
//     });
//   }

//   bool _checkRange() {
//     for (LatLng position in _markerPositions) {
//       double distance = Geolocator.distanceBetween(
//         _currentPosition.latitude,
//         _currentPosition.longitude,
//         position.latitude,
//         position.longitude,
//       );

//       if (distance <= 25) {
//         return true;
//       }
//     }
//     return false;
//   }

//   Future<void> _getCurrentLocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       debugPrint("Permission not granted");
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best,
//     );

//     setState(() {
//       _currentPosition = position;
//       _isInRange = _checkRange();
//     });

//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(
//       CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
//     );
//   }

//   // void _calculateMarkerPositions() {
//   //   double latOffset = markerDistance;
//   //   double lngOffset = markerDistance;

//   //   for (int i = 1; i < _markerPositions.length; i++) {
//   //     _markerPositions[i] = LatLng(
//   //       _markerPositions[i - 1].latitude + latOffset,
//   //       _markerPositions[i - 1].longitude + lngOffset,
//   //     );
//   //     latOffset += markerDistance;
//   //     lngOffset += markerDistance;
//   //   }
//   // }

//   void _calculateMarkerPositions() {
//     double latOffset = 10.0; // Latitude offset for spreading markers
//     double lngOffset = 10.0; // Longitude offset for spreading markers

//     for (int i = 0; i < _markerPositions.length; i++) {
//       _markerPositions[i] = LatLng(
//         indiaLocation.latitude + (i * latOffset),
//         indiaLocation.longitude + (i * lngOffset),
//       );
//     }
//   }

//   void _onInfoWindowTap(int index) {
//     if (_isInRange) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Enlarge Image'),
//             content: Image.network(
//               _markerImages[index],
//               errorBuilder: (context, error, stackTrace) {
//                 return const Text('Image not found');
//               },
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Close'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   // Handle purchasing logic here
//                   setState(() {
//                     _purchasedImages.add(_markerImages[index]);
//                   });
//                   _launchURL(_markerUrls[index]);
//                 },
//                 child: const Text('Buy'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   Future<void> _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Discover'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             mapType: MapType.normal,
//             initialCameraPosition: CameraPosition(
//               target: indiaLocation,
//               zoom: 14,
//             ),
//             markers: Set<Marker>.of(_markers),
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//           ),
//           Positioned(
//             bottom: 16,
//             left: 16,
//             child: ElevatedButton(
//               onPressed: _getCurrentLocation,
//               child: const Text('Current Location'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:client/views/main/profile_page.dart';
// import 'package:url_launcher/url_launcher.dart';

// class DiscoverPage extends StatefulWidget {
//   const DiscoverPage({Key? key}) : super(key: key);

//   @override
//   State<DiscoverPage> createState() => DiscoverPageState();
// }

// class DiscoverPageState extends State<DiscoverPage> {
//   final Completer<GoogleMapController> _controller = Completer();
//   static const LatLng indiaLocation = LatLng(28.691293, 77.316701);
//   final List<LatLng> _markerPositions = [
//     LatLng(28.6113123, 77.3136387), // Image 0 coordinates
//     LatLng(28.6813125, 77.3135887), // Image 1 coordinates
//     LatLng(28.6883127, 77.3139887), // Image 2 coordinates
//     LatLng(28.6861269, 77.3135387), // Image 3 coordinates
//     LatLng(28.6813181, 77.3115887), // Image 4 coordinates
//   ];

//   final List<String> _markerImages = [
//     'https://ipfs-public.thirdwebcdn.com/ipfs/QmcXu931njCstLjEWQUNmoqGbZuTddPXkjHg4U35K8VPxu/100%20x%20100.png',
//     'https://ipfs-public.thirdwebcdn.com/ipfs/QmVNVgo3hu6r7uu9Tt8rFUctGeaJsLAuq1qo5NEHX9ZwC1/Frame%2034153.png',
//     'https://ipfs-public.thirdwebcdn.com/ipfs/QmZkkbBMLD8dEBr94JxGU4tpxQ5CSSdQw43PKJJSWsbC8y/Frame%2034155.png',
//     'https://ipfs-public.thirdwebcdn.com/ipfs/QmQP6VCW16hfBQ28FVbB68gXiddvn7h4uTWPdZUsqGAoMx/Frame%2034157.png',
//     'https://ipfs-public.thirdwebcdn.com/ipfs/QmeJ6ytFgue8nvpXr8KJYZ6AkvKTtACaQ7FHMeTsrN6RRt/Frame%2034159.png',
//   ];
//   List<Marker> _markers = [];
//   late Position _currentPosition;
//   bool _isInRange = false;
//   List<String> _purchasedImages = [];
//   // Add a list of URLs for each image
//   final List<String> _markerUrls = [
//     'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/0#5feceb66ffc86f38d952786c6d696c79c2dbc239dd4e91b46729d73a27fb57e9',
//     'https://sky-hi-nft-marketplace-pyj9.verconst app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/1#6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b',
//     'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/2#d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35',
//     'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/3#4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce',
//     'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/4#4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _initMarkers();
//     _getCurrentLocation();
//   }

//   Future<void> _initMarkers() async {
//     for (int i = 0; i < _markerPositions.length; i++) {
//       final Uint8List markerIcon = await _getBytesFromUrl(_markerImages[i]);
//       setState(() {
//         _markers.add(
//           Marker(
//             markerId: MarkerId('marker$i'),
//             position: _markerPositions[i],
//             icon: BitmapDescriptor.fromBytes(markerIcon),
//             infoWindow: InfoWindow(
//               title: 'Image $i',
//               snippet: 'Click here to enlarge',
//               onTap: () => _onInfoWindowTap(i),
//             ),
//           ),
//         );
//       });
//     }
//   }

//   Future<Uint8List> _getBytesFromUrl(String url) async {
//     try {
//       http.Response response = await http.get(Uri.parse(url));
//       final Uint8List bytes = response.bodyBytes;
//       final ui.Codec codec = await ui.instantiateImageCodec(
//         bytes,
//         targetWidth: 375, // Half the original width
//       );
//       final ui.FrameInfo frameInfo = await codec.getNextFrame();
//       final ui.Image resizedImage = frameInfo.image;
//       final ByteData? data =
//           await resizedImage.toByteData(format: ui.ImageByteFormat.png);
//       return data!.buffer.asUint8List();
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }

//   void _removeMarker(int index) {
//     setState(() {
//       _markers.removeAt(index);
//     });
//   }

//   bool _checkRange() {
//     for (LatLng position in _markerPositions) {
//       double distance = Geolocator.distanceBetween(
//         _currentPosition.latitude,
//         _currentPosition.longitude,
//         position.latitude,
//         position.longitude,
//       );

//       if (distance <= 25) {
//         return true;
//       }
//     }
//     return false;
//   }

//   Future<void> _getCurrentLocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       debugPrint("Permission not granted");
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.best,
//     );

//     setState(() {
//       _currentPosition = position;
//       _isInRange = _checkRange();
//     });

//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(
//       CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
//     );
//   }

//   void _onInfoWindowTap(int index) {
//     if (_isInRange) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Enlarge Image'),
//             content: Image.network(
//               _markerImages[index],
//               errorBuilder: (context, error, stackTrace) {
//                 return const Text('Image not found');
//               },
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Close'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   // Handle purchasing logic here
//                   setState(() {
//                     _purchasedImages.add(_markerImages[index]);
//                   });
//                   _launchURL(_markerUrls[index]);
//                 },
//                 child: const Text('Buy'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   // Future<void> _launchURL(String url) async {
//   //   if (await canLaunch(url)) {
//   //     await launch(url);
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }

//   Future<void> _launchURL(String url) async {
//     if (await launchUrl((Uri.parse(url)))) {
//       await launchUrl(
//         Uri.parse(url),
//         mode: LaunchMode.externalApplication,
//       );
//     } else {
//       print('Could not launch $url');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Discover'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             mapType: MapType.normal,
//             initialCameraPosition: CameraPosition(
//               target: indiaLocation,
//               zoom: 14,
//             ),
//             markers: Set<Marker>.of(_markers),
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//           ),
//           Positioned(
//             bottom: 16,
//             left: 16,
//             child: ElevatedButton(
//               onPressed: _getCurrentLocation,
//               child: const Text('Current Location'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }