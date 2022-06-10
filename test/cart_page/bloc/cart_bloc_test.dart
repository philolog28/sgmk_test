import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sgmk_test/data/services/model/pizza_model.dart';
import 'package:sgmk_test/domain/repositories/pizza_repository.dart';
import 'package:sgmk_test/presenter/cart_page/bloc/cart_bloc.dart';

class MockPizzaRepository extends Mock implements PizzaRepository {}

class FakePizza extends Fake implements Pizza {}

void main() {
  final mockPizzaInCart = [
    Pizza(
        id: '1',
        title: 'title 1',
        price: 1,
        inCart: true,
        quantity: 2,
        maxQuantity: 2),
    Pizza(
        id: '2',
        title: 'title 2',
        price: 2,
        inCart: true,
        quantity: 2,
        maxQuantity: 2),
    Pizza(
        id: '3',
        title: 'title 3',
        price: 3,
        inCart: true,
        quantity: 1,
        maxQuantity: 2),
  ];

  group('CartBloc', () {
    late PizzaRepository pizzaRepository;
    setUpAll(() {
      registerFallbackValue(FakePizza());
    });
    setUp(() {
      pizzaRepository = MockPizzaRepository();
      when(
        () => pizzaRepository.getPizzaCatalog(),
      ).thenAnswer((invocation) => Stream.value(mockPizzaInCart));
    });
    setUp(() {
      when(
        () => pizzaRepository.editPizza(any()),
      ).thenAnswer((_) async {});
    });

    CartBloc buildBloc() {
      return CartBloc(pizzaRepository: pizzaRepository);
    }

    group('constructor', () {
      test('works correct ', () => expect(buildBloc, returnsNormally));

      test(' has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const CartInitialState()),
        );
      });
    });

    group('Cart loading requested', () {
      blocTest<CartBloc, CartState>(
        'starts listening repository stream',
        build: buildBloc,
        act: (bloc) {
          bloc.add(const CartLoadingRequested());
        },
        verify: (_) {
          verify(() => pizzaRepository.getPizzaCatalog()).called(1);
        },
      );
      blocTest<CartBloc, CartState>(
        'emits state and update cart ',
        build: buildBloc,
        act: (bloc) => bloc.add(const CartLoadingRequested()),
        expect: () => [
          const CartLoadingState(),
          CartLoadedState(totalPrice: 9.0, cart: mockPizzaInCart)
        ],
      );
    });
    group('Increment works correctly', () {
      blocTest<CartBloc, CartState>(
        'calls editPizza repository function',
        build: buildBloc,
        act: (bloc) {
          bloc.cartPizza = mockPizzaInCart;
          bloc.add(
              const IncrementPizzaQuantityRequested(index: 0, newQuantity: 4));
        },
        verify: (_) async {
          verify(() => pizzaRepository.editPizza(any())).called(1);
        },
      );

      blocTest<CartBloc, CartState>(
          'Increment the selected pizza quantity and emits correct states  ',
          build: buildBloc,
          act: (bloc) {
            bloc.cartPizza.add(Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 2,
                maxQuantity: 3));
            bloc.add(const IncrementPizzaQuantityRequested(
                index: 0, newQuantity: 3));
          },
          expect: () => [
                const EasyMaskLoadingState(),
                const StopEasyMaskLoadingState(),
                CartLoadedState(cart: [
                  Pizza(
                      id: '1',
                      title: 'title 1',
                      price: 1,
                      inCart: true,
                      quantity: 3,
                      maxQuantity: 3)
                ], totalPrice: 0)
              ]);
    });

    group('Decrement works correctly', () {
      blocTest<CartBloc, CartState>(
        'calls editPizza repository function',
        build: buildBloc,
        act: (bloc) {
          bloc.cartPizza = mockPizzaInCart;
          bloc.add(
              const DecrementPizzaQuantityRequested(index: 0, newQuantity: 1));
        },
        verify: (_) async {
          verify(() => pizzaRepository.editPizza(any())).called(1);
        },
      );
      blocTest<CartBloc, CartState>(
          'decrement the selected pizza quantity and emits correct states  ',
          build: buildBloc,
          act: (bloc) {
            bloc.cartPizza.add(Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 2,
                maxQuantity: 3));
            bloc.add(const DecrementPizzaQuantityRequested(
                index: 0, newQuantity: 1));
          },
          expect: () => [
                const EasyMaskLoadingState(),
                const StopEasyMaskLoadingState(),
                CartLoadedState(cart: [
                  Pizza(
                      id: '1',
                      title: 'title 1',
                      price: 1,
                      inCart: true,
                      quantity: 1,
                      maxQuantity: 3)
                ], totalPrice: 0)
              ]);
      blocTest<CartBloc, CartState>(
          'moves the pizza to the catalog when its quantity becomes zero',
          build: buildBloc,
          act: (bloc) {
            bloc.cartPizza.add(Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 1,
                maxQuantity: 3));
            bloc.add(const DecrementPizzaQuantityRequested(
                index: 0, newQuantity: 0));
          },
          expect: () => [
                const EasyMaskLoadingState(),
                const StopEasyMaskLoadingState(),
                CartLoadedState(cart: [
                  Pizza(
                      id: '1',
                      title: 'title 1',
                      price: 1,
                      inCart: false,
                      quantity: 1,
                      maxQuantity: 3)
                ], totalPrice: 0)
              ]);
    });
  });
}
