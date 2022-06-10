import 'package:flutter/widgets.dart';
import 'package:sgmk_test/bootstrap.dart';
import 'package:sgmk_test/data/services/local_storage/pizza_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pizzaApi = PizzaLocalStorage(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(pizzaApi: pizzaApi);
}
