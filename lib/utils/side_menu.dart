import 'package:flutter/material.dart';
import 'package:tokoku/utils/constanta.dart';

class SideMenu extends StatefulWidget {
  SideMenu({
    Key key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var menu = [
    {"name": "Beranda", "icon": "home", "menuId": "AP001"},
    {"name": "Semua Order", "icon": "e377", "menuId": "AP002"},
    {"name": "Simulasi", "icon": "e121", "menuId": "AP003"},
    {"name": "Tagihan", "icon": "ee33", "menuId": "AP005"},
    {"name": "Profil", "icon": "e042", "menuId": "AP004"},
    // {"name": "Bukpot", "icon": "eedf", "menuId": "AP006"},
    // {"name": "Collateral", "icon": "e596", "menuId": "AP007"},
    // {"name": "Pembiayaan", "icon": "e3f8", "menuId": "AP008"},
  ];

  var menuOw = [
    {"name": "Beranda", "icon": "home", "menuId": "AP001"},
    {"name": "Semua Order", "icon": "search-alt", "menuId": "AP002"},
    {"name": "Simulasi", "icon": "calculator", "menuId": "AP003"},
    {"name": "Tagihan", "icon": "credit-card", "menuId": "AP005"},
    {"name": "Profil", "icon": "user", "menuId": "AP004"},
    // {"name": "Bukpot", "icon": "eedf", "menuId": "AP006"},
    // {"name": "Collateral", "icon": "e596", "menuId": "AP007"},
  ];

  var menuAd = [
    {"name": "Beranda", "icon": "e318", "menuId": "AP001"},
    {"name": "Semua Order", "icon": "e377", "menuId": "AP002"},
    {"name": "Tagihan", "icon": "ee33", "menuId": "AP005"},
    // {"name": "Bukpot", "icon": "eedf", "menuId": "AP006"},
    {"name": "Profil", "icon": "e042", "menuId": "AP004"},
  ];

  String selectedMenu = "AP001";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF1B1B22),
      child: ListView(
        children: [
          DrawerHeader(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text("Logo"),
            ),
          ),
          Wrap(
            children: List.generate(
                menu.length,
                (index) => Container(
                      color: Color(0xFF1B1B22),
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        // onTap: () =>
                        //     clickMenu(index, menuOw[index]['menuId']),
                        horizontalTitleGap: 0.0,
                        leading: const Icon(Icons.access_time),
                        title: Text(
                          "Nama Menu",
                          style: nunitoTextFont.copyWith(
                              color: const Color(0xFF92949D),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
    ;
  }

  Future clickMenu(int index, String menuId) async {
    setState(() {
      selectedMenu = menuId;
    });
    switch (menuId) {
      case 'AP001':
        return Navigator.pushReplacementNamed(
          context,
          '/home',
        );
      case 'AP002':
        return Navigator.pushReplacementNamed(
          context,
          '/order',
        );
      case 'AP005':
        return Navigator.pushReplacementNamed(
          context,
          '/tagihan',
        );
      case 'AP004':
        return Navigator.pushReplacementNamed(
          context,
          '/profil',
        );

      default:
    }
  }
}
