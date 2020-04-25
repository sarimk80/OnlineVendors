import 'package:meta/meta.dart';

@immutable
abstract class MainEvent {}

class AppStarted extends MainEvent {}

class LogOut extends MainEvent {}
