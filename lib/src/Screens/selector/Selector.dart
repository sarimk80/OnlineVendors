import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homemade/main.dart';
import 'package:homemade/model/User.dart';
import 'package:homemade/repository/FirebaseRepository.dart';
import 'package:homemade/src/Screens/buyer/Buyer.dart';
import 'package:homemade/src/Screens/vendor/Vendro.dart';

class Selector extends StatelessWidget {
  final FirebaseRepository repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<FirebaseUser>(
          future: repository.getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection("Users")
                      .document(snapshot.data.uid)
                      .snapshots(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      User user = User.fromJson(
                        jsonDecode(
                          jsonEncode(asyncSnapshot.data.data),
                        ),
                      );
                      if (user.isVendor) {
                        return Vendor(
                          uuid: snapshot.data.uid,
                          name: snapshot.data.displayName,
                          imageUrl: snapshot.data.photoUrl,
                        );
                      } else {
                        return Buyer(
                          uuid: snapshot.data.uid,
                          name: snapshot.data.displayName,
                          imageUrl: snapshot.data.photoUrl,
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
//
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
