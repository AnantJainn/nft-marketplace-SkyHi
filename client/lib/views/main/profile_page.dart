import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:client/views/main/global.dart';

// import 'package:flutter/material.dart';

// class ProfilePage extends StatefulWidget {
//   // ProfilePage({Key? key, required user}) : super(key: key);

//   // @override
//   // _ProfilePageState createState() => _ProfilePageState();

//   final String imageUrl;

//   ProfilePage({Key key, this.imageUrl}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

class ProfilePage extends StatefulWidget {
  final String imageUrl;

  ProfilePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Page'),
//       ),
//       body: Column(
//         // Use Column, Row or Stack as needed
//         children: <Widget>[
//           Text('Hello, World!'),
//           widget.imageUrl.isNotEmpty
//             ? Image.network(widget.imageUrl) // display the selected image if the URL is valid
//             : Container( // display a placeholder if the URL is not valid
//                 width: 100,
//                 height: 100,
//                 color: Colors.grey,
//               ),
//         ],
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: ListView.builder(
        itemCount: purchasedNFTs.length,
        itemBuilder: (context, index) {
          return Image.network(purchasedNFTs[index]);
        },
      ),
    );
  }
}
