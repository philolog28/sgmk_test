import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sgmk_test/data/services/model/pizza_model.dart';
import 'package:sgmk_test/domain/repositories/pizza_repository.dart';
import 'package:sgmk_test/presenter/catalog_page/bloc/catalog_bloc.dart';

class MockPizzaRepository extends Mock implements PizzaRepository {}

class FakePizza extends Fake implements Pizza {}

void main() {
  final mockPizzaInCart = [
    Pizza(
        id: '1',
        title: 'title 1',
        price: 1,
        inCart: false,
        quantity: 2,
        maxQuantity: 2),
    Pizza(
        id: '2',
        title: 'title 2',
        price: 2,
        inCart: false,
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

  group('CatalogBloc', () {
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
      ).thenAnswer((_) async{});
    });

    CatalogBloc buildBloc() {
      return CatalogBloc(pizzaRepository: pizzaRepository);
    }

    group('constructor', () {
      test('works correct ', () => expect(buildBloc, returnsNormally));

      test(' has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const CatalogInitialState()),
        );
      });
    });

    group('Catalog loading requested', () {
      blocTest<CatalogBloc, CatalogState>(
        'starts listening repository stream',
        build: buildBloc,
        act: (bloc) {
          bloc.add(const CatalogLoadingRequested());
        },
        verify: (_) {
          verify(() => pizzaRepository.getPizzaCatalog()).called(1);
        },
      );
      blocTest<CatalogBloc, CatalogState>(
        'emits state and update catalog ',
        build: buildBloc,
        act: (bloc) => bloc.add(const CatalogLoadingRequested()),
        expect: () => [
          const CatalogLoadingState(),
          CatalogLoadedState( catalog : mockPizzaInCart)
        ],
      );
    });
    group('Add to cart works correctly', () {
      blocTest<CatalogBloc,CatalogState>(
        'calls editPizza repository function',
        build: buildBloc,
        act: (bloc) {
          bloc.catalogPizza=mockPizzaInCart;
          bloc.add(const AddPizzaToCartRequested(index: 0));
        },
        verify: (_) async{
          verify(() => pizzaRepository.editPizza(any())).called(1);
        },
      );
      blocTest<CatalogBloc,CatalogState>(
          'moves the pizza to the catalog ',
          build: buildBloc,
          act: (bloc) {
            bloc.catalogPizza.add(Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: false,
                quantity: 2,
                maxQuantity: 3));
            bloc.add(const AddPizzaToCartRequested(index: 0));
          },
          expect: ()=> [
            const EasyMaskLoadingState(),const StopEasyMaskLoadingState(),CatalogLoadedState(catalog: [Pizza(
                id: '1',
                title: 'title 1',
                price: 1,
                inCart: true,
                quantity: 2,
                maxQuantity: 3)],)
          ]
      );
    });
  });
}
