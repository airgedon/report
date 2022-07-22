import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_practice/behavior.dart';
import 'package:http_practice/presentation/bloc/clothes_cubit.dart';
import 'package:http_practice/presentation/screens/cart_screen/cart_screen.dart';
import 'package:http_practice/presentation/screens/cart_screen/model.dart';
import 'package:http_practice/presentation/screens/home_screen/home_screen.dart';
import 'package:http_practice/presentation/screens/home_screen/model/api_request/api_request.dart';
import 'package:http_practice/presentation/screens/login/login_screen.dart';
import 'package:http_practice/presentation/screens/register/register_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShopApp();
  }
}

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListCartProduct(),
      child: BlocProvider<ClothesCubit>(
        create: (context) => ClothesCubit(apiRequest: ApiRequest()),
        child: MaterialApp(
          scrollBehavior: MyBehavior(),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/login': (context) => const LoginScreen(),
            '/cart_screen': (context) => CartScreen(),
            '/register_screen': (context) => const RegisterScreen()
          },
        ),
      ),
    );
  }
}
