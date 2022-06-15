part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => [];
}

class AdminInitialState extends AdminState {
  const AdminInitialState();
}

class AdminLoadedState extends AdminState {
  const AdminLoadedState({required this.products});

  final List<Pizza> products;

  @override
  List<Object?> get props => [products];
}

class AdminLoadingState extends AdminState {
  const AdminLoadingState();
}

class EasyMaskLoadingState extends AdminState {
  const EasyMaskLoadingState();
}

class StopEasyMaskLoadingState extends AdminState {
  const StopEasyMaskLoadingState();
}
