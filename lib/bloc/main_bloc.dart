import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:homemade/repository/FirebaseRepository.dart';
import './bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final FirebaseRepository repository;

  MainBloc({@required this.repository});

  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is AppStarted) {
      final isSignedIn = await repository.isSignedIn();
      print(isSignedIn);
      if (isSignedIn) {
        yield UserAlreadySignedIn();
      } else {
        yield UserNotSignIn();
      }
    } else if (event is LogOut) {
      await repository.signOut();
      yield LoggedOut();
    }
  }
}
