import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/src/Screens/vendor/Sell.dart';

class Vendor extends StatefulWidget {
  final String name;
  final String imageUrl;

  Vendor({@required this.name, @required this.imageUrl});

  @override
  _VendorState createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Hi, ${widget.name}",
                style: Theme.of(context).textTheme.headline,
              ),
              Image.network(
                widget.imageUrl,
                scale: 3,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("Vendor").snapshots(),
            builder: (context, snapshot) {
              return Text("You have nothing to Sell");
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Sell"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Sell(),
            ),
          );
        },
        icon: Icon(EvaIcons.shoppingBagOutline),
      ),
    );
  }
}
