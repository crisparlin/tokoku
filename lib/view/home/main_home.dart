import 'package:flutter/material.dart';
import 'package:tokoku/bloc/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokoku/model/product_model.dart';
import 'package:tokoku/utils/MainMaster.dart';
import 'package:tokoku/view/home/homeContent.dart';


class MainHome extends StatefulWidget {
  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(const LoadProduct(5,0,[]));
    super.initState();
  }


  Widget build(BuildContext context) {
    // TODO: implement build
    return MainMaster(
      child: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => homeBloc),
      ],child: HomeContent()),
    );
  }
}
