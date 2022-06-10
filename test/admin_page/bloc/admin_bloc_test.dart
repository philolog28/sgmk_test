import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sgmk_test/data/services/model/pizza_model.dart';
import 'package:sgmk_test/domain/repositories/pizza_repository.dart';
import 'package:sgmk_test/presenter/admin_page/bloc/admin_bloc.dart';

class MockPizzaRepository extends Mock implements PizzaRepository {}

class FakePizza extends Fake implements Pizza {}

void main() {
  final mockPizza = [
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
        inCart: false,
        quantity: 1,
        maxQuantity: 2),
  ];

  group('AdminBloc', () {
    late PizzaRepository pizzaRepository;
    setUpAll(() {
      registerFallbackValue(FakePizza());
    });
    setUp(() {
      pizzaRepository = MockPizzaRepository();
      when(
        () => pizzaRepository.getPizzaCatalog(),
      ).thenAnswer((invocation) => Stream.value(mockPizza));
    });
    setUp(() {
      when(
        () => pizzaRepository.createPizza(any()),
      ).thenAnswer((_) async {});
    });

    AdminBloc buildBloc() {
      return AdminBloc(pizzaRepository: pizzaRepository);
    }

    group('constructor', () {
      test('works correct ', () => expect(buildBloc, returnsNormally));

      test(' has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const AdminInitialState()),
        );
      });
    });

    group('Admin loading requested', () {
      blocTest<AdminBloc, AdminState>(
        'starts listening repository stream',
        build: buildBloc,
        act: (bloc) {
          bloc.add(const AdminLoadingRequested());
        },
        verify: (_) {
          verify(() => pizzaRepository.getPizzaCatalog()).called(1);
        },
      );
      blocTest<AdminBloc, AdminState>(
        'emits state and update cart ',
        build: buildBloc,
        act: (bloc) => bloc.add(const AdminLoadingRequested()),
        expect: () =>
            [const AdminLoadingState(), AdminLoadedState(products: mockPizza)],
      );
    });

    group('Create new pizza works correctly', () {
      blocTest<AdminBloc, AdminState>('Create new pizza', build: buildBloc,
          act: (bloc) {
        bloc.add(Submit(products: mockPizza));
      }, verify: (_) {
        verify(() => pizzaRepository.createPizza(mockPizza)).called(1);
      });
    });

    group('Change pizza params works correctly', () {
      blocTest<AdminBloc, AdminState>(
        'Change pizza title',
        build: buildBloc,
        act: (bloc) {
          bloc.adminPizza.add(
            Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 2,
                maxQuantity: 2),
          );
          bloc.add(const ChangePizzaTitle(newTitle: 'title 2 ', index: 0));
        },
        expect: () => [
          const EasyMaskLoadingState(),
          const StopEasyMaskLoadingState(),
          AdminLoadedState(products: [
            Pizza(
                id: '1',
                title: 'title 2 ',
                price: 1,
                inCart: true,
                quantity: 2,
                maxQuantity: 2),
          ])
        ],
      );
      blocTest<AdminBloc, AdminState>(
        'Change pizza price',
        build: buildBloc,
        act: (bloc) {
          bloc.adminPizza.add(
            Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 2,
                maxQuantity: 2),
          );
          bloc.add(const ChangePizzaPrice(newPrice: '2', index: 0));
        },
        expect: () => [
          const EasyMaskLoadingState(),
          const StopEasyMaskLoadingState(),
          AdminLoadedState(products: [
            Pizza(
                id: '1',
                title: 'title 1',
                price: 2,
                inCart: true,
                quantity: 2,
                maxQuantity: 2),
          ])
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'Increment pizza maxQuantity',
        build: buildBloc,
        act: (bloc) {
          bloc.adminPizza.add(
            Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 2,
                maxQuantity: 2),
          );
          bloc.add(const IncrementMaxQuantity(newQuantity: 3, index: 0));
        },
        expect: () => [
          const EasyMaskLoadingState(),
          const StopEasyMaskLoadingState(),
          AdminLoadedState(products: [
            Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 2,
                maxQuantity: 3),
          ])
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'Decrement pizza maxQuantity',
        build: buildBloc,
        act: (bloc) {
          bloc.adminPizza.add(
            Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 2,
                maxQuantity: 2),
          );
          bloc.add(const DecrementMaxQuantity(newQuantity: 1, index: 0));
        },
        expect: () => [
          const EasyMaskLoadingState(),
          const StopEasyMaskLoadingState(),
          AdminLoadedState(products: [
            Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 2,
                maxQuantity: 1),
          ])
        ],
      );

      blocTest<AdminBloc, AdminState>(
        'Decrement pizza maxQuantity delete pizza if maxQuantity =0',
        build: buildBloc,
        act: (bloc) {
          bloc.adminPizza.add(
            Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 1,
                maxQuantity: 1),
          );
          bloc.add(const DecrementMaxQuantity(newQuantity: 0, index: 0));
        },
        expect: () => [
          const EasyMaskLoadingState(),
          const StopEasyMaskLoadingState(),
          const AdminLoadedState(products: [])
        ],
      );
    });
  });
}
