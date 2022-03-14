import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:tokoku/dblocal/database_helper.dart';
import 'package:tokoku/servis/product_servis.dart';

import '../../../model/product_detail_model.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    final DbHelper dbHelper = DbHelper();
    final ServisTokoKu servisTokoKu = ServisTokoKu();
    on<LoadProductDetail>((event, emit) async {
      ProductDetail productDetail = ProductDetail();
      try {
        emit(ProductLoading());
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          productDetail = await servisTokoKu.getListDetail(event.idProduct);
        }else{
          var result = await dbHelper.getProductDetailById(event.idProduct);

          var paramDetail = productListFromJson(result);
          productDetail = ProductDetail(product: paramDetail.first);
        }

        emit(ProductLoaded(productDetail));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<InsertProductCheckOut>((event, emit) async {
      ProductDetail productDetail = ProductDetail();
      try {
        emit(ProductLoading());
        var result = await dbHelper.insertCheckout(
            event.productDetail.product.prdNo,
            event.productDetail.product.prdNm,
            event.productDetail.product.selPrc,
            event.productDetail.product.prdImage01);
        if (result == "Berhasil") {
          emit(ProductLoaded(event.productDetail));
        } else {
          emit(ProductError(result));
        }
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<LoadProductCheckOut>((event, emit) async {
      List data = [];
      try {
        emit(ProductLoading());
        var result = await dbHelper.getCheckout();
        data = jsonDecode(result);
        emit(ProductCheckoutLoaded(data));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<DeleteProduct>((event, emit) async {
      List data = [];
      try {
        emit(ProductLoading());
        var result = await dbHelper.deleteCheckout(event.idProduct);
        data = jsonDecode(result);
        emit(ProductCheckoutLoaded(data));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<CheckoutProduct>((event, emit) async {
      List data = [];
      try {
        emit(ProductLoading());
        var result = await dbHelper.deleteAll();
        if(result == 0){
          emit(ProductCheckoutDone());
        }

      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
