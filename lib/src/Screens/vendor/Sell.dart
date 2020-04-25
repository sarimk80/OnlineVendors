import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homemade/repository/FirebaseRepository.dart';
import 'package:homemade/src/widgets/CustomButton.dart';
import 'package:image_picker/image_picker.dart';

class Sell extends StatefulWidget {
  final String uuid;
  final String name;
  final String imageUrl;

  Sell({this.uuid, this.name, this.imageUrl});

  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  bool isFood = true;
  bool isFruit = false;
  bool isVegetable = false;
  bool isOther = false;
  String type = "Food";
  double slider = 0.0;
  bool isLoading = false;
  File _file;
  FirebaseRepository repository;
  TextEditingController nameController;
  TextEditingController descriptionController;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _file = image;
    });
  }

  @override
  void initState() {
    repository = FirebaseRepository();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Sell"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Text(
            "Type",
            style: Theme.of(context).textTheme.body1,
          ),
          ListTile(
            title: Text("HomeMade Food",
                style: Theme.of(context).textTheme.caption),
            trailing: Checkbox(
                value: isFood,
                onChanged: (value) {
                  setState(() {
                    type = "Food";
                    isFood = value;
                    isFruit = false;
                    isVegetable = false;
                    isOther = false;
                  });
                }),
          ),
          ListTile(
              title: Text("Fruits", style: Theme.of(context).textTheme.caption),
              trailing: Checkbox(
                  value: isFruit,
                  onChanged: (value) {
                    setState(() {
                      type = "Fruit";
                      isFruit = value;
                      isFood = false;
                      isVegetable = false;
                      isOther = false;
                    });
                  })),
          ListTile(
              title: Text("Vegetables",
                  style: Theme.of(context).textTheme.caption),
              trailing: Checkbox(
                  value: isVegetable,
                  onChanged: (value) {
                    setState(() {
                      type = "Vegetable";
                      isVegetable = value;
                      isFood = false;
                      isFruit = false;
                      isOther = false;
                    });
                  })),
          ListTile(
            title: Text("Others", style: Theme.of(context).textTheme.caption),
            trailing: Checkbox(
              value: isOther,
              onChanged: (value) {
                setState(
                  () {
                    type = "Others";
                    isOther = value;
                    isFood = false;
                    isVegetable = false;
                    isFruit = false;
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(helperText: "Enter Item Name"),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(helperText: "Enter Item Description"),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Select Price:  ${slider.toInt()}",
            style: Theme.of(context).textTheme.body1,
          ),
          SizedBox(
            height: 20,
          ),
          Slider(
            activeColor: Theme.of(context).accentColor,
            inactiveColor: Theme.of(context).accentColor.withOpacity(0.3),
            label: "Power",
            min: 0,
            max: 100,
            value: slider,
            onChanged: (value) {
              setState(() {
                slider = value;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Select Image",
            style: Theme.of(context).textTheme.body1,
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: getImage,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _file == null
                      ? NetworkImage(
                          "https://img.favpng.com/6/11/3/camera-icon-design-icon-png-favpng-sJFW2mRtWxBTG6T65cg3tXy71.jpg")
                      : FileImage(_file),
                ),
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200],
                      offset: Offset(1, 1),
                      blurRadius: 0.9,
                      spreadRadius: 0.5),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          isLoading ? Center(child: CircularProgressIndicator()) : Container(),
          SizedBox(
            height: 25,
          ),
          CustomButton(onTap: () {
            print("Button Press");
            if (nameController.text.isEmpty &&
                descriptionController.text.isEmpty) {
              print("Empty");
            } else {
              setState(() {
                isLoading = true;
              });

              repository
                  .sendVendorData(
                      _file,
                      nameController.text,
                      descriptionController.text,
                      slider.toInt().toString(),
                      type,
                      widget.uuid,
                      widget.name,
                      widget.imageUrl)
                  .whenComplete(() {
                Navigator.pop(context);
              }).catchError((error) {
                print(error.toString());
              });
            }
          }),
        ],
      ),
    );
  }
}
