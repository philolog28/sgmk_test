part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartLoadingRequested extends CartEvent {
  const CartLoadingRequested();

  @override
  List<Object?> get props => [];
}

class IncrementPizzaQuantityRequested extends CartEvent {
  final int newQuantity;
  final int index;

  const IncrementPizzaQuantityRequested( {required this.index,required this.newQuantity});

  @override
  List<Object?> get props => [newQuantity,index];
}
class DecrementPizzaQuantityRequested extends CartEvent {
  final int newQuantity;
  final int index;

  const DecrementPizzaQuantityRequested( {required this.index,required this.newQuantity});

  @override
  List<Object?> get props => [newQuantity,index];
}


