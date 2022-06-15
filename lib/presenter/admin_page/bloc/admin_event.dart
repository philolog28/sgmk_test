part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class AdminLoadingRequested extends AdminEvent {
  const AdminLoadingRequested();
}
class ChangePizzaTitle extends AdminEvent {
  const ChangePizzaTitle( {required this.newTitle,required this.index,});
  final String newTitle;
  final int index;
  @override
  List<Object?> get props => [newTitle,index,];
}
class ChangePizzaPrice extends AdminEvent {
  const ChangePizzaPrice( {required this.newPrice,required this.index,});
  final String newPrice;
  final int index;
  @override
  List<Object?> get props => [newPrice,index];
}

class DecrementMaxQuantity extends AdminEvent {
  const DecrementMaxQuantity( {required this.newQuantity,required this.index,});
  final int newQuantity;
  final int index;
  @override
  List<Object?> get props => [newQuantity,index,];
}
class IncrementMaxQuantity extends AdminEvent {
  const IncrementMaxQuantity( {required this.newQuantity,required this.index,});
  final int newQuantity;
  final int index;
  @override
  List<Object?> get props => [newQuantity,index,];
}



class AddNewPizza extends AdminEvent {
  final Pizza pizza;

  const AddNewPizza({required this.pizza});

  @override
  List<Object?> get props => [pizza];
}

class Submit extends AdminEvent {
  const Submit({required this.products});

  final List<Pizza> products;

  @override
  List<Object?> get props => [products];
}
