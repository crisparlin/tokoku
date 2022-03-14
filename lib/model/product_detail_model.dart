import 'dart:convert';

ProductDetail productDetailFromJson(String str) =>
    ProductDetail.fromJson(json.decode(str));

List<ProductDetail> productListDetailFromJson(String str) => List<ProductDetail>.from(json.decode(str).map((x) => ProductDetail.fromJson(x)));

List<Product> productListFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

Product productFromJson(String str) =>
    Product.fromJson(json.decode(str));

String productListDetailToJson(List<ProductDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
  ProductDetail({
    this.product,
  });

  Product product;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        product: Product.fromJson(json["Product"]),
      );

  Map<String, dynamic> toJson() => {
        "Product": product.toJson(),
      };
}

class Product {
  Product({
    this.abrdBrandYn,
    this.abrdCnDlvCst,
    this.asDetail,
    this.bndlDlvCnYn,
    this.chinaSaleYn,
    this.chinaSelPrc,
    this.cupnDscMthdCd,
    this.cuponcheck,
    this.dispCtgrNo,
    this.dispCtgrStatCd,
    this.displayYn,
    this.dlvBasiAmt,
    this.dlvClf,
    this.dlvCnAreaCd,
    this.dlvCstInstBasiCd,
    this.dlvCstPayTypCd,
    this.dlvGrntYn,
    this.dlvWyCd,
    this.dscAmtPercnt,
    this.exchDlvCst,
    this.htmlDetail,
    this.imageKindChk,
    this.islandDlvCst,
    this.jejuDlvCst,
    this.memberNo,
    this.minorSelCnYn,
    this.mobile1WonYn,
    this.mstrPrdNo,
    this.optionAllAddPrc,
    this.orgnTypCd,
    this.outsideYnIn,
    this.outsideYnOut,
    this.paidSelPrc,
    this.prcCmpExpYn,
    this.prdAttrCd,
    this.prdImage01,
    this.prdImage02,
    this.prdImage03,
    this.prdImage04,
    this.prdNm,
    this.prdNo,
    this.prdSelQty,
    this.prdStatCd,
    this.prdTypCd,
    this.prdUpdYn,
    this.prdWght,
    this.preSelPrc,
    this.proxyYn,
    this.reviewDispYn,
    this.reviewOptDispYn,
    this.rtngExchDetail,
    this.rtngdDlvCst,
    this.selLimitPersonType,
    this.selLimitQty,
    this.selLimitTypCd,
    this.selMinLimitQty,
    this.selMinLimitTypCd,
    this.selMnbdNckNm,
    this.selMthdCd,
    this.selPrc,
    this.selPrdClfCd,
    this.selStatCd,
    this.selStatNm,
    this.selTermUseYn,
    this.sellerItemEventYn,
    this.sellerPrdCd,
    this.shopNo,
    this.suplDtyfrPrdClfCd,
    this.tmpltSeq,
    this.useGiftYn,
    this.useMon,
    this.validateMsg,
    this.nResult,
    this.createDt,
    this.dispCtgrNm,
    this.dispCtgrNmMid,
    this.dispCtgrNmRoot,
    this.dscAmt,
    this.dscPrice,
    this.freeDelivery,
    this.dispCtgrNo2,
    this.dispCtgrNo1,
    this.stock,
    this.updateDt,
  });

  String abrdBrandYn;
  int abrdCnDlvCst;
  String asDetail;
  String bndlDlvCnYn;
  String chinaSaleYn;
  int chinaSelPrc;
  int cupnDscMthdCd;
  String cuponcheck;
  int dispCtgrNo;
  int dispCtgrStatCd;
  String displayYn;
  int dlvBasiAmt;
  int dlvClf;
  int dlvCnAreaCd;
  int dlvCstInstBasiCd;
  int dlvCstPayTypCd;
  String dlvGrntYn;
  int dlvWyCd;
  int dscAmtPercnt;
  int exchDlvCst;
  String htmlDetail;
  int imageKindChk;
  int islandDlvCst;
  int jejuDlvCst;
  int memberNo;
  String minorSelCnYn;
  String mobile1WonYn;
  int mstrPrdNo;
  int optionAllAddPrc;
  int orgnTypCd;
  String outsideYnIn;
  String outsideYnOut;
  int paidSelPrc;
  String prcCmpExpYn;
  String prdAttrCd;
  String prdImage01;
  String prdImage02;
  String prdImage03;
  String prdImage04;
  String prdNm;
  int prdNo;
  int prdSelQty;
  int prdStatCd;
  int prdTypCd;
  String prdUpdYn;
  int prdWght;
  int preSelPrc;
  String proxyYn;
  String reviewDispYn;
  String reviewOptDispYn;
  String rtngExchDetail;
  int rtngdDlvCst;
  String selLimitPersonType;
  int selLimitQty;
  int selLimitTypCd;
  int selMinLimitQty;
  int selMinLimitTypCd;
  String selMnbdNckNm;
  int selMthdCd;
  int selPrc;
  int selPrdClfCd;
  int selStatCd;
  String selStatNm;
  String selTermUseYn;
  String sellerItemEventYn;
  String sellerPrdCd;
  int shopNo;
  int suplDtyfrPrdClfCd;
  int tmpltSeq;
  String useGiftYn;
  int useMon;
  String validateMsg;
  int nResult;
  DateTime createDt;
  String dispCtgrNm;
  String dispCtgrNmMid;
  String dispCtgrNmRoot;
  int dscAmt;
  int dscPrice;
  int freeDelivery;
  int dispCtgrNo2;
  int dispCtgrNo1;
  int stock;
  DateTime updateDt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        abrdBrandYn: json["abrdBrandYn"].toString(),
        abrdCnDlvCst: int.parse(json["abrdCnDlvCst"].toString()),
        asDetail: json["asDetail"].toString(),
        bndlDlvCnYn: json["bndlDlvCnYn"].toString(),
        chinaSaleYn: json["chinaSaleYn"],
        chinaSelPrc: int.parse(json["chinaSelPrc"].toString()),
        cupnDscMthdCd: int.parse(json["cupnDscMthdCd"].toString()),
        cuponcheck: json["cuponcheck"],
        dispCtgrNo: int.parse(json["dispCtgrNo"].toString()),
        dispCtgrStatCd: int.parse(json["dispCtgrStatCd"].toString()),
        displayYn: json["displayYn"],
        dlvBasiAmt: int.parse(json["dlvBasiAmt"].toString()),
        dlvClf: int.parse(json["dlvClf"].toString()),
        dlvCnAreaCd: int.parse(json["dlvCnAreaCd"].toString()),
        dlvCstInstBasiCd: int.parse(json["dlvCstInstBasiCd"].toString()),
        dlvCstPayTypCd: int.parse(json["dlvCstPayTypCd"].toString()),
        dlvGrntYn: json["dlvGrntYn"],
        dlvWyCd: int.parse(json["dlvWyCd"].toString()),
        dscAmtPercnt: int.parse(json["dscAmtPercnt"].toString()),
        exchDlvCst: int.parse(json["exchDlvCst"].toString()),
        htmlDetail: json["htmlDetail"],
        imageKindChk: int.parse(json["imageKindChk"].toString()),
        islandDlvCst: int.parse(json["islandDlvCst"].toString()),
        jejuDlvCst: int.parse(json["jejuDlvCst"].toString()),
        memberNo: int.parse(json["memberNo"].toString()),
        minorSelCnYn: json["minorSelCnYn"],
        mobile1WonYn: json["mobile1WonYn"],
        mstrPrdNo: int.parse(json["mstrPrdNo"].toString()),
        optionAllAddPrc: int.parse(json["optionAllAddPrc"].toString()),
        orgnTypCd: int.parse(json["orgnTypCd"].toString()),
        outsideYnIn: json["outsideYnIn"],
        outsideYnOut: json["outsideYnOut"],
        paidSelPrc: int.parse(json["paidSelPrc"].toString()),
        prcCmpExpYn: json["prcCmpExpYn"],
        prdAttrCd: json["prdAttrCd"],
        prdImage01: json["prdImage01"],
        prdImage02: json["prdImage02"],
        prdImage03: json["prdImage03"],
        prdImage04: json["prdImage04"],
        prdNm: json["prdNm"],
        prdNo: int.parse(json["prdNo"].toString()),
        prdSelQty: int.parse(json["prdSelQty"].toString()),
        prdStatCd: int.parse(json["prdStatCd"].toString()),
        prdTypCd: int.parse(json["prdTypCd"].toString()),
        prdUpdYn: json["prdUpdYN"],
        prdWght: int.parse(json["prdWght"].toString()),
        preSelPrc: int.parse(json["preSelPrc"].toString()),
        proxyYn: json["proxyYn"],
        reviewDispYn: json["reviewDispYn"],
        reviewOptDispYn: json["reviewOptDispYn"],
        rtngExchDetail: json["rtngExchDetail"],
        rtngdDlvCst: int.parse(json["rtngdDlvCst"].toString()),
        selLimitPersonType: json["selLimitPersonType"],
        selLimitQty: int.parse(json["selLimitQty"].toString()),
        selLimitTypCd: int.parse(json["selLimitTypCd"].toString()),
        selMinLimitQty: int.parse(json["selMinLimitQty"].toString()),
        selMinLimitTypCd: int.parse(json["selMinLimitTypCd"].toString()),
        selMnbdNckNm: json["selMnbdNckNm"],
        selMthdCd: int.parse(json["selMthdCd"].toString()),
        selPrc: int.parse(json["selPrc"].toString()),
        selPrdClfCd: int.parse(json["selPrdClfCd"].toString()),
        selStatCd: int.parse(json["selStatCd"].toString()),
        selStatNm: json["selStatNm"],
        selTermUseYn: json["selTermUseYn"],
        sellerItemEventYn: json["sellerItemEventYn"],
        sellerPrdCd: json["sellerPrdCd"],
        shopNo: int.parse(json["shopNo"].toString()),
        suplDtyfrPrdClfCd: int.parse(json["suplDtyfrPrdClfCd"].toString()),
        tmpltSeq: int.parse(json["tmpltSeq"].toString()),
        useGiftYn: json["useGiftYn"],
        useMon: int.parse(json["useMon"].toString()),
        validateMsg: json["validateMsg"],
        nResult: int.parse(json["nResult"].toString()),
        createDt: DateTime.parse(json["createDt"]),
        dispCtgrNm: json["dispCtgrNm"],
        dispCtgrNmMid: json["dispCtgrNmMid"],
        dispCtgrNmRoot: json["dispCtgrNmRoot"],
        dscAmt: int.parse(json["dscAmt"].toString()),
        dscPrice: int.parse(json["dscPrice"].toString()),
        freeDelivery: int.parse(json["freeDelivery"].toString()),
        dispCtgrNo2: int.parse(json["dispCtgrNo2"].toString()),
        dispCtgrNo1: int.parse(json["dispCtgrNo1"].toString()),
        stock: int.parse(json["stock"].toString()),
        updateDt: DateTime.parse(json["updateDt"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "abrdBrandYn": abrdBrandYn,
        "abrdCnDlvCst": abrdCnDlvCst,
        "asDetail": asDetail,
        "bndlDlvCnYn": bndlDlvCnYn,
        "chinaSaleYn": chinaSaleYn,
        "chinaSelPrc": chinaSelPrc,
        "cupnDscMthdCd": cupnDscMthdCd,
        "cuponcheck": cuponcheck,
        "dispCtgrNo": dispCtgrNo,
        "dispCtgrStatCd": dispCtgrStatCd,
        "displayYn": displayYn,
        "dlvBasiAmt": dlvBasiAmt,
        "dlvClf": dlvClf,
        "dlvCnAreaCd": dlvCnAreaCd,
        "dlvCstInstBasiCd": dlvCstInstBasiCd,
        "dlvCstPayTypCd": dlvCstPayTypCd,
        "dlvGrntYn": dlvGrntYn,
        "dlvWyCd": dlvWyCd,
        "dscAmtPercnt": dscAmtPercnt,
        "exchDlvCst": exchDlvCst,
        "htmlDetail": htmlDetail,
        "imageKindChk": imageKindChk,
        "islandDlvCst": islandDlvCst,
        "jejuDlvCst": jejuDlvCst,
        "memberNo": memberNo,
        "minorSelCnYn": minorSelCnYn,
        "mobile1WonYn": mobile1WonYn,
        "mstrPrdNo": mstrPrdNo,
        "optionAllAddPrc": optionAllAddPrc,
        "orgnTypCd": orgnTypCd,
        "outsideYnIn": outsideYnIn,
        "outsideYnOut": outsideYnOut,
        "paidSelPrc": paidSelPrc,
        "prcCmpExpYn": prcCmpExpYn,
        "prdAttrCd": prdAttrCd,
        "prdImage01": prdImage01,
        "prdImage02": prdImage02,
        "prdImage03": prdImage03,
        "prdImage04": prdImage04,
        "prdNm": prdNm,
        "prdNo": prdNo,
        "prdSelQty": prdSelQty,
        "prdStatCd": prdStatCd,
        "prdTypCd": prdTypCd,
        "prdUpdYN": prdUpdYn,
        "prdWght": prdWght,
        "preSelPrc": preSelPrc,
        "proxyYn": proxyYn,
        "reviewDispYn": reviewDispYn,
        "reviewOptDispYn": reviewOptDispYn,
        "rtngExchDetail": rtngExchDetail,
        "rtngdDlvCst": rtngdDlvCst,
        "selLimitPersonType": selLimitPersonType,
        "selLimitQty": selLimitQty,
        "selLimitTypCd": selLimitTypCd,
        "selMinLimitQty": selMinLimitQty,
        "selMinLimitTypCd": selMinLimitTypCd,
        "selMnbdNckNm": selMnbdNckNm,
        "selMthdCd": selMthdCd,
        "selPrc": selPrc,
        "selPrdClfCd": selPrdClfCd,
        "selStatCd": selStatCd,
        "selStatNm": selStatNm,
        "selTermUseYn": selTermUseYn,
        "sellerItemEventYn": sellerItemEventYn,
        "sellerPrdCd": sellerPrdCd,
        "shopNo": shopNo,
        "suplDtyfrPrdClfCd": suplDtyfrPrdClfCd,
        "tmpltSeq": tmpltSeq,
        "useGiftYn": useGiftYn,
        "useMon": useMon,
        "validateMsg": validateMsg,
        "nResult": nResult,
        "createDt": createDt.toIso8601String(),
        "dispCtgrNm": dispCtgrNm,
        "dispCtgrNmMid": dispCtgrNmMid,
        "dispCtgrNmRoot": dispCtgrNmRoot,
        "dscAmt": dscAmt,
        "dscPrice": dscPrice,
        "freeDelivery": freeDelivery,
        "dispCtgrNo2": dispCtgrNo2,
        "dispCtgrNo1": dispCtgrNo1,
        "stock": stock,
        "updateDt": updateDt.toIso8601String(),
      };
}

class ProductCtgrAttribute {
  ProductCtgrAttribute({
    this.prdAttrNm,
    this.prdAttrNo,
  });

  String prdAttrNm;
  int prdAttrNo;

  factory ProductCtgrAttribute.fromJson(Map<String, dynamic> json) =>
      ProductCtgrAttribute(
        prdAttrNm: json["prdAttrNm"],
        prdAttrNo: int.parse(json["prdAttrNo"]),
      );

  Map<String, dynamic> toJson() => {
        "prdAttrNm": prdAttrNm,
        "prdAttrNo": prdAttrNo,
      };
}

class ProductOptionDetails {
  ProductOptionDetails({
    this.addPrc,
    this.colCount,
    this.colOptPrice,
    this.optWght,
    this.selQty,
    this.sellerPrdOptCd,
    this.stckQty,
    this.stockNo,
    this.useYn,
  });

  int addPrc;
  int colCount;
  int colOptPrice;
  int optWght;
  int selQty;
  String sellerPrdOptCd;
  int stckQty;
  int stockNo;
  String useYn;

  factory ProductOptionDetails.fromJson(Map<String, dynamic> json) =>
      ProductOptionDetails(
        addPrc: int.parse(json["addPrc"]),
        colCount: int.parse(json["colCount"]),
        colOptPrice: int.parse(json["colOptPrice"]),
        optWght: int.parse(json["optWght"]),
        selQty: int.parse(json["selQty"]),
        sellerPrdOptCd: json["sellerPrdOptCd"],
        stckQty: int.parse(json["stckQty"]),
        stockNo: int.parse(json["stockNo"]),
        useYn: json["useYn"],
      );

  Map<String, dynamic> toJson() => {
        "addPrc": addPrc,
        "colCount": colCount,
        "colOptPrice": colOptPrice,
        "optWght": optWght,
        "selQty": selQty,
        "sellerPrdOptCd": sellerPrdOptCd,
        "stckQty": stckQty,
        "stockNo": stockNo,
        "useYn": useYn,
      };
}
