import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/main.dart';
import 'package:homemade/model/User.dart';
import 'package:homemade/model/VendorData.dart';
import 'package:homemade/repository/FirebaseRepository.dart';
import 'package:homemade/src/Screens/vendor/Sell.dart';
import 'package:homemade/src/widgets/CutomCard.dart';

class Vendor extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String uuid;

  Vendor({@required this.name, @required this.imageUrl, @required this.uuid});

  @override
  _VendorState createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
            height: 30,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("Vendors")
                .where("uuid", isEqualTo: widget.uuid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data.documentChanges.length == 0) {
                return Text("You have no item to sell");
              }
              if (snapshot.hasData) {
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

                        return CustomCard(
                            type: data.type,
                            imageUrl: data.imageUrl,
                            name: data.name,
                            description: data.description,
                            price: data.price);
                      }),
                );
              }
              return Container();
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
              builder: (context) => Sell(
                uuid: widget.uuid,
                name: widget.name,
                imageUrl: widget.imageUrl,
              ),
            ),
          );
        },
        icon: Icon(EvaIcons.shoppingBagOutline),
      ),
    );
  }
}

class Account extends StatelessWidget {
  final String uuid;

  Account(this.uuid);

  @override
  Widget build(BuildContext context) {
    FirebaseRepository repository = FirebaseRepository();

    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: FutureBuilder<User>(
        future: repository.getUserFromFireStore(uuid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Text(
                  snapshot.data.name,
                  style: Theme.of(context).textTheme.body1,
                ),
                Image.network(
                  snapshot.data.imageUrl,
                  scale: 2,
                ),
                RaisedButton(
                  onPressed: () {
                    repository.signOut().whenComplete(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    });
                  },
                  child: Text("LogOut"),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
