import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:processo_selecao_iesde/data/products_data.dart';

import 'package:processo_selecao_iesde/view/cart/cart.dart';
import 'package:processo_selecao_iesde/view/cart/cart_cubit.dart';
import 'package:processo_selecao_iesde/view/catalog/catalog_cubit.dart';
import 'package:processo_selecao_iesde/widgets/catalog_widget.dart';

class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyCart()),
              );
            },
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CatalogCubit()..loadCatalog(ProductsData.products)),
          BlocProvider(create: (context) => CartCubit()),
        ],
        child: const CatalogWidget(),
      ),
    );
  }
}