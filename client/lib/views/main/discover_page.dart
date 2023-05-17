// import 'package:flutter/material.dart';
// // import 'package:google_mao/order_traking_page.dart';
// import 'package:client/views/main/order_traking_page.dart';
// void main() {
//   runApp(const DiscoverPage());
// }

// class DiscoverPage extends StatelessWidget {
//   const DiscoverPage({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           elevation: 0,
//         ),
//       ),
//       home: const OrderTrackingPage(),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class DiscoverPage extends StatefulWidget {
//   const DiscoverPage({Key? key}) : super(key: key);

//   @override
//   State<DiscoverPage> createState() => DiscoverPageState();
// }

// class DiscoverPageState extends State<DiscoverPage> {
//   final Completer<GoogleMapController> _controller = Completer();

//   static const LatLng sourceLocation = LatLng(20.5937, 78.9629);
//   static const LatLng destination = LatLng(20.5937, 78.9629);

//   List<Marker> _markers = []; // Add a list of markers to the state
//   MapType _currentMapType = MapType.normal;

//   @override
//   void initState() {
//     super.initState();
//     _initMarkers();
//   }

//   // Initialize the markers with their respective images and LatLng coordinates
//   void _initMarkers() {
//     _markers.add(Marker(
//       markerId: MarkerId('marker1'),
//       position: LatLng(20.5937, 78.9629),
//       infoWindow: InfoWindow(
//         title: 'Image 1',
//         snippet: 'Click here to enlarge',
//         onTap: () => _onInfoWindowTap(0),
//       ),
//     ));

//     _markers.add(Marker(
//       markerId: MarkerId('marker2'),
//       position: LatLng(20.6127, 78.9829),
//       infoWindow: InfoWindow(
//         title: 'Image 2',
//         snippet: 'Click here to enlarge',
//         onTap: () => _onInfoWindowTap(1),
//       ),
//     ));

//     _markers.add(Marker(
//       markerId: MarkerId('marker3'),
//       position: LatLng(20.5717, 78.9529),
//       infoWindow: InfoWindow(
//         title: 'Image 3',
//         snippet: 'Click here to enlarge',
//         onTap: () => _onInfoWindowTap(2),
//       ),
//     ));
//   }

//   List<String> imageUrls = [
//     'https://unsplash.com/photos/Ig11g3d3tMQ',
//     'https://unsplash.com/photos/4CN96Q0lq3A',
//     'https://lh3.googleusercontent.com/ogw/AOLn63GZfPJELQcFQp8XxQWKFIwSwPLPbNTkrTdcab8zG7k=s64-c-mo',
//   ];

//   void _onInfoWindowTap(int index) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.5,
//           child: Column(
//             children: [
//               Expanded(
//                 child: CarouselSlider.builder(
//                   itemCount: 1,
//                   itemBuilder: (BuildContext context, int _, int __) {
//                     return Image.network(
//                       imageUrls[index],
//                       fit: BoxFit.cover,
//                     );
//                   },
//                   options: CarouselOptions(
//                     aspectRatio: 2.0,
//                     enlargeCenterPage: true,
//                     viewportFraction: 0.9,
//                     autoPlay: false,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Text('Buy it'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _switchMapType() {
//     setState(() {
//       if (_currentMapType == MapType.normal) {
//         _currentMapType = MapType.satellite;
//       } else if (_currentMapType == MapType.satellite) {
//         _currentMapType = MapType.hybrid;
//       } else {
//         _currentMapType = MapType.normal;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "SkyHi",
//           style: TextStyle(color: Colors.black, fontSize: 16),
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             mapType: _currentMapType,
//             initialCameraPosition:
//                 CameraPosition(target: sourceLocation, zoom: 14.5),
//             markers: Set<Marker>.of(_markers),
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//           ),
//           Positioned(
//             top: 10.0, // Adjust this value to position the buttons vertically
//             right:
//                 10.0, // Adjust this value to position the buttons horizontally
//             child: Column(
//               children: [
//                 FloatingActionButton(
//                   onPressed: _switchMapType,
//                   child: Icon(Icons.map),
//                 ),
//                 SizedBox(height: 10), // Add space between the buttons
//                 FloatingActionButton(
//                   onPressed: _zoomIn, // Add the zoom in function here
//                   child: Icon(Icons.zoom_in),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Add this function to zoom in on the map
//   void _zoomIn() async {
//     final GoogleMapController controller = await _controller.future;
//     final currentZoom = await controller.getZoomLevel();
//     controller.animateCamera(CameraUpdate.zoomTo(currentZoom + 1));
//   }
// }

// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'dart:ui' as dart_ui;

// class DiscoverPage extends StatefulWidget {
//   const DiscoverPage({Key? key}) : super(key: key);

//   @override
//   State<DiscoverPage> createState() => DiscoverPageState();
// }

// class DiscoverPageState extends State<DiscoverPage> {
//   final Completer<GoogleMapController> _controller = Completer();
//   static const LatLng sourceLocation = LatLng(20.5937, 78.9629);
//   List<Marker> _markers = [];
//   MapType _currentMapType = MapType.normal;

//   List<String> imageUrls = [
//     'https://unsplash.com/photos/Ig11g3d3tMQ',
//     'https://unsplash.com/photos/4CN96Q0lq3A',
//     'https://lh3.googleusercontent.com/ogw/AOLn63GZfPJELQcFQp8XxQWKFIwSwPLPbNTkrTdcab8zG7k=s64-c-mo',
//   ];

//   // get ui => null;

//   // get dart_ui => null;

//   @override
//   void initState() {
//     super.initState();
//     _initMarkers();
//   }

//   void _initMarkers() async {
//     for (int i = 0; i < imageUrls.length; i++) {
//       final Uint8List markerIcon = await getBytesFromAsset('assets/images/image${i + 1}.png', 100);

//       _markers.add(Marker(
//         markerId: MarkerId('marker$i'),
//         position: LatLng(20.5937 + 0.02 * i, 78.9629 + 0.02 * i),
//         icon: BitmapDescriptor.fromBytes(markerIcon),
//         infoWindow: InfoWindow(
//           title: 'Image ${i + 1}',
//           snippet: 'Click here to enlarge',
//           onTap: () => _onInfoWindowTap(i),
//         ),
//       ));
//     }
//     setState(() {});
//   }

//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     dart_ui.Codec codec = await dart_ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
//     dart_ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: dart_ui.ImageByteFormat.png))!.buffer.asUint8List();
//   }

//   void _onInfoWindowTap(int index) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.5,
//           child: Column(
//             children: [
//               Expanded(
//                 child: CarouselSlider.builder(
//                   itemCount: 1,
//                   itemBuilder: (BuildContext context, int _, int __) {
//                     return Image.network(
//                       imageUrls[index],
//                       fit: BoxFit.cover,
//                     );
//                   },
//                   options: CarouselOptions(
//                     aspectRatio: 2.0,
//                     enlargeCenterPage: true,
//                     viewportFraction: 0.9,
//                     autoPlay: false,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Text('Buy'),
//               ),

//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _switchMapType() {
//     setState(() {
//       if (_currentMapType == MapType.normal) {
//         _currentMapType = MapType.satellite;
//       } else if (_currentMapType == MapType.satellite) {
//         _currentMapType = MapType.hybrid;
//       } else {
//         _currentMapType = MapType.normal;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "SkyHi",
//           style: TextStyle(color: Colors.black, fontSize: 16),
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             mapType: _currentMapType,
//             initialCameraPosition: CameraPosition(target: sourceLocation, zoom: 14.5),
//             markers: Set<Marker>.of(_markers),
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//           ),
//           Positioned(
//             top: 10.0,
//             right: 10.0,
//             child: Column(
//               children: [
//                 FloatingActionButton(
//                   onPressed: _switchMapType,
//                   child: Icon(Icons.map),
//                 ),
//                 SizedBox(height: 10),
//                 FloatingActionButton(
//                   onPressed: _zoomIn,
//                   child: Icon(Icons.zoom_in),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _zoomIn() async {
//     final GoogleMapController controller = await _controller.future;
//     final currentZoom = await controller.getZoomLevel();
//     controller.animateCamera(CameraUpdate.zoomTo(currentZoom + 1));
//   }
// }

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
  final client = Web3Client(
    'https://eth-goerli.g.alchemy.com/v2/__Qu_EtvGn0g8jtrjsp4RsWiOy0SA-Gq',
    Client(),
    socketConnector: () {
      return IOWebSocketChannel.connect(
              'wss://eth-goerli.g.alchemy.com/v2/__Qu_EtvGn0g8jtrjsp4RsWiOy0SA-Gq')
          .cast<String>();
    },
  );

  // void _mintNFT() async {
  //   final contract = DeployedContract(
  //     ContractAbi.fromJson(jsonEncode(_yourContractAbi), '4_Create-NFT'),
  //     EthereumAddress.fromHex('0xaa775dFd91D7694a5cC8b41CBB12078b20b20E9E'),
  //   );

  //   final function = contract.function('mintNFT');

  //   // Replace ['Function Parameters'] with actual parameters
  //   final response = await client.call(
  //     sender:
  //         EthereumAddress.fromHex('0x0A2222B3BC8827573322040a6347aF5aB828Cb4F'),
  //     contract: contract,
  //     function: function,
  //     params: ['0x0A2222B3BC8827573322040a6347aF5aB828Cb4F'],
  //   );
  // }

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

  // Function to toggle map type
  // void _changeMapType() {
  //   setState(() {
  //     _currentMapType = _currentMapType == MapType.normal
  //         ? MapType.satellite
  //         : MapType.normal;
  //   });
  // }

  ThemeMode _currentThemeMode = ThemeMode.light;

  // Function to toggle theme mode
  void _toggleThemeMode() {
    setState(() {
      _currentThemeMode = _currentThemeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng indiaLocation = LatLng(20.5937, 78.9629);

  final List<LatLng> _markerPositions = [
    const LatLng(20.5937, 78.9629),
    const LatLng(20.5938, 78.9630),
    const LatLng(20.5939, 78.9631),
    const LatLng(20.5940, 78.9632),
    const LatLng(20.5941, 78.9633),
  ];

  final List<String> _markerImages = [
    'https://gateway.pinata.cloud/ipfs/QmQ2mkZw5c2Cstp4NboT4moaNrCiYFoXF9bB8e43gQiFoN?_gl=1*1n0c8n8*rs_ga*MTM2OTkwMjQ5Ny4xNjg0MTY2NzYx*rs_ga_5RMPXG14TE*MTY4NDE2Njc2MS4xLjEuMTY4NDE2NjgwMC4yMS4wLjA.',
    'https://gateway.pinata.cloud/ipfs/QmWr2rCWaeDTGJuxDj4RqdxQ3agQbomX2pcqcQ95JQD59r?_gl=1*189c93v*rs_ga*MTM2OTkwMjQ5Ny4xNjg0MTY2NzYx*rs_ga_5RMPXG14TE*MTY4NDMzNzU1Ni4zLjEuMTY4NDMzNzc5Ny41OC4wLjA.',
    'https://gateway.pinata.cloud/ipfs/QmQ2mkZw5c2Cstp4NboT4moaNrCiYFoXF9bB8e43gQiFoN?_gl=1*1n0c8n8*rs_ga*MTM2OTkwMjQ5Ny4xNjg0MTY2NzYx*rs_ga_5RMPXG14TE*MTY4NDE2Njc2MS4xLjEuMTY4NDE2NjgwMC4yMS4wLjA.',
    'https://gateway.pinata.cloud/ipfs/QmQ2mkZw5c2Cstp4NboT4moaNrCiYFoXF9bB8e43gQiFoN?_gl=1*1n0c8n8*rs_ga*MTM2OTkwMjQ5Ny4xNjg0MTY2NzYx*rs_ga_5RMPXG14TE*MTY4NDE2Njc2MS4xLjEuMTY4NDE2NjgwMC4yMS4wLjA.',
    'https://gateway.pinata.cloud/ipfs/QmQ2mkZw5c2Cstp4NboT4moaNrCiYFoXF9bB8e43gQiFoN?_gl=1*1n0c8n8*rs_ga*MTM2OTkwMjQ5Ny4xNjg0MTY2NzYx*rs_ga_5RMPXG14TE*MTY4NDE2Njc2MS4xLjEuMTY4NDE2NjgwMC4yMS4wLjA.',
  ];

  final List<Marker> _markers = [];

  LatLng get sourceLocation => const LatLng(20.5937, 78.9629);

  // Add a list of markers to the state

  // @override
  // void initState() {
  //   super.initState();
  //   _initMarkers();
  // }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    try {
      http.Response response = await http.get(Uri.parse(path));
      final Uint8List bytes = response.bodyBytes;
      final ui.Codec codec =
          await ui.instantiateImageCodec(bytes, targetWidth: width);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image img = frameInfo.image;
      final ByteData? data =
          await img.toByteData(format: ui.ImageByteFormat.png);
      return data!.buffer.asUint8List();
    } catch (e) {
      debugPrint(e as String?);
      rethrow;
    }
  }

  Future<void> _initMarkers() async {
    for (int i = 0; i < _markerPositions.length; i++) {
      final Uint8List markerIcon =
          await getBytesFromAsset(_markerImages[i], 200); // Change 100 to 200
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

  // global.dart

  // List<String> purchasedNFTs = [];

  void _onInfoWindowTap(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height *
                    0.4, // Adjust this as needed
                width:
                    MediaQuery.of(context).size.width, // Adjust this as needed
                child: Image.network(
                  _markerImages[index],
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () {
                  _mintNFT("0x0A2222B3BC8827573322040a6347aF5aB828Cb4F",
                      "https://gateway.pinata.cloud/ipfs/QmQ2mkZw5c2Cstp4NboT4moaNrCiYFoXF9bB8e43gQiFoN?_gl=1*1n0c8n8*rs_ga*MTM2OTkwMjQ5Ny4xNjg0MTY2NzYx*rs_ga_5RMPXG14TE*MTY4NDE2Njc2MS4xLjEuMTY4NDE2NjgwMC4yMS4wLjA.");
                  purchasedNFTs.add(_markerImages[
                      index]); // Add the URL to the purchasedNFTs list
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            key: const Key("profile_page_key"),
                            imageUrl: _markerImages[index])),
                  );
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
                  controller.setMapStyle(_darkMapStyle);
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
                  FloatingActionButton(
                    onPressed: _toggleThemeMode,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    child: Icon(
                      _currentThemeMode == ThemeMode.light
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      size: 36.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
