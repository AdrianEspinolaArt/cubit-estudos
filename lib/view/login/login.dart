import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:processo_selecao_iesde/view/catalog/catalog.dart';
import 'package:processo_selecao_iesde/view/catalog/catalog_cubit.dart';
import 'package:processo_selecao_iesde/view/login/login_cubit.dart';
import 'package:processo_selecao_iesde/view/login/login_state.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
          BlocProvider<CatalogCubit>(create: (context) => CatalogCubit()),
        ],
        child: const AuthForm(),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  _AuthFormState createState() => _AuthFormState();
}
class _AuthFormState extends State<AuthForm> {
  late AuthCubit _authCubit;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCatalog()));
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _authCubit.login(
                    _usernameController.text,
                    _passwordController.text,
                  );
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 8.0),
              
            ],
          ),
        );
      },
    );
  }
}
