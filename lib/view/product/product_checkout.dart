import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tokoku/bloc/bloc/product/product_bloc.dart';
import 'package:tokoku/utils/constanta.dart';
import 'package:tokoku/view/home/main_home.dart';

class ProductCheckout extends StatefulWidget {
  @override
  State<ProductCheckout> createState() => _ProductCheckoutState();
}

class _ProductCheckoutState extends State<ProductCheckout> {
  final ProductBloc productBloc = ProductBloc();
  List data = [];
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productBloc.add(LoadProductCheckOut());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: productBloc,
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductCheckoutLoaded) {
            setState(() {
              total = 0;
              data = state.data;
              data.forEach((item) {
                total = total + item["hargaProduct"];
              });
            });
          }
          if (state is ProductCheckoutDone) {
            showDialog(
                barrierDismissible: false,
                barrierColor: Colors.transparent,
                context: context,
                builder: (BuildContext ctx) => dialogsPopup(
                    'assets/images/berhasil.json', "Data Terkirim"));
            Future.delayed(Duration(seconds: 5)).then((_) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainHome()));
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: Colors.white,
              title: Text(
                "Keranjang",
                style: poppinsTextFont.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
          body: data.length == 0
              ? Center(
                  child: ListView(
                  children: [
                    Lottie.asset('assets/images/notfound.json', height: 400),
                    Center(
                      child: Text(
                        "Data Not Found",
                        style: poppinsTextFont.copyWith(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ))
              : ListView(
                  children: [
                    Container(
                      color: Colors.grey,
                      child: Column(
                        children: List.generate(
                            data.length,
                            (index) => Container(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: ListTile(
                                          leading: Container(
                                            height: 60,
                                            width: 60,
                                            color: Colors.white,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Image.network(
                                                data[index]["urlImage"],
                                                fit: BoxFit.fill,
                                                // height: 150,
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                              data[index]["namaProduct"],
                                              style: poppinsTextFont.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14)),
                                          subtitle: Text(
                                              'Rp ' +
                                                  currencyFormatter.format(
                                                      data[index]
                                                          ["hargaProduct"]),
                                              style: poppinsTextFont.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14)),
                                          trailing: IconButton(
                                            onPressed: () {
                                              productBloc.add(DeleteProduct(
                                                  data[index]["id"]));
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 5,
                                        color: Colors.grey[200],
                                      )
                                    ],
                                  ),
                                )),
                      ),
                    ),
                  ],
                ),
          bottomSheet: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Total Harga",
                      style: poppinsTextFont.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Rp " + currencyFormatter.format(total),
                      style: poppinsTextFont.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: data.length == 0
                      ? null
                      : () {
                          productBloc.add(CheckoutProduct());
                        },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    child: Text(
                      "Bayar",
                      style: poppinsTextFont.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(color: Colors.black)))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
