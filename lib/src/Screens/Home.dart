import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homemade/bloc/bloc.dart';
import 'package:homemade/main.dart';
import 'package:homemade/src/Screens/selector/Selector.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(builder: (context, state) {
      if (state is UserAlreadySignedIn) {
        return Selector();
      } else if (state is UserNotSignIn) {

        return MyHomePage(
          title: "",
        );
      }
      return Container();
    });
  }
}
