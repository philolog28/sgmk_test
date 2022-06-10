import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sgmk_test/data/services/model/pizza_model.dart';
import 'package:sgmk_test/domain/repositories/pizza_repository.dart';

part 'catalog_event.dart';

part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({required PizzaRepository pizzaRepository})
      : _pizzaRepository = pizzaRepository,
        super(const CatalogInitialState()) {
    on<CatalogLoadingRequested>(_onCatalogLoadingRequested);
    on<AddPizzaToCartRequested>(_addPizzaToCartRequested);
  }

  List<Pizza> catalogPizza =[];
  final PizzaRepository _pizzaRepository;

  Future<void> _onCatalogLoadingRequested(
      CatalogLoadingRequested event, Emitter<CatalogState> emit) async {
    emit(const CatalogLoadingState());
    await emit.forEach<List<Pizza>>(_pizzaRepository.getPizzaCatalog(),
        onData: (pizza) {
      catalogPizza =
          List.from(pizza.where((element) => element.inCart != true).toList());
      return CatalogLoadedState(catalog: catalogPizza);
    });
  }

  Future<void> _addPizzaToCartRequested(
      AddPizzaToCartRequested event, Emitter<CatalogState> emit) async {
    emit(const EasyMaskLoadingState());
    final pizza =
    catalogPizza[event.index].copyWith(inCart: true);
    catalogPizza[event.index] = pizza;
    await _pizzaRepository.editPizza(pizza);
    emit(const StopEasyMaskLoadingState());
    emit (CatalogLoadedState(catalog: catalogPizza));
  }
}
