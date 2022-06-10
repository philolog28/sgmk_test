part of 'catalog_bloc.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object?> get props => [];
}
class CatalogInitialState extends CatalogState {
  const CatalogInitialState();
  @override
  List<Object?> get props => [];
}

class CatalogLoadingState extends CatalogState {
  const CatalogLoadingState();
  @override
  List<Object?> get props => [];
}

class CatalogLoadedState extends CatalogState {
  final List<Pizza> catalog;

  const CatalogLoadedState({required this.catalog});

  @override
  List<Object?> get props => [catalog];
}
class EasyMaskLoadingState extends CatalogState {
  const EasyMaskLoadingState();
}

class StopEasyMaskLoadingState extends CatalogState {
  const StopEasyMaskLoadingState();
}

