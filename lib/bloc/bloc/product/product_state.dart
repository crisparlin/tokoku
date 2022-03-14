part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductDetail productDetail;

  const ProductLoaded(this.productDetail);
}

class ProductCheckoutLoaded extends ProductState {
  final List data;
  const ProductCheckoutLoaded(this.data);
}

class ProductCheckoutDone extends ProductState {
  const ProductCheckoutDone();
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);
}
