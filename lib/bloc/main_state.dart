import 'package:meta/meta.dart';

@immutable
abstract class MainState {}

class InitialMainState extends MainState {}

class UserNotSignIn extends MainState {}

class LoadingMainState extends MainState {}

class UserSignedIn extends MainState {
  final String uuid;

  UserSignedIn({@required this.uuid});
}

class UserAlreadySignedIn extends MainState {}

class LoggedOut extends MainState {}
