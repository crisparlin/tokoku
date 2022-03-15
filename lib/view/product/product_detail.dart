import 'dart:async';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tokoku/bloc/bloc/home/home_bloc.dart';
import 'package:tokoku/bloc/bloc/product/product_bloc.dart';
import 'package:tokoku/model/product_detail_model.dart';
import 'package:tokoku/utils/constanta.dart';
import 'package:tokoku/view/home/main_home.dart';
import 'package:tokoku/view/product/product_checkout.dart';

class ProductDetailContent extends StatefulWidget {
  final String initFoto;

  const ProductDetailContent({Key key, this.initFoto}) : super(key: key);

  @override
  State<ProductDetailContent> createState() => _ProductDetailContentState();
}

class _ProductDetailContentState extends State<ProductDetailContent> {
  bool hati = false;
  String showFoto = "";
  ProductDetail productDetail = ProductDetail();

  @override
  void initState() {
    // TODO: implement initState
    showFoto = widget.initFoto;
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print(_connectionStatus);
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("detail"),
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back_outlined),
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainHome()))),
              IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => showGeneralDialog(
                      barrierDismissible: false,
                      barrierColor: Colors.black54,
                      context: context,
                      transitionDuration: const Duration(milliseconds: 110),
                      pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) =>
                          ProductCheckout()))
            ],
          )),
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoaded) {
          productDetail = state.productDetail;
          return ListView(
            children: [
              Container(
                height: 400,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[200])),
                child: _connectionStatus == "ConnectivityResult.none"
                    ? Image.asset("assets/images/images.jpg")
                    : Image.network(
                        showFoto,
                        fit: BoxFit.fill,
                        // height: 150,
                        alignment: Alignment.center,
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Wrap(
                  spacing: 10,
                  children: List.generate(
                      4,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                showFoto = index == 0 &&
                                        state.productDetail.product
                                                .prdImage01 !=
                                            null
                                    ? state.productDetail.product.prdImage01
                                    : index == 1 &&
                                            state.productDetail.product
                                                    .prdImage02 !=
                                                null
                                        ? state.productDetail.product.prdImage02
                                        : index == 2 &&
                                                state.productDetail.product
                                                        .prdImage03 !=
                                                    null
                                            ? state.productDetail.product
                                                .prdImage03
                                            : index == 3 &&
                                                    state.productDetail.product
                                                            .prdImage04 !=
                                                        null
                                                ? state.productDetail.product
                                                    .prdImage04
                                                : "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png";
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              color: Colors.white,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: _connectionStatus ==
                                        "ConnectivityResult.none"
                                    ? Image.asset("assets/images/images.jpg")
                                    : Image.network(
                                        index == 0 &&
                                                state.productDetail.product
                                                        .prdImage01 !=
                                                    null
                                            ? state.productDetail.product
                                                .prdImage01
                                            : index == 1 &&
                                                    state.productDetail.product
                                                            .prdImage02 !=
                                                        null
                                                ? state.productDetail.product
                                                    .prdImage02
                                                : index == 2 &&
                                                        state
                                                                .productDetail
                                                                .product
                                                                .prdImage03 !=
                                                            null
                                                    ? state.productDetail
                                                        .product.prdImage03
                                                    : index == 3 &&
                                                            state
                                                                    .productDetail
                                                                    .product
                                                                    .prdImage04 !=
                                                                null
                                                        ? state.productDetail
                                                            .product.prdImage04
                                                        : "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png",
                                        fit: BoxFit.fitHeight,
                                        // height: 150,
                                        alignment: Alignment.center,
                                      ),
                              ),
                            ),
                          )),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp.' +
                          currencyFormatter
                              .format(state.productDetail.product.selPrc),
                      style: poppinsTextFont.copyWith(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                        icon: Icon(
                          !hati ? Icons.favorite_border : Icons.favorite,
                          color: hati ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => {
                              setState(() {
                                if (hati) {
                                  hati = false;
                                } else {
                                  hati = true;
                                }
                              })
                            }),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  state.productDetail.product.prdNm,
                  style: poppinsTextFont.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Terjual 100",
                      style: nunitoTextFont.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.grey[200])),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[600],
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "5",
                            style: nunitoTextFont.copyWith(
                                fontSize: 10, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "(4)",
                            style: nunitoTextFont.copyWith(
                                fontSize: 10, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Text(
                  "Tersedia Bebas Ongkir",
                  style: poppinsTextFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Text(
                  "Dikirim ke Rumah",
                  style: nunitoTextFont.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Text(
                  "Estimasi tiba 14 - 15 mar",
                  style: nunitoTextFont.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]),
                ),
              ),
              Divider(
                thickness: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  "Detail Product",
                  style: poppinsTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        "Kondisi",
                        style: nunitoTextFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Text(
                      "Baru",
                      style: nunitoTextFont.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Divider(
                  thickness: 1,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        "Min. Pemesanan",
                        style: nunitoTextFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Text(
                      "Baru",
                      style: nunitoTextFont.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Divider(
                  thickness: 1,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Html(data: state.productDetail.product.htmlDetail),
              ),
              SizedBox(
                height: 200,
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 10,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: null,
                label: SizedBox(),
                icon: Icon(
                  Icons.message,
                  color: Colors.black,
                )),
            ElevatedButton(
              onPressed: () {
                context
                    .read<ProductBloc>()
                    .add(InsertProductCheckOut(productDetail));
                showGeneralDialog(
                    barrierDismissible: false,
                    barrierColor: Colors.black54,
                    context: context,
                    transitionDuration: const Duration(milliseconds: 110),
                    pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) =>
                        ProductCheckout());
              },
              child: Text(
                "Beli Langsung",
                style: poppinsTextFont.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(color: Colors.black)))),
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<ProductBloc>()
                    .add(InsertProductCheckOut(productDetail));
              },
              child: Text(
                "Keranjang",
                style: poppinsTextFont.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(color: Colors.black)))),
            )
          ],
        ),
      ),
    );
  }
}
