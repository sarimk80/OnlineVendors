import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/model/VendorData.dart';
import 'package:homemade/src/Screens/vendor/Vendro.dart';

class Buyer extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String uuid;

  Buyer({this.name, this.imageUrl, this.uuid});

  @override
  _BuyerState createState() => _BuyerState();
}

class _BuyerState extends State<Buyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        primary: true,
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Hi, ${widget.name}",
                style: Theme.of(context).textTheme.headline,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Account(widget.uuid),
                    ),
                  );
                },
                child: Image.network(
                  widget.imageUrl,
                  scale: 3,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("Vendors")
                  .where("type", isEqualTo: "Food")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    "Nothing to see here",
                    style: Theme.of(context).textTheme.body1,
                  );
                }
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: snapshot.data.documentChanges.length,
                      itemBuilder: (context, index) {
                        VendorData data = VendorData.fromJson(
                          jsonDecode(
                            jsonEncode(snapshot
                                .data.documentChanges[index].document.data),
                          ),
                        );
                        return Card(
                          color: Theme.of(context).primaryColor,
                          elevation: 0,
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "${data.senderName}",
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  Image.network(
                                    data.senderImage,
                                    scale: 3,
                                  ),
                                ],
                              ),
                              Image.network(data.imageUrl),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "${data.name} (${data.type})",
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  Text(
                                    "Price: ${data.price}",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              Text(
                                data.description,
                                style: Theme.of(context).textTheme.body2,
                              )
                            ],
                          ),
                        );
                      }),
                );
              })
        ],
      ),
    );
  }
}
