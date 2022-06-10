import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sgmk_test/domain/repositories/pizza_repository.dart';
import 'package:sgmk_test/presenter/catalog_page/catalog_page.dart';

import '../presenter/admin_page/admin_page.dart';


class App extends StatelessWidget {
  const App({Key? key, required this.pizzaRepository}) : super(key: key);

  final PizzaRepository pizzaRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PizzaRepository>(
        create: (_)=> pizzaRepository,
            child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      builder: EasyLoading.init(),
      home:const   CatalogPage(),
    );
  }
}
