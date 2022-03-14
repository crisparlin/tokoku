
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokoku/utils/controller/MenuController.dart';
import 'package:tokoku/utils/responsive.dart';
import 'package:tokoku/utils/side_menu.dart';

class MainMaster extends StatefulWidget {
  final child;

  const MainMaster({Key key, this.child}) : super(key: key);

  @override
  State<MainMaster> createState() => _MainMasterState();
}

class _MainMasterState extends State<MainMaster> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }


}