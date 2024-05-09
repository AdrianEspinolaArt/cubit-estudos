import 'package:equatable/equatable.dart';
import 'package:processo_selecao_iesde/models/catalog.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CatalogDataModel> cartItens;

  const CartLoaded(this.cartItens);

  

  @override
  List<Object?> get props => [cartItens];


}




class CartError extends CartState {
  final String errorMessage;

  const CartError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];

  get message => null;
}
