import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sgmk_test/domain/repositories/pizza_repository.dart';
import 'package:sgmk_test/utils/string_generator.dart';

import '../../../data/services/model/pizza_model.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc({required PizzaRepository pizzaRepository})
      : _pizzaRepository = pizzaRepository,
        super(const AdminInitialState()) {
    on<AddNewPizza>(_addNewPizza);
    on<Submit>(_submit);
    on<ChangePizzaTitle>(_changePizzaTitle);
    on<ChangePizzaPrice>(_changePizzaPrice);
    on<DecrementMaxQuantity>(_decrementPizzaMaxQuantity);
    on<IncrementMaxQuantity>(_incrementPizzaMaxQuantity);
    on<AdminLoadingRequested>(_adminLoadingRequested);
  }

  final PizzaRepository _pizzaRepository;
  List<Pizza> adminPizza = [];

  Future<void> _addNewPizza(AddNewPizza event, Emitter<AdminState> emit) async {
    emit(const EasyMaskLoadingState());
    final pizza = event.pizza.copyWith(id: RandomCodeGenerator.getRandomString());
    adminPizza.add(pizza);
    emit(const StopEasyMaskLoadingState());
    emit(AdminLoadedState(products: adminPizza));
  }

  Future<void> _submit(Submit event, Emitter<AdminState> emit) async {
    emit(const EasyMaskLoadingState());
    await _pizzaRepository.createPizza(event.products);
    emit(const StopEasyMaskLoadingState());
  }

  Future<void> _adminLoadingRequested(
      AdminLoadingRequested event, Emitter<AdminState> emit) async {
    emit(const AdminLoadingState());
    await emit.forEach<List<Pizza>>(_pizzaRepository.getPizzaCatalog(),
        onData: (pizza) {
      adminPizza = pizza;
      return AdminLoadedState(products: adminPizza);
    });
  }

  void _changePizzaTitle(ChangePizzaTitle event, Emitter<AdminState> emit) {
    emit(const EasyMaskLoadingState());
    final pizza = adminPizza[event.index].copyWith(title: event.newTitle);
    adminPizza[event.index]=pizza;
    emit(const StopEasyMaskLoadingState());
    emit(AdminLoadedState(products: adminPizza));

  }

  void _changePizzaPrice(
      ChangePizzaPrice event, Emitter<AdminState> emit) {
    emit(const EasyMaskLoadingState());
    final pizza = adminPizza[event.index].copyWith(price: double.parse(event.newPrice));
    adminPizza[event.index]=pizza;
    emit(const StopEasyMaskLoadingState());
    emit(AdminLoadedState(products: adminPizza));

  }

  void _incrementPizzaMaxQuantity(
      IncrementMaxQuantity event, Emitter<AdminState> emit) {
    emit(const EasyMaskLoadingState());
    final pizza = adminPizza[event.index].copyWith(maxQuantity: event.newQuantity);
    adminPizza[event.index]=pizza;
    emit(const StopEasyMaskLoadingState());
    emit(AdminLoadedState(products: adminPizza));
  }
  void _decrementPizzaMaxQuantity(
      DecrementMaxQuantity event, Emitter<AdminState> emit) {
    emit(const EasyMaskLoadingState());
    if(adminPizza[event.index].maxQuantity !=1){
      final pizza = adminPizza[event.index].copyWith(maxQuantity: event.newQuantity);
      adminPizza[event.index]=pizza;
      emit(const StopEasyMaskLoadingState());
      emit(AdminLoadedState(products: adminPizza));
    }else{
      adminPizza.removeAt(event.index);
      emit(const StopEasyMaskLoadingState());
      emit(AdminLoadedState(products: adminPizza));
    }

  }
}
