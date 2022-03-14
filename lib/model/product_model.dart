import 'dart:convert';

ProductCatalog productCatalogFromJson(String str) => ProductCatalog.fromJson(json.decode(str));

List<ProductElement> productElementFromJson(String str) => List<ProductElement>.from(json.decode(str).map((x) => ProductElement.fromJson(x)));

String productToJson(ProductCatalog data) => json.encode(data.toJson());

String productElemetToJson(ProductElement data) => json.encode(data.toJson());

class ProductCatalog {
  ProductCatalog({
     this.products,
  });

  Products products;

  factory ProductCatalog.fromJson(Map<String, dynamic> json) => ProductCatalog(
        products: Products.fromJson(json["Products"]),
      );

  Map<String, dynamic> toJson() => {
        "Products": products.toJson(),
      };
}

class Products {
  Products({
     this.product,
  });

  List<ProductElement> product;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        product: List<ProductElement>.from(
            json["product"].map((x) => ProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class ProductElement {
  ProductElement({
    this.bndlDlvCnYn,
    this.cuponcheck,
    this.dispCtgrNo,
     this.dispCtgrStatCd,
     this.exchDlvCst,
     this.imageKindChk,
     this.optionAllAddPrc,
     this.outsideYnIn,
     this.outsideYnOut,
     this.prdAttrCd,
     this.prdNm,
     this.prdNo,
     this.prdSelQty,
     this.prdUpdYn,
     this.preSelPrc,
     this.proxyYn,
     this.rtngdDlvCst,
     this.saleEndDate,
     this.saleStartDate,
     this.selLimitPersonType,
     this.selMnbdNckNm,
     this.selMthdCd,
     this.selPrc,
     this.selPrdClfCd,
     this.selStatCd,
     this.selTermUseYn,
     this.sellerItemEventYn,
     this.sellerPrdCd,
     this.shopNo,
     this.tmpltSeq,
     this.validateMsg,
     this.nResult,
     this.dispCtgrNm,
     this.dispCtgrNmMid,
     this.dispCtgrNmRoot,
     this.dscAmt,
     this.dscPrice,
     this.freeDelivery,
    this.productOptionDetails,
     this.dispCtgrNo1,
     this.stock,
  });

  String bndlDlvCnYn;
  String cuponcheck;
  int dispCtgrNo;
  int dispCtgrStatCd;
  int exchDlvCst;
  int imageKindChk;
  int optionAllAddPrc;
  String outsideYnIn;
  String outsideYnOut;
  String prdAttrCd;
  String prdNm;
  int prdNo;
  int prdSelQty;
  String prdUpdYn;
  int preSelPrc;
  String proxyYn;
  int rtngdDlvCst;
  String saleEndDate;
  String saleStartDate;
  String selLimitPersonType;
  String selMnbdNckNm;
  int selMthdCd;
  int selPrc;
  String selPrdClfCd;
  int selStatCd;
  String selTermUseYn;
  String sellerItemEventYn;
  dynamic sellerPrdCd;
  int shopNo;
  int tmpltSeq;
  String validateMsg;
  int nResult;
  String dispCtgrNm;
  String dispCtgrNmMid;
  String dispCtgrNmRoot;
  int dscAmt;
  int dscPrice;
  int freeDelivery;
  dynamic productOptionDetails;
  int dispCtgrNo1;
  int stock;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        bndlDlvCnYn: json["bndlDlvCnYn"],
        cuponcheck: json["cuponcheck"],
        dispCtgrNo: int.parse(json["dispCtgrNo"].toString()),
        dispCtgrStatCd: int.parse(json["dispCtgrStatCd"].toString()),
        exchDlvCst: int.parse(json["exchDlvCst"].toString()),
        imageKindChk: int.parse(json["imageKindChk"].toString()),
        optionAllAddPrc: int.parse(json["optionAllAddPrc"].toString()),
        outsideYnIn: json["outsideYnIn"],
        outsideYnOut: json["outsideYnOut"],
        prdAttrCd: json["prdAttrCd"] == "" ? "-" : json["prdAttrCd"],
        prdNm: json["prdNm"],
        prdNo: int.parse(json["prdNo"].toString()),
        prdSelQty: int.parse(json["prdSelQty"].toString()),
        prdUpdYn: json["prdUpdYN"],
        preSelPrc: int.parse(json["preSelPrc"].toString()),
        proxyYn: json["proxyYn"],
        rtngdDlvCst: int.parse(json["rtngdDlvCst"].toString()),
        saleEndDate: json["saleEndDate"],
        saleStartDate: json["saleStartDate"],
        selLimitPersonType: json["selLimitPersonType"] == "" ? "-" : json["selLimitPersonType"],
        selMnbdNckNm: json["selMnbdNckNm"] == "" ? "-" : json["selMnbdNckNm"],
        selMthdCd: int.parse(json["selMthdCd"].toString()),
        selPrc: int.parse(json["selPrc"].toString()),
        selPrdClfCd: json["selPrdClfCd"] == "" ? "-" : json["selPrdClfCd"],
        selStatCd: int.parse(json["selStatCd"].toString()),
        selTermUseYn: json["selTermUseYn"],
        sellerItemEventYn: json["sellerItemEventYn"],
        sellerPrdCd: json["sellerPrdCd"],
        shopNo: int.parse(json["shopNo"].toString()),
        tmpltSeq: int.parse(json["tmpltSeq"].toString()),
        validateMsg: json["validateMsg"] == "" ? "-" : json["validateMsg"],
        nResult: int.parse(json["nResult"].toString()),
        dispCtgrNm: json["dispCtgrNm"],
        dispCtgrNmMid: json["dispCtgrNmMid"],
        dispCtgrNmRoot: json["dispCtgrNmRoot"],
        dscAmt: int.parse(json["dscAmt"].toString()),
        dscPrice: int.parse(json["dscPrice"].toString()),
        freeDelivery: int.parse(json["freeDelivery"].toString()),
        productOptionDetails: json["ProductOptionDetails"],
        dispCtgrNo1:  int.parse(json["dispCtgrNo1"].toString()),
        stock: int.parse(json["stock"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "bndlDlvCnYn": bndlDlvCnYn,
        "cuponcheck": cuponcheck,
        "dispCtgrNo": dispCtgrNo,
        "dispCtgrStatCd": dispCtgrStatCd,
        "exchDlvCst": exchDlvCst,
        "imageKindChk": imageKindChk,
        "optionAllAddPrc": optionAllAddPrc,
        "outsideYnIn": outsideYnIn,
        "outsideYnOut": outsideYnOut,
        "prdAttrCd": prdAttrCd,
        "prdNm": prdNm,
        "prdNo": prdNo,
        "prdSelQty": prdSelQty,
        "prdUpdYN": prdUpdYn,
        "preSelPrc": preSelPrc,
        "proxyYn": proxyYn,
        "rtngdDlvCst": rtngdDlvCst,
        "saleEndDate": saleEndDate,
        "saleStartDate": saleStartDate,
        "selLimitPersonType": selLimitPersonType,
        "selMnbdNckNm": selMnbdNckNm,
        "selMthdCd": selMthdCd,
        "selPrc": selPrc,
        "selPrdClfCd": selPrdClfCd,
        "selStatCd": selStatCd,
        "selTermUseYn": selTermUseYn,
        "sellerItemEventYn": sellerItemEventYn,
        "sellerPrdCd": sellerPrdCd,
        "shopNo": shopNo,
        "tmpltSeq": tmpltSeq,
        "validateMsg": validateMsg,
        "nResult": nResult,
        "dispCtgrNm": dispCtgrNm,
        "dispCtgrNmMid": dispCtgrNmMid,
        "dispCtgrNmRoot": dispCtgrNmRoot,
        "dscAmt": dscAmt,
        "dscPrice": dscPrice,
        "freeDelivery": freeDelivery,
        "ProductOptionDetails": productOptionDetails,
        "dispCtgrNo1": dispCtgrNo1,
        "stock": stock,
      };
}

class ProductOptionDetail {
  ProductOptionDetail({
     this.addPrc,
     this.colCount,
     this.colOptPrice,
     this.colValue0,
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
  String colValue0;
  int optWght;
  int selQty;
  String sellerPrdOptCd;
  int stckQty;
  int stockNo;
  String useYn;

  factory ProductOptionDetail.fromJson(Map<String, dynamic> json) =>
      ProductOptionDetail(
        addPrc: int.parse(json["addPrc"]),
        colCount: int.parse(json["colCount"]),
        colOptPrice: int.parse(json["colOptPrice"]),
        colValue0: json["colValue0"] == null ? null : json["colValue0"],
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
        "colValue0": colValue0 == null ? null : colValue0,
        "optWght": optWght,
        "selQty": selQty,
        "sellerPrdOptCd": sellerPrdOptCd,
        "stckQty": stckQty,
        "stockNo": stockNo,
        "useYn": useYn,
      };
}

