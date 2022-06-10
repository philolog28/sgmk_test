import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sgmk_test/domain/repositories/pizza_repository.dart';

import '../../../data/services/model/pizza_model.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required PizzaRepository pizzaRepository})
      : _pizzaRepository = pizzaRepository,
        super(const CartInitialState()) {
    on<CartLoadingRequested>(_load);
    on<DecrementPizzaQuantityRequested>(_decrementPizzaQuantityRequested);
    on<IncrementPizzaQuantityRequested>(_incrementPizzaQuantityRequested);
  }

  final PizzaRepository _pizzaRepository;
  List<Pizza> cartPizza = [];
  double totalPrice = 0;

  Future<void> _load(
      CartLoadingRequested event, Emitter<CartState> emit) async {
    emit(const CartLoadingState());
    await emit.forEach<List<Pizza>>(_pizzaRepository.getPizzaCatalog(),
        onData: (pizza) {
      totalPrice = 0;
      for (int i = 0; i < pizza.length; i++) {
        totalPrice = totalPrice + pizza[i].price! * pizza[i].quantity!;
      }
      cartPizza =
          List.from(pizza.where((element) => element.inCart == true).toList());
      return CartLoadedState(cart: cartPizza, totalPrice: totalPrice);
    });
  }

  Future<void> _decrementPizzaQuantityRequested(
      DecrementPizzaQuantityRequested event, Emitter<CartState> emit) async {
    emit(const EasyMaskLoadingState());
    if (cartPizza[event.index].quantity != 1) {
      final pizza =
          cartPizza[event.index].copyWith(quantity: event.newQuantity);
      cartPizza[event.index] = pizza;
       _pizzaRepository.editPizza(pizza);
      emit(const StopEasyMaskLoadingState());
      emit(CartLoadedState(cart: cartPizza, totalPrice: totalPrice));
    } else {
      final pizza = cartPizza[event.index].copyWith(inCart: false);
      cartPizza[event.index] = pizza;
      await _pizzaRepository.editPizza(pizza);
      emit(const StopEasyMaskLoadingState());
      emit(CartLoadedState(cart: cartPizza, totalPrice: totalPrice));
    }
  }

  Future<void> _incrementPizzaQuantityRequested(
      IncrementPizzaQuantityRequested event, Emitter<CartState> emit) async {
    emit(const EasyMaskLoadingState());
    final pizza = cartPizza[event.index].copyWith(quantity: event.newQuantity);
    cartPizza[event.index] = pizza;
     _pizzaRepository.editPizza(pizza);
    emit(const StopEasyMaskLoadingState());
    emit(CartLoadedState(cart: cartPizza, totalPrice: totalPrice));
  }
}
