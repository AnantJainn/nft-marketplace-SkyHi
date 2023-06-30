import 'package:flutter/material.dart';
import 'package:client/views/main/global.dart';

class ProfilePage extends StatefulWidget {
  final String imageUrl;

  ProfilePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Column(
        // Use Column, Row, or Stack as needed
        children: <Widget>[
          Text('Hello, World!'),
          widget.imageUrl.isNotEmpty
              ? Image.network(widget.imageUrl) // display the selected image if the URL is valid
              : Container( // display a placeholder if the URL is not valid
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                ),
        ],
      ),
    );
  }
}
