import 'package:flutter/material.dart';
import 'package:tokoku/bloc/bloc/home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokoku/bloc/bloc/product/product_bloc.dart';
import 'package:tokoku/model/product_model.dart';
import 'package:tokoku/utils/MainMaster.dart';
import 'package:tokoku/view/home/homeContent.dart';
import 'package:tokoku/view/product/product_detail.dart';


class MainProduct extends StatefulWidget {
  final int idProduct;
  final String initFoto;

  const MainProduct({Key key, this.idProduct, this.initFoto}) : super(key: key);
  @override
  State<MainProduct> createState() => _MainProductState();
}

class _MainProductState extends State<MainProduct> {
  final ProductBloc productBloc = ProductBloc();

  @override
  void initState() {
    productBloc.add(LoadProductDetail(widget.idProduct));
    super.initState();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: MainMaster(
          child: MultiBlocProvider(providers: [
            BlocProvider(create: (context) => productBloc),
          ],child: ProductDetailContent(initFoto: widget.initFoto,)),
        )
    );
  }
}
