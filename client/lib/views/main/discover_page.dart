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
    LatLng(28.6113123, 77.3136387), // Image 0 coordinates
    LatLng(28.6813125, 77.3135887), // Image 1 coordinates
    LatLng(28.6883127, 77.3139887), // Image 2 coordinates
    LatLng(28.6861269, 77.3135387), // Image 3 coordinates
    LatLng(28.6813181, 77.3115887), // Image 4 coordinates
  ];

  final List<String> _markerImages = [
    'https://ipfs-public.thirdwebcdn.com/ipfs/QmcXu931njCstLjEWQUNmoqGbZuTddPXkjHg4U35K8VPxu/100%20x%20100.png',
    'https://ipfs-public.thirdwebcdn.com/ipfs/QmVNVgo3hu6r7uu9Tt8rFUctGeaJsLAuq1qo5NEHX9ZwC1/Frame%2034153.png',
    'https://ipfs-public.thirdwebcdn.com/ipfs/QmZkkbBMLD8dEBr94JxGU4tpxQ5CSSdQw43PKJJSWsbC8y/Frame%2034155.png',
    'https://ipfs-public.thirdwebcdn.com/ipfs/QmQP6VCW16hfBQ28FVbB68gXiddvn7h4uTWPdZUsqGAoMx/Frame%2034157.png',
    'https://ipfs-public.thirdwebcdn.com/ipfs/QmeJ6ytFgue8nvpXr8KJYZ6AkvKTtACaQ7FHMeTsrN6RRt/Frame%2034159.png',
  ];
  List<Marker> _markers = [];
  late Position _currentPosition;
  bool _isInRange = false;
  List<String> _purchasedImages = [];
  // Add a list of URLs for each image
  final List<String> _markerUrls = [
    'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/0#5feceb66ffc86f38d952786c6d696c79c2dbc239dd4e91b46729d73a27fb57e9',
    'https://sky-hi-nft-marketplace-pyj9.verconst app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/1#6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b',
    'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/2#d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35',
    'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/3#4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce',
    'https://sky-hi-nft-marketplace-pyj9.vercel.app/token/0x09bD0a57a9B6EaDCbc0A043FDa78DB06793d6080/4#4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a',
  ];

  @override
  void initState() {
    super.initState();
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
        targetWidth: 185, // Half the original width
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
    }
  }

  // Future<void> _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

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
        title: const Text('Discover'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: indiaLocation,
              zoom: 14,
            ),
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('Current Location'),
            ),
          ),
        ],
      ),
    );
  }
}
