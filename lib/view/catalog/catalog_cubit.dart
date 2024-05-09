import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:processo_selecao_iesde/models/catalog.dart';
import 'package:processo_selecao_iesde/view/catalog/catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit() : super(CatalogInitial());

  // Método para carregar os itens do catálogo
  void loadCatalog(List<CatalogDataModel> products) {
    emit(CatalogSuccess(products));
  }
}
