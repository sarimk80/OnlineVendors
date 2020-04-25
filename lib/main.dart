import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homemade/bloc/bloc.dart';
import 'package:homemade/repository/FirebaseRepository.dart';
import 'package:homemade/src/Screens/Home.dart';
import 'package:homemade/src/UserDetail.dart';
import 'package:homemade/src/widgets/CustomButton.dart';
import 'package:homemade/themes/HomeThemes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xfff5f6fa),
          statusBarIconBrightness: Brightness.dark),
    );
    final FirebaseRepository repository = FirebaseRepository();
    return BlocProvider<MainBloc>(
      create: (context) => MainBloc(repository: repository)..add(AppStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: HomeTheme.homeData(),
        home: Home(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseRepository repository;

  @override
  void initState() {
    repository = FirebaseRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                "Welcome",
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Center(
              child: Text(
                "to",
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            Center(
              child: Text(
                "Online vendor",
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.caption,
                  text:
                      "Where street vendor can also sell there any thing they want to the online world from",
                  children: [
                    TextSpan(
                      text: " vegetables",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: " to"),
                    TextSpan(
                      text: " prepared foods",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: " from"),
                    TextSpan(
                      text: " building materials",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: " to"),
                    TextSpan(
                      text: " garments",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: " and"),
                    TextSpan(
                      text: " crafts",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: " from"),
                    TextSpan(
                      text: " consumer electronics",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: " to"),
                    TextSpan(
                      text: " auto repairs",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                        text:
                            """ Most street vendors provide the main source of income for their households, bringing food to their families and paying school fees for their children.""")
                  ],
                ),
              ),

            ),
            SizedBox(
              height: 50,
            ),
            CustomButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserDetail(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Help desk",
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),
      ),
    );
  }
}
