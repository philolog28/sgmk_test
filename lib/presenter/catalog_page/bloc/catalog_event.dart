part of 'catalog_bloc.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object?> get props => [];
}

class CatalogLoadingRequested extends CatalogEvent {
  const CatalogLoadingRequested();

  @override
  List<Object?> get props => [];
}

class AddPizzaToCartRequested extends CatalogEvent {
  final int index;

  const AddPizzaToCartRequested({required this.index});

  @override
  List<Object?> get props => [index];
}
