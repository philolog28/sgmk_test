import 'dart:async';
import 'dart:convert';


import 'package:rxdart/rxdart.dart';
import 'package:sgmk_test/data/services/api/pizza_api.dart';
import 'package:sgmk_test/data/services/model/pizza_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PizzaLocalStorage extends PizzaApi {
  PizzaLocalStorage({required SharedPreferences plugin}) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _pizzaStreamController = BehaviorSubject<List<Pizza>>.seeded(const []);

  static const kPizzaCollectionKey = '_pizza_in_catalog_collection_key_';

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    _plugin.remove(kPizzaCollectionKey);
    final pizzaJson = _getValue(kPizzaCollectionKey);
    if (pizzaJson != null) {
      final pizza = List<Map>.from(jsonDecode(pizzaJson) as List)
          .map((e) => Pizza.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      _pizzaStreamController.add(pizza);
    } else {
      _pizzaStreamController.add([]);
    }
  }

  @override
  Future<void> editPizza(Pizza addedPizza) {
    final pizza = [..._pizzaStreamController.value];
    final pizzaIndex =
        pizza.indexWhere((element) => element.id == addedPizza.id);
    if (pizzaIndex >= 0) {
      pizza[pizzaIndex] = addedPizza;
    } else {
      pizza.add(addedPizza);
    }
    _pizzaStreamController.add(pizza);
    return _setValue(kPizzaCollectionKey, jsonEncode(pizza));
  }

  @override
  Stream<List<Pizza>> getPizzaCatalog() =>
      _pizzaStreamController.asBroadcastStream();

  @override
  Future<void> createPizza(List<Pizza> pizzas) async {
    final createdPizza = List<Pizza>.from(pizzas);
    return _setValue(kPizzaCollectionKey, jsonEncode(createdPizza));
  }
}
