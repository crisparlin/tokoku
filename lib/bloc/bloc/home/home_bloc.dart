import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tokoku/dblocal/database_helper.dart';
import 'package:tokoku/model/product_detail_model.dart';
import 'package:tokoku/model/product_model.dart';
import 'package:tokoku/servis/product_servis.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    final ServisTokoKu servisTokoKu = ServisTokoKu();
    final DbHelper dbHelper = DbHelper();
    List<ProductElement> productElement = [];
    List<ProductElement> finalProductElement = [];
    List<ProductDetail> productDetail = [];

    List a = [];
    int page = 0, limit = 5;
    bool loading = false;

    on<LoadProduct>((event, emit) async {
      if (!loading) {
        loading = true;
        emit(HomeLoading());
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          try {
            page++;
            limit = limit + 5;
            productElement = await servisTokoKu.getListProduct(page);
            if (productElement.length > 0) {
              for (var item in productElement) {
                var reslut = await servisTokoKu.getListDetail(item.prdNo);
                reslut.toJson().forEach((k, v) =>
                    productDetail.add(ProductDetail(product: reslut.product)));
              }
              if (productElement == null) {
                page--;
                emit(const HomeError("Failed"));
              } else {
                finalProductElement.addAll(productElement);
                emit(HomeLoaded(
                    finalProductElement, limit, page, productDetail));
              }
            }else{
              emit(HomeError("error"));
            }
          } catch (e) {
            page--;
            emit(HomeError(e.toString()));
          }
        } else {
          try {
            page++;
            limit = limit + 5;
            var resultHeader = await dbHelper.getProduct();
            var responseHeader = productElementFromJson(resultHeader);
            productElement = responseHeader;
            if (productElement.length > 0) {
              var resultDetail = await dbHelper.getProductDetail();
              var paramDetail = productListFromJson(resultDetail);
              productDetail = paramDetail
                  .map(
                    (item) => ProductDetail(product: item),
                  )
                  .toList();
              if (productElement == null) {
                page--;
                emit(const HomeError("Failed"));
              } else {
                finalProductElement.addAll(productElement);
                emit(HomeLoaded(productElement, limit, page, productDetail));
              }
            }
          } catch (e) {
            page--;
            emit(HomeError(e.toString()));
          }
        }
      }
      loading = false;
    });

    on<SearchProduct>((event, emit) async {
      List<ProductElement> listFinal = [];
      emit(HomeLoading());
      if (event.filter.isEmpty) {
        emit(HomeLoaded(finalProductElement, limit, page, productDetail));
      } else {
        finalProductElement.map(
          (e) {
            if (e.prdNm.toLowerCase().contains(event.filter.toLowerCase())) {
              listFinal.add(e);
            }
          },
        ).toList();
        emit(HomeLoaded(listFinal, limit, page, productDetail));
      }
    });

  }
}
