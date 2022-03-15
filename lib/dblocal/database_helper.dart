import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tokoku/model/product_detail_model.dart';
import 'package:tokoku/model/product_model.dart';
import 'package:tokoku/servis/product_servis.dart';

class DbHelper {
  Database db;
  static const NEW_DB_VERSION = 1;

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "toko.db");
    print(path);
    var exists = await databaseExists(path);

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    int _firstInstall = _preferences.getInt("firstInstall");
    if (_firstInstall == null) {
      _preferences.setInt("firstInstall", 1);
    }

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print("error di db helper '${e.toString()}");
      }
      _createTable();
      // Copy from asset
      ByteData data = await rootBundle.load("assets/toko.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
      //open the newly created db
      db = await openDatabase(path, version: NEW_DB_VERSION);
    } else {
      print("Database exist");
      var databasesPath = await getDatabasesPath();
      var path = join(databasesPath, "toko.db");
      db = await openDatabase(path);
      int _dbVesrion = await db.getVersion();
      print("check db version $_dbVesrion");
    }
  }

  List<ProductElement> productElement = [];
  List<ProductElement> finalProductElement = [];
  List<ProductDetail> productDetail = [];

  initDataOffline() async {
    final ServisTokoKu servisTokoKu = ServisTokoKu();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var paramHeader = await getCountHeader();

      for (var i = 1; i <= 4; i++) {
        productElement = await servisTokoKu.getListProduct(i);
        print(productElement.length);
        finalProductElement.addAll(productElement);
      }
      if (finalProductElement.length != paramHeader) {
        for (var item in finalProductElement) {
          var reslut = await servisTokoKu.getListDetail(item.prdNo);
          var paramHeader = productElemetToJson(item);
          var paramDetail = productDetailToJson(reslut);
          await insertProduct(jsonDecode(paramHeader));
          reslut.toJson().forEach((k, v) =>
              productDetail.add(ProductDetail(product: reslut.product)));
          await insertProductDetail(jsonDecode(paramDetail));
        }
      } else {

      }
    }
  }

  _createTable() async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);
    db.rawQuery("CREATE TABLE IF NOT EXISTS tbl_Checkout (	id	INTEGER , "
        "idProduct INTEGER,namaProduct TEXT, hargaProduct INTEGER , urlImage TEXT"
        " , PRIMARY KEY(id AUTOINCREMENT));");
  }

  Future getProduct() async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);

    var result = await db.rawQuery("SELECT * FROM tbl_product");
    var data = jsonEncode(result);
    return data;
  }

  Future getProductDetail() async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);

    var result = await db.rawQuery("SELECT * FROM tbl_product_detail");
    var data = jsonEncode(result);
    return data;
  }

  Future getProductDetailById(param) async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);

    var result = await db
        .rawQuery("SELECT * FROM tbl_product_detail where prdNo = '$param' ");
    var data = jsonEncode(result);
    return data;
  }

  Future insertCheckout(idProduct, namaProduct, hargaProduct, urlImage) async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);

    db.rawQuery("CREATE TABLE IF NOT EXISTS tbl_Checkout (	id	INTEGER , "
        "idProduct INTEGER,namaProduct TEXT, hargaProduct INTEGER , urlImage TEXT"
        " , PRIMARY KEY(id AUTOINCREMENT));");

    await db.rawQuery(
        "INSERT INTO tbl_Checkout (idProduct, namaProduct , hargaProduct,urlImage )"
        "values('$idProduct','$namaProduct','$hargaProduct','$urlImage')");

    int count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT count(*) FROM tbl_Checkout where idProduct = '$idProduct' "));
    if (count == 0) {
      return "Error";
    } else {
      return "Berhasil";
    }
    // var data = jsonEncode(result);
    // return data;
  }

  Future getCheckout() async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);

    var result = await db.rawQuery("SELECT * FROM tbl_Checkout");
    var data = jsonEncode(result);
    return data;
  }

  Future deleteCheckout(idProduct) async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);

    await db.rawQuery("DELETE from tbl_Checkout where id = '$idProduct'");

    var result = await db.rawQuery("SELECT * FROM tbl_Checkout");

    var data = jsonEncode(result);
    return data;
  }

  Future deleteAll() async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);

    db.rawQuery("CREATE TABLE IF NOT EXISTS tbl_Checkout (	id	INTEGER , "
        "idProduct INTEGER,namaProduct TEXT, hargaProduct INTEGER , urlImage TEXT"
        " , PRIMARY KEY(id AUTOINCREMENT));");

    await db.rawQuery("DELETE from tbl_Checkout");

    int count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT count(*) FROM tbl_Checkout"));
    return count;
  }

  Future insertProduct(value) async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);

    db.rawQuery("CREATE TABLE IF NOT EXISTS tbl_product (	id	INTEGER , "
        "bndlDlvCnYn TEXT, cuponcheck TEXT, dispCtgrNo INTEGER, dispCtgrStatCd INTEGER, exchDlvCst INTEGER, imageKindChk INTEGER,"
        "optionAllAddPrc INTEGER,outsideYnIn TEXT, outsideYnOut TEXT, prdAttrCd TEXT, prdNm TEXT, prdNo INTEGER, prdSelQty INTEGER, prdUpdYn TEXT, "
        "preSelPrc INTEGER, proxyYn TEXT,"
        " rtngdDlvCst INTEGER, saleEndDate TEXT, saleStartDate TEXT, selLimitPersonType TEXT, selMnbdNckNm TEXT, selMthdCd INTEGER, selPrc INTEGER,"
        " selPrdClfCd TEXT, selStatCd INTEGER, selTermUseYn TEXT, sellerItemEventYn TEXT, sellerPrdCd TEXT, shopNo INTEGER, tmpltSeq INTEGER, validateMsg TEXT,"
        "nResult INTEGER,dispCtgrNm TEXT,dispCtgrNmMid TEXT,dispCtgrNmRoot TEXT,dscAmt INTEGER,dscPrice INTEGER,freeDelivery INTEGER,productOptionDetails TEXT,"
        "dispCtgrNo1 INTEGER,stock INTEGER"
        " , PRIMARY KEY(id AUTOINCREMENT));");

    int count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT count(*) FROM tbl_product where prdno = '${value['prdNo']}' "));
    if (count == 0) {
      await db.rawQuery(
          "INSERT INTO tbl_product (bndlDlvCnYn, cuponcheck, dispCtgrNo, dispCtgrStatCd, exchDlvCst, imageKindChk, optionAllAddPrc, outsideYnIn, outsideYnOut, prdAttrCd, prdNm, prdNo, "
          "prdSelQty, prdUpdYn, preSelPrc, proxyYn, rtngdDlvCst, saleEndDate, saleStartDate, selLimitPersonType, selMnbdNckNm, selMthdCd, selPrc, selPrdClfCd, selStatCd, selTermUseYn, "
          "sellerItemEventYn, sellerPrdCd, shopNo, tmpltSeq, validateMsg, nResult, dispCtgrNm, dispCtgrNmMid, dispCtgrNmRoot, dscAmt, dscPrice, freeDelivery, productOptionDetails, dispCtgrNo1, "
          "stock) "
          "values('${value['bndlDlvCnYn']}', '${value['cuponcheck']}', '${value['dispCtgrNo']}', '${value['dispCtgrStatCd']}', '${value['exchDlvCst']}', '${value['imageKindChk']}',"
          " '${value['optionAllAddPrc']}','${value['outsideYnIn']}','${value['outsideYnOut']}','${value['prdAttrCd']}','${value['prdNm']}','${value['prdNo']}','${value['prdSelQty']}',"
          "'${value['prdUpdYn']}','${value['preSelPrc']}','${value['proxyYn']}','${value['rtngdDlvCst']}','${value['saleEndDate']}','${value['saleStartDate']}','${value['selLimitPersonType']}',"
          "'${value['selMnbdNckNm']}','${value['selMthdCd']}','${value['selPrc']}','${value['selPrdClfCd']}','${value['selStatCd']}','${value['selTermUseYn']}','${value['sellerItemEventYn']}',"
          "'${value['sellerPrdCd']}','${value['shopNo']}','${value['tmpltSeq']}','${value['validateMsg']}','${value['nResult']}','${value['dispCtgrNm']}','${value['dispCtgrNmMid']}',"
          "'${value['dispCtgrNmRoot'].toString().replaceAll("'", " ")}',"
          "'${value['dscAmt']}','${value['dscPrice']}','${value['freeDelivery']}','${value['productOptionDetails']}','${value['dispCtgrNo1']}','${value['stock']}')");
    }

    var result = await db.rawQuery("SELECT * FROM tbl_product");
    return result;
  }

  Future getCountHeader() async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);

    db.rawQuery("CREATE TABLE IF NOT EXISTS tbl_product (	id	INTEGER , "
        "bndlDlvCnYn TEXT, cuponcheck TEXT, dispCtgrNo INTEGER, dispCtgrStatCd INTEGER, exchDlvCst INTEGER, imageKindChk INTEGER,"
        "optionAllAddPrc INTEGER,outsideYnIn TEXT, outsideYnOut TEXT, prdAttrCd TEXT, prdNm TEXT, prdNo INTEGER, prdSelQty INTEGER, prdUpdYn TEXT, "
        "preSelPrc INTEGER, proxyYn TEXT,"
        " rtngdDlvCst INTEGER, saleEndDate TEXT, saleStartDate TEXT, selLimitPersonType TEXT, selMnbdNckNm TEXT, selMthdCd INTEGER, selPrc INTEGER,"
        " selPrdClfCd TEXT, selStatCd INTEGER, selTermUseYn TEXT, sellerItemEventYn TEXT, sellerPrdCd TEXT, shopNo INTEGER, tmpltSeq INTEGER, validateMsg TEXT,"
        "nResult INTEGER,dispCtgrNm TEXT,dispCtgrNmMid TEXT,dispCtgrNmRoot TEXT,dscAmt INTEGER,dscPrice INTEGER,freeDelivery INTEGER,productOptionDetails TEXT,"
        "dispCtgrNo1 INTEGER,stock INTEGER"
        " , PRIMARY KEY(id AUTOINCREMENT));");

    int count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT count(*) FROM tbl_product "));
    return count;
  }

  Future getCountDetail() async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);

    db.rawQuery("CREATE TABLE IF NOT EXISTS tbl_product_detail (	id	INTEGER , "
        "abrdBrandYn TEXT, abrdCnDlvCst INTEGER, asDetail TEXT, bndlDlvCnYn TEXT, chinaSaleYn TEXT, chinaSelPrc INTEGER, cupnDscMthdCd INTEGER, "
        "cuponcheck TEXT, dispCtgrNo INTEGER, dispCtgrStatCd INTEGER, displayYn TEXT, dlvBasiAmt INTEGER, dlvClf INTEGER, dlvCnAreaCd INTEGER, "
        "dlvCstInstBasiCd INTEGER, dlvCstPayTypCd INTEGER, dlvGrntYn TEXT, dlvWyCd INTEGER, dscAmtPercnt INTEGER, exchDlvCst INTEGER, htmlDetail TEXT, "
        "imageKindChk INTEGER, islandDlvCst INTEGER, jejuDlvCst INTEGER, memberNo INTEGER, minorSelCnYn TEXT, mobile1WonYn TEXT, mstrPrdNo INTEGER, "
        "optionAllAddPrc INTEGER, orgnTypCd INTEGER, outsideYnIn TEXT, outsideYnOut TEXT, paidSelPrc INTEGER, prcCmpExpYn TEXT, prdAttrCd TEXT, "
        "prdImage01 TEXT, prdImage02 TEXT, prdImage03 TEXT, prdImage04 TEXT, prdNm TEXT, prdNo INTEGER, prdSelQty INTEGER, prdStatCd INTEGER, "
        "prdTypCd INTEGER, prdUpdYn TEXT, prdWght INTEGER, preSelPrc INTEGER, proxyYn TEXT, reviewDispYn TEXT, reviewOptDispYn TEXT, rtngExchDetail TEXT,"
        " rtngdDlvCst INTEGER, selLimitPersonType TEXT, selLimitQty INTEGER, selLimitTypCd INTEGER, selMinLimitQty INTEGER, selMinLimitTypCd INTEGER, "
        "selMnbdNckNm TEXT, selMthdCd INTEGER, selPrc INTEGER, selPrdClfCd INTEGER, selStatCd INTEGER, selStatNm TEXT, selTermUseYn TEXT, "
        "sellerItemEventYn TEXT, sellerPrdCd TEXT, shopNo INTEGER, suplDtyfrPrdClfCd INTEGER, tmpltSeq INTEGER, useGiftYn TEXT, useMon INTEGER, "
        "validateMsg TEXT, nResult INTEGER, createDt TEXT, dispCtgrNm TEXT, dispCtgrNmMid TEXT, dispCtgrNmRoot TEXT, dscAmt INTEGER, "
        "dscPrice INTEGER, freeDelivery INTEGER, dispCtgrNo2 INTEGER, dispCtgrNo1 INTEGER, stock INTEGER, updateDt TEXT "
        " , PRIMARY KEY(id AUTOINCREMENT));");

    int count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT count(*) FROM tbl_product_detail "));
    return count;
  }

  Future insertProductDetail(param) async {
    var _databasePath = await getDatabasesPath();
    var _path = join(_databasePath, "toko.db");
    db = await openDatabase(_path);
    var value = param['Product'];
    db.rawQuery("CREATE TABLE IF NOT EXISTS tbl_product_detail (	id	INTEGER , "
        "abrdBrandYn TEXT, abrdCnDlvCst INTEGER, asDetail TEXT, bndlDlvCnYn TEXT, chinaSaleYn TEXT, chinaSelPrc INTEGER, cupnDscMthdCd INTEGER, "
        "cuponcheck TEXT, dispCtgrNo INTEGER, dispCtgrStatCd INTEGER, displayYn TEXT, dlvBasiAmt INTEGER, dlvClf INTEGER, dlvCnAreaCd INTEGER, "
        "dlvCstInstBasiCd INTEGER, dlvCstPayTypCd INTEGER, dlvGrntYn TEXT, dlvWyCd INTEGER, dscAmtPercnt INTEGER, exchDlvCst INTEGER, htmlDetail TEXT, "
        "imageKindChk INTEGER, islandDlvCst INTEGER, jejuDlvCst INTEGER, memberNo INTEGER, minorSelCnYn TEXT, mobile1WonYn TEXT, mstrPrdNo INTEGER, "
        "optionAllAddPrc INTEGER, orgnTypCd INTEGER, outsideYnIn TEXT, outsideYnOut TEXT, paidSelPrc INTEGER, prcCmpExpYn TEXT, prdAttrCd TEXT, "
        "prdImage01 TEXT, prdImage02 TEXT, prdImage03 TEXT, prdImage04 TEXT, prdNm TEXT, prdNo INTEGER, prdSelQty INTEGER, prdStatCd INTEGER, "
        "prdTypCd INTEGER, prdUpdYn TEXT, prdWght INTEGER, preSelPrc INTEGER, proxyYn TEXT, reviewDispYn TEXT, reviewOptDispYn TEXT, rtngExchDetail TEXT,"
        " rtngdDlvCst INTEGER, selLimitPersonType TEXT, selLimitQty INTEGER, selLimitTypCd INTEGER, selMinLimitQty INTEGER, selMinLimitTypCd INTEGER, "
        "selMnbdNckNm TEXT, selMthdCd INTEGER, selPrc INTEGER, selPrdClfCd INTEGER, selStatCd INTEGER, selStatNm TEXT, selTermUseYn TEXT, "
        "sellerItemEventYn TEXT, sellerPrdCd TEXT, shopNo INTEGER, suplDtyfrPrdClfCd INTEGER, tmpltSeq INTEGER, useGiftYn TEXT, useMon INTEGER, "
        "validateMsg TEXT, nResult INTEGER, createDt TEXT, dispCtgrNm TEXT, dispCtgrNmMid TEXT, dispCtgrNmRoot TEXT, dscAmt INTEGER, "
        "dscPrice INTEGER, freeDelivery INTEGER, dispCtgrNo2 INTEGER, dispCtgrNo1 INTEGER, stock INTEGER, updateDt TEXT "
        " , PRIMARY KEY(id AUTOINCREMENT));");

    int count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT count(*) FROM tbl_product_detail where prdno = '${value['prdNo']}' "));
    if (count == 0) {
      await db.rawQuery(
          "INSERT INTO tbl_product_detail (abrdBrandYn, abrdCnDlvCst, asDetail, bndlDlvCnYn, chinaSaleYn, chinaSelPrc, cupnDscMthdCd, cuponcheck, "
          "dispCtgrNo, dispCtgrStatCd, displayYn, dlvBasiAmt, dlvClf, dlvCnAreaCd, dlvCstInstBasiCd, dlvCstPayTypCd, dlvGrntYn, dlvWyCd, "
          "dscAmtPercnt, exchDlvCst, htmlDetail, imageKindChk, islandDlvCst, jejuDlvCst, memberNo, minorSelCnYn, mobile1WonYn, mstrPrdNo, "
          "optionAllAddPrc, orgnTypCd, outsideYnIn, outsideYnOut, paidSelPrc, prcCmpExpYn, prdAttrCd, prdImage01, prdImage02, prdImage03, "
          "prdImage04, prdNm, prdNo, prdSelQty, prdStatCd, prdTypCd, prdUpdYn, prdWght, preSelPrc, proxyYn, reviewDispYn, reviewOptDispYn, "
          "rtngExchDetail, rtngdDlvCst, selLimitPersonType, selLimitQty, selLimitTypCd, selMinLimitQty, selMinLimitTypCd, selMnbdNckNm, "
          "selMthdCd, selPrc, selPrdClfCd, selStatCd, selStatNm, selTermUseYn, sellerItemEventYn, sellerPrdCd, shopNo, suplDtyfrPrdClfCd, "
          "tmpltSeq, useGiftYn, useMon, validateMsg, nResult, createDt, dispCtgrNm, dispCtgrNmMid, dispCtgrNmRoot, dscAmt, dscPrice, "
          "freeDelivery, dispCtgrNo2, dispCtgrNo1, stock, updateDt) "
          "values('${value['abrdBrandYn']}','${value['abrdCnDlvCst']}', '${value['asDetail']}', '${value['bndlDlvCnYn']}', '${value['chinaSaleYn']}',"
          " '${value['chinaSelPrc']}', '${value['cupnDscMthdCd']}', '${value['cuponcheck']}', '${value['dispCtgrNo']}', '${value['dispCtgrStatCd']}', "
          "'${value['displayYn']}', '${value['dlvBasiAmt']}', '${value['dlvClf']}', '${value['dlvCnAreaCd']}', '${value['dlvCstInstBasiCd']}', "
          "'${value['dlvCstPayTypCd']}', '${value['dlvGrntYn']}', '${value['dlvWyCd']}', '${value['dscAmtPercnt']}', '${value['exchDlvCst']}', "
          "'${value['htmlDetail'].toString().replaceAll("'", " ")}', '${value['imageKindChk']}', '${value['islandDlvCst']}', '${value['jejuDlvCst']}', '${value['memberNo']}', "
          "'${value['minorSelCnYn']}', '${value['mobile1WonYn']}', '${value['mstrPrdNo']}', '${value['optionAllAddPrc']}', '${value['orgnTypCd']}', "
          "'${value['outsideYnIn']}', '${value['outsideYnOut']}', '${value['paidSelPrc']}', '${value['prcCmpExpYn']}', '${value['prdAttrCd']}', "
          "'${value['prdImage01']}', '${value['prdImage02']}', '${value['prdImage03']}', '${value['prdImage04']}', '${value['prdNm']}', '${value['prdNo']}', "
          "'${value['prdSelQty']}', '${value['prdStatCd']}', '${value['prdTypCd']}', '${value['prdUpdYn']}', '${value['prdWght']}', '${value['preSelPrc']}', "
          "'${value['proxyYn']}', '${value['reviewDispYn']}', '${value['reviewOptDispYn']}', '${value['rtngExchDetail']}', '${value['rtngdDlvCst']}',"
          " '${value['selLimitPersonType']}', '${value['selLimitQty']}', '${value['selLimitTypCd']}', '${value['selMinLimitQty']}', '${value['selMinLimitTypCd']}', "
          "'${value['selMnbdNckNm']}', '${value['selMthdCd']}', '${value['selPrc']}', '${value['selPrdClfCd']}', '${value['selStatCd']}', '${value['selStatNm']}', "
          "'${value['selTermUseYn']}', '${value['sellerItemEventYn']}', '${value['sellerPrdCd']}', '${value['shopNo']}', '${value['suplDtyfrPrdClfCd']}', "
          "'${value['tmpltSeq']}', '${value['useGiftYn']}', '${value['useMon']}', '${value['validateMsg']}', '${value['nResult']}', '${value['createDt']}', "
          "'${value['dispCtgrNm']}', '${value['dispCtgrNmMid']}', '${value['dispCtgrNmRoot'].toString().replaceAll("'", " ")}', '${value['dscAmt']}', '${value['dscPrice']}', "
          "'${value['freeDelivery']}', '${value['dispCtgrNo2']}', '${value['dispCtgrNo1']}', '${value['stock']}', '${value['updateDt']}')");
    }

    var result = await db.rawQuery("SELECT * FROM tbl_product_detail");
    return result;
  }
}
