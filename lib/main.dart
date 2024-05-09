import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:processo_selecao_iesde/view/cart/cart_cubit.dart';
import 'package:processo_selecao_iesde/view/catalog/catalog_cubit.dart';
import 'package:processo_selecao_iesde/view/login/login.dart';
import 'package:processo_selecao_iesde/view/login/login_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
          BlocProvider<CatalogCubit>(create: (context) => CatalogCubit()),
          BlocProvider<CartCubit>(create: (context) => CartCubit()),
        ],
        child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLogin(),
    ), // Use o LoginForm
      );
  }
}