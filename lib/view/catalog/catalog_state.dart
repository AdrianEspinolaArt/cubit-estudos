import 'package:equatable/equatable.dart';
import 'package:processo_selecao_iesde/models/catalog.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object?> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}


class CatalogSuccess extends CatalogState {
  /// The catalog products.
  final List<CatalogDataModel> products;

  /// Creates a [CatalogSuccess] instance.
  const CatalogSuccess(this.products);

  @override
  List<Object?> get props => [products];
}



class CatalogError extends CatalogState {
  final String errorMessage;

  const CatalogError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];

  get message => null;
}
