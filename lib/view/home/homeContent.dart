import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tokoku/bloc/bloc/home/home_bloc.dart';
import 'package:tokoku/model/product_detail_model.dart';
import 'package:tokoku/model/product_model.dart';
import 'package:tokoku/servis/product_servis.dart';
import 'package:tokoku/utils/constanta.dart';
import 'package:tokoku/utils/controller/MenuController.dart';
import 'package:tokoku/utils/responsive.dart';
import 'package:tokoku/view/product/main_product.dart';
import 'package:tokoku/view/product/product_checkout.dart';
import 'package:tokoku/view/product/product_detail.dart';

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController _filter = new TextEditingController();

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) {}
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: ListTile(
              leading: const Icon(Icons.search),
              title: TextFormField(
                controller: _filter,
                // ignore: unnecessary_const
                decoration: const InputDecoration(
                    hintText: "Search", border: InputBorder.none),
                onChanged: (value) {
                  context.read<HomeBloc>().add(SearchProduct(value));
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => showGeneralDialog(
                    barrierDismissible: false,
                    barrierColor: Colors.black54,
                    context: context,
                    transitionDuration: const Duration(milliseconds: 110),
                    pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) =>
                        ProductCheckout()),
              ),
            ),
          ),
          body: ContentListProduct()),
    );
  }
}

class ContentListProduct extends StatefulWidget {
  @override
  State<ContentListProduct> createState() => _ContentListProductState();
}

class _ContentListProductState extends State<ContentListProduct> {
  final HomeBloc homeBloc = HomeBloc();
  int _pageSize = 5;
  int count;
  int page = 1;
  bool loading = false, init = false;
  List<ProductElement> productElement = [];
  List<ProductDetail> productDetail = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;


  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _refreshController.dispose();
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
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _onRefresh() async {
    if (mounted) {
      context.read<HomeBloc>().add(const LoadProduct(5, 0, []));
    }
    _refreshController.refreshCompleted();
  }

  void _loadMore() {
    if (mounted) {
      if (_pageSize < count) {
        setState(() {
          _pageSize = _pageSize + 5;
        });
        _refreshController.loadComplete();
      } else if (_pageSize > count) {
        setState(() {
          _pageSize = count;
        });
        _refreshController.loadComplete();
      } else {
        context
            .read<HomeBloc>()
            .add(LoadProduct(_pageSize, page, productElement));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoading) {
          setState(() {
            if (!init) {
              loading = true;
              init = true;
            }
          });
        }
        if (state is HomeLoaded) {
          setState(() {
            setValue(state.limit, state.productElement, state.productDetail);
            loading = false;
          });
        }
        if (state is HomeError) {
          _refreshController.loadComplete();
        }
      },
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = const Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = const Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = const Text("release to load more");
                  } else {
                    body = const Text("No more Data");
                  }
                  return SizedBox(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _loadMore,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Wrap(
                  spacing: 1,
                  runSpacing: 1,
                  children: List.generate(
                      _pageSize > productElement.length
                          ? productElement.length
                          : _pageSize,
                      (index) => Container(
                            width: 195,
                            child: GestureDetector(
                              child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: _connectionStatus == "ConnectivityResult.none" ? Image.asset("assets/images/images.jpg") : Image.network(
                                          productElement[index].prdNo ==
                                                      productDetail[index]
                                                          .product
                                                          .prdNo &&
                                                  productDetail[index]
                                                          .product
                                                          .prdImage01 !=
                                                      null
                                              ? productDetail[index]
                                                  .product
                                                  .prdImage01
                                              : "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png",
                                          fit: BoxFit.fill,
                                          // height: 150,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 5),
                                        child: Text(
                                          productElement[index].prdNm,
                                          style: nunitoTextFont.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 5),
                                        child: Text(
                                          'Rp. ' +
                                              currencyFormatter.format(
                                                  productElement[index].selPrc),
                                          style: nunitoTextFont.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: List.generate(
                                                    5,
                                                    (index) => Icon(
                                                          index == 4
                                                              ? Icons.star_half
                                                              : Icons.star,
                                                          color: Colors
                                                              .yellow[600],
                                                          size: 10,
                                                        )),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "10RB+ Terjual",
                                                style: nunitoTextFont.copyWith(
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 5),
                                        child: Text(
                                          'Gratis ongkir',
                                          style: nunitoTextFont.copyWith(
                                              fontSize: 10,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.grey,
                                                size: 14,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Jakarta",
                                                style: nunitoTextFont.copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainProduct(
                                              idProduct:
                                                  productElement[index].prdNo,
                                              initFoto: productDetail[index]
                                                  .product
                                                  .prdImage01
                                                  .toString(),
                                            )));
                              },
                            ),
                          )),
                ),
              ),
            ),
    );
  }

  setValue(int pages, list, listProductDetail) {
    productDetail = listProductDetail;
    productElement = list;
    page = pages;
    count = list.length;
    _refreshController.loadComplete();
  }

}
