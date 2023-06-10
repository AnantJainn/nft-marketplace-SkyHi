import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:client/views/main/profile_page.dart';
import 'package:client/views/main/global.dart';
import 'package:client/controllers/welcome_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => DiscoverPageState();
}

class DiscoverPageState extends State<DiscoverPage> {
  static const String _yourContractAbi = '''[
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "approved",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "Approval",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "operator",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "bool",
				"name": "approved",
				"type": "bool"
			}
		],
		"name": "ApprovalForAll",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "approve",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "recipient",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "tokenURI",
				"type": "string"
			}
		],
		"name": "mintNFT",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "previousOwner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "OwnershipTransferred",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "renounceOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "safeTransferFrom",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			},
			{
				"internalType": "bytes",
				"name": "data",
				"type": "bytes"
			}
		],
		"name": "safeTransferFrom",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "operator",
				"type": "address"
			},
			{
				"internalType": "bool",
				"name": "approved",
				"type": "bool"
			}
		],
		"name": "setApprovalForAll",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "Transfer",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "transferFrom",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "owner",
				"type": "address"
			}
		],
		"name": "balanceOf",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "getApproved",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "owner",
				"type": "address"
			},
			{
				"internalType": "address",
				"name": "operator",
				"type": "address"
			}
		],
		"name": "isApprovedForAll",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "name",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "ownerOf",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes4",
				"name": "interfaceId",
				"type": "bytes4"
			}
		],
		"name": "supportsInterface",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "symbol",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "tokenId",
				"type": "uint256"
			}
		],
		"name": "tokenURI",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
''';
  static const accountAddress = '0x0A2222B3BC8827573322040a6347aF5aB828Cb4F';

  final client = Web3Client(
    'https://eth-goerli.g.alchemy.com/v2/__Qu_EtvGn0g8jtrjsp4RsWiOy0SA-Gq',
    Client(),
    socketConnector: () {
      return IOWebSocketChannel.connect(
              'wss://eth-goerli.g.alchemy.com/v2/__Qu_EtvGn0g8jtrjsp4RsWiOy0SA-Gq')
          .cast<String>();
    },
  );

  String recipientAddress =
      '0x0A2222B3BC8827573322040a6347aF5aB828Cb4F'; // Replace with your recipient address
  String tokenURI =
      'https://gateway.pinata.cloud/ipfs/QmQ2mkZw5c2Cstp4NboT4moaNrCiYFoXF9bB8e43gQiFoN?_gl=1*1n0c8n8*rs_ga*MTM2OTkwMjQ5Ny4xNjg0MTY2NzYx*rs_ga_5RMPXG14TE*MTY4NDE2Njc2MS4xLjEuMTY4NDE2NjgwMC4yMS4wLjA.';

  void _mintNFT(String recipient, String tokenURI) async {
    final contract = DeployedContract(
      ContractAbi.fromJson(jsonEncode(_yourContractAbi), '4_Create-NFT'),
      EthereumAddress.fromHex('0x38d6C22EfdB6213C9a5e03634d665a07369a8c98'),
    );

    final function = contract.function('mintNFT');

    final response = await client.call(
      sender:
          EthereumAddress.fromHex('0x0A2222B3BC8827573322040a6347aF5aB828Cb4F'),
      contract: contract,
      function: function,
      params: [
        '0x0A2222B3BC8827573322040a6347aF5aB828Cb4F',
        'https://gateway.pinata.cloud/ipfs/QmQ2mkZw5c2Cstp4NboT4moaNrCiYFoXF9bB8e43gQiFoN?_gl=1*1n0c8n8*rs_ga*MTM2OTkwMjQ5Ny4xNjg0MTY2NzYx*rs_ga_5RMPXG14TE*MTY4NDE2Njc2MS4xLjEuMTY4NDE2NjgwMC4yMS4wLjA.'
      ],
    );
  }

  //  MapType _currentMapType = MapType.normal;
  String? _darkMapStyle;
  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _initMarkers();
    rootBundle.loadString('assets/dark_map_style.json').then((value) {
      _darkMapStyle = value;
    });
    // Load the saved NFTs when the app starts
    _loadNFTs(WelcomeController.to.account).then((loadedNFTs) {
      setState(() {
        purchasedNFTs = loadedNFTs;
      });
    });
  }

  // Function to toggle map type
  void _changeMapType() {
    setState(() {
      if (_currentMapType == MapType.normal) {
        _currentMapType = MapType.satellite;
      } else if (_currentMapType == MapType.satellite) {
        _currentMapType = MapType.normal;
        _darkMapStyle = _darkMapStyle;
      } else {
        _currentMapType = MapType.normal;
        _darkMapStyle = null;
      }
    });
  }

  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng indiaLocation = LatLng(20.5937, 78.9629);
  final List<LatLng> _markerPositions = [
    const LatLng(20.5937, 78.9629),
    const LatLng(20.5940, 78.9633),
    const LatLng(20.5943, 78.9637),
    const LatLng(20.5947, 78.9641),
    const LatLng(20.5950, 78.9645),
  ];
  final List<String> _markerImages = [
    'https://i.seadn.io/gcs/files/51259dbc6d09766c690331d43dade69a.png?auto=format&dpr=1&w=750',
    'https://i.seadn.io/gcs/files/c72c03727e332d596a2b68b6f57fd53a.png?auto=format&dpr=1&w=750',
    'https://i.seadn.io/gcs/files/722da52c9051ea01bcc5311ada282ee0.png?auto=format&dpr=1&w=750',
    'https://i.seadn.io/gcs/files/27787f6ffdf353097a2e6111e792c91b.png?auto=format&dpr=1&w=750',
    'https://i.seadn.io/gcs/files/e1eef236f71b35d18b5a4d518dec30ef.png?auto=format&dpr=1&w=750',
  ];
  final List<Marker> _markers = [];

  LatLng get sourceLocation => const LatLng(20.5937, 78.9629);

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    if (path.startsWith('http')) {
      try {
        http.Response response = await http.get(Uri.parse(path));
        final Uint8List bytes = response.bodyBytes;
        final ui.Codec codec = await ui.instantiateImageCodec(bytes,
            targetWidth: width * 2); // Double the target width
        final ui.FrameInfo frameInfo = await codec.getNextFrame();
        final ui.Image img = frameInfo.image;
        final ByteData? data =
            await img.toByteData(format: ui.ImageByteFormat.png);
        return data!.buffer.asUint8List();
      } catch (e) {
        debugPrint(e.toString());
        rethrow;
      }
    } else {
      try {
        final ByteData bytes = await rootBundle.load(path);
        final ui.Codec codec = await ui.instantiateImageCodec(
            bytes.buffer.asUint8List(),
            targetWidth: width * 2); // Double the target width
        final ui.FrameInfo frameInfo = await codec.getNextFrame();
        final ui.Image img = frameInfo.image;
        final ByteData? data =
            await img.toByteData(format: ui.ImageByteFormat.png);
        return data!.buffer.asUint8List();
      } catch (e) {
        debugPrint(e.toString());
        rethrow;
      }
    }
  }

  Future<void> _initMarkers() async {
    for (int i = 0; i < _markerPositions.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromAsset(_markerImages[i], 200);
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('marker$i'),
          position: _markerPositions[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: 'Image $i',
            snippet: 'Click here to enlarge',
            onTap: () => _onInfoWindowTap(i),
          ),
        ));
      });
    }
  }

  void _removeMarker(int index) {
    setState(() {
      _markers.removeAt(index);
    });
  }

  // Function to save NFTs
  Future<void> _saveNFTs(String accountAddress, List<String> nftList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(accountAddress, nftList);
  }

  // Function to load NFTs
  Future<List<String>> _loadNFTs(String accountAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(accountAddress) ?? [];
  }

  // void _onInfoWindowTap(int index) async {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height * 0.5,
  //         child: Column(
  //           children: [
  //             Container(
  //               height: MediaQuery.of(context).size.height * 0.4,
  //               width: MediaQuery.of(context).size.width,
  //               child: Image.network(
  //                 _markerImages[index],
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () async {
  //                 // Connect to MetaMask
  //                 await WelcomeController.to.connect();

  //                 // Building and signing a transaction
  //                 // Replace with actual values
  //                 var transaction = Transaction(
  //                   to: EthereumAddress.fromHex(recipientAddress),
  //                   gasPrice: EtherAmount.inWei(BigInt.one),
  //                   maxGas: 21000,
  //                   value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
  //                   data: Uint8List(0),
  //                 );

  //                 bool success = true; // Replace with your transaction status

  //                 if (success) {
  //                   purchasedNFTs.add(_markerImages[index]);
  //                   _removeMarker(index);

  //                   // Navigate to profile page
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => ProfilePage(
  //                         key: const Key("profile_page_key"),
  //                         imageUrl: _markerImages[index],
  //                       ),
  //                     ),
  //                   );
  //                 } else {
  //                   // Handle transaction failure case here
  //                 }
  //               },
  //               child: const Text('Buy it'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _onInfoWindowTap(int index) async {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height * 0.5,
  //         child: Column(
  //           children: [
  //             Container(
  //               height: MediaQuery.of(context).size.height * 0.4,
  //               width: MediaQuery.of(context).size.width,
  //               child: Image.network(
  //                 _markerImages[index],
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () async {
  //                 // Connect to MetaMask
  //                 await WelcomeController.to.connect();

  //                 // Building and signing a transaction
  //                 // Replace with actual values
  //                 var transaction = Transaction(
  //                   to: EthereumAddress.fromHex(recipientAddress),
  //                   gasPrice: EtherAmount.inWei(BigInt.one),
  //                   maxGas: 21000,
  //                   value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
  //                   data: Uint8List(0),
  //                 );

  //                 bool success = true; // Replace with your transaction status

  //                 if (success) {
  //                   purchasedNFTs.add(_markerImages[index]);
  //                   _removeMarker(index);

  //                   // Save the updated list of NFTs
  //                   _saveNFTs(WelcomeController.to.account, purchasedNFTs);

  //                   // Navigate to profile page
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => ProfilePage(
  //                         key: const Key("profile_page_key"),
  //                         imageUrl: _markerImages[index],
  //                       ),
  //                     ),
  //                   );
  //                 } else {
  //                   // Handle transaction failure case here
  //                 }
  //               },
  //               child: const Text('Buy it'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // // MapType _currentMapType = MapType.normal;
  // ThemeMode _currentThemeMode = ThemeMode.light;

  // void _toggleThemeMode() {
  //   setState(() {
  //     _currentThemeMode = _currentThemeMode == ThemeMode.light
  //         ? ThemeMode.dark
  //         : ThemeMode.light;
  //   });
  // }

  void _onInfoWindowTap(int index) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  _markerImages[index],
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () async {
                  // Connect to MetaMask
                  await WelcomeController.to.connect();
                  String accountAddress = WelcomeController.to.account;

                  // Building and signing a transaction
                  // Replace with actual values
                  var transaction = Transaction(
                    // ... transaction data ...
                  );

                  bool success = true; // Replace with your transaction status

                  if (success) {
                    purchasedNFTs.add(_markerImages[index]);

                    // Save the updated list of NFTs
                    await _saveNFTs(accountAddress, purchasedNFTs);

                    _removeMarker(index);

                    // Navigate to profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          key: const Key("profile_page_key"),
                          imageUrl: _markerImages[index],
                        ),
                      ),
                    );
                  } else {
                    // Handle transaction failure case here
                  }
                },
                child: const Text('Buy it'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _currentThemeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "SkyHi",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: sourceLocation, zoom: 34.5),
              mapType: _currentMapType,
              markers: Set<Marker>.of(_markers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                if (_darkMapStyle != null) {
                  controller.setMapStyle(_darkMapStyle!);
                }
              },
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
            ),
            Positioned(
              top: 15.0,
              right: 15.0,
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: _changeMapType,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    child: const Icon(Icons.map, size: 36.0),
                  ),
                  const SizedBox(height: 10),
                  // FloatingActionButton(
                  //   onPressed: _toggleThemeMode,
                  //   materialTapTargetSize: MaterialTapTargetSize.padded,
                  //   child: Icon(
                  //     _currentThemeMode == ThemeMode.light
                  //         ? Icons.dark_mode
                  //         : Icons.light_mode,
                  //     size: 36.0,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ThemeMode _currentThemeMode = ThemeMode.light;
