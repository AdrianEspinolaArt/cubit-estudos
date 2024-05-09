import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:processo_selecao_iesde/view/cart/cart_cubit.dart';
import 'package:processo_selecao_iesde/view/cart/cart_state.dart';
import 'package:processo_selecao_iesde/widgets/cart_widget.dart';

class MyCart extends StatelessWidget {
  const MyCart({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          debugPrint('Cart: Build with state: $state');
          if (state is CartLoaded) {
            debugPrint('Cart: Cart loaded with ${state.cartItens.length} items');
            return const CartWidget();
          } else if (state is CartLoading) {
            debugPrint('Cart: Cart is loading');
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartError) {
            debugPrint('Cart: Cart error: ${state.message}');
            return const Center(child: Text('Error: 404 '));
          } else {
            debugPrint('Cart: Something went wrong!');
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }
}

