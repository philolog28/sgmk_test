import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:sgmk_test/app/app.dart';
import 'package:sgmk_test/data/services/api/pizza_api.dart';
import 'package:sgmk_test/domain/repositories/pizza_repository.dart';


void bootstrap({required PizzaApi pizzaApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final pizzaRepository = PizzaRepository(pizzaApi: pizzaApi);

  runZonedGuarded(
        () async {
      await BlocOverrides.runZoned(
            () async => runApp(
          App(pizzaRepository: pizzaRepository),
        ),
      );
    },
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}