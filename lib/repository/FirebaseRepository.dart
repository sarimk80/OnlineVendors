import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homemade/model/User.dart';
import 'package:homemade/model/VendorData.dart';

class FirebaseRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  FirebaseRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication authentication =
        await account.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);

    await _auth.signInWithCredential(credential);
    return _auth.currentUser();
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  Future<void> signOut() async {
    return Future.wait(
      [
        _auth.signOut(),
        _googleSignIn.signOut(),
      ],
    );
  }

  Future<FirebaseUser> getUser() async {
    return _auth.currentUser();
  }

  Future<void> sendUserData(String name, String email, String uuid,
      String imageUrl, bool inVendor, String phoneNumber, String address) {
    User user = User(
        name: name,
        email: email,
        imageUrl: imageUrl,
        isVendor: inVendor,
        phoneNumber: phoneNumber,
        address: address);
    return Future.wait([
      Firestore.instance.collection("Users").document(uuid).setData(
            jsonDecode(
              jsonEncode(user),
            ),
          )
    ]);
  }

  Future<void> sendVendorData(File file, String name, String description,
      String price, String type) async {
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("VendorImage")
        .child(file.path.split("/").last);

    StorageUploadTask uploadTask = reference.putFile(file);

    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    String url = downloadUrl.toString();

    VendorData data = VendorData(
        name: name,
        description: description,
        price: price,
        type: type,
        imageUrl: url);

    return Future.wait([
      Firestore.instance.collection("Vendors").document().setData(
            jsonDecode(
              jsonEncode(data),
            ),
          )
    ]);
  }
}
