import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String type;
  final String imageUrl;
  final String name;
  final String description;
  final String price;

  CustomCard(
      {@required this.type,
      @required this.imageUrl,
      @required this.name,
      @required this.description,
      @required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).primaryColor,
      child: Container(
        height: MediaQuery.of(context).size.height/2,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Text(
              this.type,
              style: Theme.of(context).textTheme.body1,
            ),
            Container(
              height: MediaQuery.of(context).size.height/3,
                child: Image.network(
              this.imageUrl,
              fit: BoxFit.cover,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  this.name,
                  style: Theme.of(context).textTheme.body1,
                ),
                Text(
                  "Price: ${this.price}",
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
            Text(
              this.description,
              style: Theme.of(context).textTheme.body2,
            )
          ],
        ),
      ),
    );
  }
}
