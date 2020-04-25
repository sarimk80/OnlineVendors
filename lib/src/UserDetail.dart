import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/main.dart';
import 'package:homemade/repository/FirebaseRepository.dart';
import 'package:homemade/src/widgets/CustomButton.dart';

class UserDetail extends StatefulWidget {
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  FirebaseRepository _firebaseRepository;
  TextEditingController phoneController;
  TextEditingController addressController;

  bool isVendor = false;
  bool isBuyer = false;
  bool isLoading = false;

  @override
  void initState() {
    _firebaseRepository = FirebaseRepository();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text("Almost there...."),
          Text(
            "Just few more details....",
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text(
              "Vendor",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Switch(
                value: isVendor,
                onChanged: (value) {
                  setState(() {
                    isBuyer = false;
                    isVendor = value;
                  });
                }),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text(
              "Buyer",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Switch(
              value: isBuyer,
              onChanged: (value) {
                setState(() {
                  isVendor = false;
                  isBuyer = value;
                });
              },
            ),
          ),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Icon(EvaIcons.phoneOutline),
              helperText: "Enter Phone number",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: addressController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(EvaIcons.homeOutline),
              helperText: "Enter Home Address",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            onTap: () {
              setState(() {
                isLoading = true;
              });
              _firebaseRepository.signInWithGoogle().then((user) {
                _firebaseRepository
                    .sendUserData(
                        user.displayName,
                        user.email,
                        user.uid,
                        user.photoUrl,
                        isVendor,
                        phoneController.text,
                        addressController.text)
                    .whenComplete(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                });
//
              });
            },
          )
        ],
      ),
    );
  }
}
