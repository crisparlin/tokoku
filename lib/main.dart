import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tokoku/bloc/bloc/home/home_bloc.dart';
import 'package:tokoku/dblocal/database_helper.dart';
import 'package:tokoku/utils/constanta.dart';
import 'package:tokoku/utils/controller/MenuController.dart';
import 'package:tokoku/view/home/main_home.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MenuController(),
      ),
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Ku',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
          child: InitScreen(
        title: "Toko Ku",
      )),
    );
  }
}

class InitScreen extends StatefulWidget {
  InitScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  DbHelper _dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    initDatabase();
    Future.delayed(Duration(seconds: 5)).then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
  }

  initDatabase() {
    _dbHelper.initDatabase();
    _dbHelper.initDataOffline();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: Container(
        color: Colors.white,
        child: Center(
            child: Lottie.asset('assets/images/loading.json',
                // fit: BoxFit.fitHeight,
                height: 400)),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          color: Colors.white,
          child: ListView(
            children: [
              Lottie.asset('assets/images/shopping.json',
                  // fit: BoxFit.fitHeight,
                  height: 400),
              const SizedBox(
                height: 50,
              ),
              DefaultTextStyle(
                style: poppinsTextFont.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
                child: const Text("Let's improve your style"),
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTextStyle(
                style: poppinsTextFont.copyWith(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                child: const Text(
                    "Find cool style to support your daily acrivities"),
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                key: Key("masuk"),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainHome())),
                child: DefaultTextStyle(
                  style: poppinsTextFont.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                  child: const Text("Get Started"),
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.black)))),
              )
            ],
          )),
    );
  }
}
