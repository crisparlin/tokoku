import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tokoku/model/product_detail_model.dart';
import 'package:tokoku/model/product_model.dart';
import 'dart:async';
import 'package:xml2json/xml2json.dart';

class ServisTokoKu {
  final Xml2Json xml2Json = Xml2Json();

  Future<List<ProductElement>> getListProduct(page) async {
    List<ProductElement> productElement = [];
    final response = await ApiConnection(
      'http://api.elevenia.co.id/rest/prodservices/product/listing?page=' +
          page.toString(),
    );
    if(response != null){
      var result = productCatalogFromJson(response);
      productElement = result.products.product;
      return productElement;
    }else{
      return null;
    }
  }

  Future<ProductDetail> getListDetail(id) async {
    ProductDetail productDetail;
    var products;
    final response = await ApiConnection(
      'http://api.elevenia.co.id/rest/prodservices/product/details/' +
          id.toString(),
    );
    productDetail = productDetailFromJson(response);
    return productDetail;
  }
}

Future<String> ApiConnection(String URL) async {
  final Xml2Json xml2Json = Xml2Json();
  http.Response response;
  String jsonString;
  try {
    var headers = {
      'Accept-Charset': 'utf-8',
      'openapikey': '721407f393e84a28593374cc2b347a98',
      'Content-Type': 'application/json',
      'Cookie': 'WMONID=ma4qxIiSOPs'
    };
    var url = Uri.parse(URL);
    response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      xml2Json.parse(response.body);
      jsonString = xml2Json.toParker();
      return jsonString;
    } else {
      return "Error";
    }
  } catch (e) {
    return e.toString();
  }
}
