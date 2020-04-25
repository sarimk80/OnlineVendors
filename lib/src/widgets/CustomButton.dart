import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final Function onTap;


  CustomButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
    decoration: BoxDecoration(
    color: Theme.of(context).accentColor,
    borderRadius: BorderRadius.all(
    Radius.circular(8),
    ),
    ),
    child: Padding(
    padding: const EdgeInsets.all(10),
    child: Center(
    child: Text(
    "Lets Go....",
    style: Theme.of(context)
        .textTheme
        .button
        .copyWith(color: Theme.of(context).primaryColor),
    ),
    ),
    ),
    ),
    );
  }
}
