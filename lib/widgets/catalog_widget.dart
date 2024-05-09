import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:processo_selecao_iesde/models/catalog.dart';
import 'package:processo_selecao_iesde/view/cart/cart_cubit.dart';
import 'package:processo_selecao_iesde/view/cart/cart_state.dart';
import 'package:processo_selecao_iesde/view/catalog/catalog_cubit.dart';
import 'package:processo_selecao_iesde/view/catalog/catalog_state.dart';

class CatalogWidget extends StatelessWidget {
  const CatalogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        if (state is CatalogSuccess) {
          final catalog = state.products;
          debugPrint('CatalogWidget: Successfully loaded catalog with ${catalog.length} items');
          return FruitItem(catalog: catalog);
        } else if (state is CatalogLoading) {
          debugPrint('CatalogWidget: Loading catalog');
        } else if (state is CatalogError) {
          debugPrint('CatalogWidget: Error loading catalog: ${state.message}');
        }
        debugPrint('CatalogWidget: Falling back to CircularProgressIndicator');
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

}

class FruitItem extends StatelessWidget {
  const FruitItem({
    super.key,
    required this.catalog,
  });

  final List<CatalogDataModel> catalog;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: catalog.length,
      itemBuilder: (context, index) {
        final product = catalog[index];
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Padding(
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
      },
    );
  }
}
