import 'package:sgmk_test/data/services/api/pizza_api.dart';
import 'package:sgmk_test/data/services/model/pizza_model.dart';

class PizzaRepository {
  final PizzaApi _pizzaApi;

  const PizzaRepository({required PizzaApi pizzaApi}) : _pizzaApi = pizzaApi;

  Stream<List<Pizza>> getPizzaCatalog() => _pizzaApi.getPizzaCatalog();

  Future<void> editPizza(Pizza pizza) => _pizzaApi.editPizza(pizza);

  Future<void> createPizza(List<Pizza> pizza) => _pizzaApi.createPizza(pizza);
}
