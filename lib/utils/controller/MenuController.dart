import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }
  void controlTracking() {
    if (!_scaffoldKey.currentState.isEndDrawerOpen) {
      _scaffoldKey.currentState?.openEndDrawer();
    }
  }
}
