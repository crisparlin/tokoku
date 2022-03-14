part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final int limit;
  final int page;
  final List<ProductElement> productElement;
  final List<ProductDetail> productDetail;

  const HomeLoaded(
      this.productElement, this.limit, this.page, this.productDetail);

  @override
  List<Object> get props => [productElement, limit, page, productDetail];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
