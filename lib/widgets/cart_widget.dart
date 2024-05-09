import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:processo_selecao_iesde/models/catalog.dart';
import 'package:processo_selecao_iesde/view/cart/cart_cubit.dart';
import 'package:processo_selecao_iesde/view/cart/cart_state.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          final cartItems = state.cartItens;
          debugPrint('CartWidget: Successfully loaded cart with ${cartItems.length} items');
          return FruitInCart(itensInCart: cartItems);
        } else if (state is CartLoading) {
          debugPrint('CatalogWidget: Loading catalog');
        } else if (state is CartError) {
          debugPrint('CatalogWidget: Error loading catalog: ${state.message}');
        }
        debugPrint('CatalogWidget: Falling back to CircularProgressIndicator');
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

}

class FruitInCart extends StatelessWidget {
  const FruitInCart({
    super.key,
    required this.itensInCart,
  });

  final List<CatalogDataModel> itensInCart;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itensInCart.length,
      itemBuilder: (context, index) {
        final product = itensInCart[index];
        return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/${product.image}',
                                width: 170,
                                height: 170,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.description,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'R\$ ${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => context.read<CartCubit>().decreaseQuantity(index),
                                ),
                                Text(product.quantity.toString()),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => context.read<CartCubit>().increaseQuantity(index),
                                ),
                                
                              ],
                            ),
                            Center(
                              child: ElevatedButton.icon(
                                    onPressed: () => context.read<CartCubit>().addToCart(product),
                                    icon: const Icon(Icons.add_shopping_cart_outlined),
                                    label: const Text('Add to cart'),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
  }





// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:processo_selecao_iesde/models/catalog.dart';
// import 'package:processo_selecao_iesde/view/cart/cart_cubit.dart';

// class CartWidget extends StatelessWidget {
//   final List<CatalogDataModel> Cart;

//   const CartWidget({super.key, 
//     required this.Cart,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: Cart.length,
//       itemBuilder: (context, index) {
//         final item = Cart[index];
//         return Column(
//           children: [
//             ListTile(
//               isThreeLine: true,
//               leading: SizedBox(
//                 width: 80,
//                 height: 100,
//                 child: Image.asset(
//                   'assets/images/${item.image}',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               title: Text(item.name),
//               subtitle: Text('${item.price}'),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.remove),
//                             onPressed: () {
//                               context.read<CartCubit>().decreaseQuantity(index);
//                             },
//                           ),
//                           Text(item.quantity.toString()),
//                           IconButton(
//                             icon: const Icon(Icons.add),
//                             onPressed: () {
//                               context.read<CartCubit>().increaseQuantity(index);
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete_outline_sharp),
//                             onPressed: () {
//                               context.read<CartCubit>().removeFromCart(index);
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(),
//           ],
//         );
//       },
//     );
//   }
// }
