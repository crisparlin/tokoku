part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends HomeEvent {
  final int limit;
  final int page;
  final List<ProductElement> productElement;

  const LoadProduct(this.limit, this.page, this.productElement);

  @override
  List<Object> get props => [productElement, limit];
}

class SearchProduct extends HomeEvent {
  final String filter;

  const SearchProduct(this.filter);

  @override
  List<Object> get props => [];
}


