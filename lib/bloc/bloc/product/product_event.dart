part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductDetail extends ProductEvent {
  final int idProduct;

  const LoadProductDetail(this.idProduct);

  @override
  List<Object> get props => [];
}

class InsertProductCheckOut extends ProductEvent {
  final ProductDetail productDetail;

  const InsertProductCheckOut(this.productDetail);

  @override
  List<Object> get props => [];
}

class LoadProductCheckOut extends ProductEvent {
  const LoadProductCheckOut();

  @override
  List<Object> get props => [];
}

class DeleteProduct extends ProductEvent {
  final int idProduct;

  const DeleteProduct(this.idProduct);

  @override
  List<Object> get props => [];
}

class CheckoutProduct extends ProductEvent {
  const CheckoutProduct();

  @override
  List<Object> get props => [];
}
