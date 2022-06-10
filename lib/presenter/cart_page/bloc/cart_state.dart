part of 'cart_bloc.dart';


abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartState {
  const CartInitialState();

  @override
  List<Object?> get props => [];
}

class CartLoadingState extends CartState {
  const CartLoadingState();

  @override
  List<Object?> get props => [];
}

class CartLoadedState extends CartState {
  final List<Pizza> cart;
  final double totalPrice;
  const CartLoadedState({required this.totalPrice, required this.cart});

  @override
  List<Object?> get props => [cart,totalPrice];
}

class EasyMaskLoadingState extends CartState {
  const EasyMaskLoadingState();
}

class StopEasyMaskLoadingState extends CartState {
  const StopEasyMaskLoadingState();
}

class ErrorState extends CartState {
  const ErrorState();

  @override
  List<Object?> get props => [];
}
