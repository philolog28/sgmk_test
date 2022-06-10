import '../model/pizza_model.dart';

abstract class PizzaApi {
  Stream<List<Pizza>> getPizzaCatalog();

  Future<void> editPizza(Pizza addedPizza);

  Future<void> createPizza(List<Pizza> pizzas);
}
