import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:processo_selecao_iesde/data/cart_itens_data.dart';
import 'package:processo_selecao_iesde/models/catalog.dart';
import 'package:processo_selecao_iesde/view/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartLoaded([]));

  void addToCart(CatalogDataModel item) {
    final existingItemIndex =
        cartItens.indexWhere((cartItem) => cartItem.id == item.id);
    debugPrint('Adding item $item to cart. Existing item index: $existingItemIndex');
    if (existingItemIndex >= 0) {
      debugPrint('Item already in cart. Increasing quantity');
      cartItens[existingItemIndex] = cartItens[existingItemIndex].copyWith(quantity: cartItens[existingItemIndex].quantity + 1);
    } else {
      debugPrint('Item not in cart. Adding with quantity 1');
      cartItens.add(item.copyWith(quantity: 1));
    }
    debugPrint('Emitting new state with cart items: $cartItens');
    emit(CartLoaded(cartItens));
  }


  void removeFromCart(int index) {
    if (index >= 0 && index < cartItens.length) {
      cartItens.removeAt(index);
      emit(CartLoaded(List<CatalogDataModel>.from(cartItens)));
    }
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < cartItens.length) {
      cartItens[index] =
          cartItens[index].copyWith(quantity: cartItens[index].quantity + 1);
      emit(CartLoaded(List<CatalogDataModel>.from(cartItens)));
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < cartItens.length && cartItens[index].quantity > 0) {
      cartItens[index] =
          cartItens[index].copyWith(quantity: cartItens[index].quantity - 1);
      emit(CartLoaded(List<CatalogDataModel>.from(cartItens)));
    }
  }
}
