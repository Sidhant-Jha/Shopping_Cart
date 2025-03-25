import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shopping/bloc/FavouritesCubit/favourites_cubit.dart';
// import 'package:shopping/bloc/ProductBloc/product_bloc.dart';
// import 'package:shopping/bloc/ProductCategoryBloc/category_bloc.dart';
import 'package:shopping_cart/bloc/FavouritesCubit/favourites_cubit.dart';
import 'package:shopping_cart/bloc/ProductBloc/product_bloc.dart';
import 'package:shopping_cart/bloc/ProductCategoryBloc/category_bloc.dart';
import 'package:shopping_cart/view/user_information.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc(),),
        BlocProvider(create: (context) => CategoryBloc(),),
        BlocProvider(create: (context) => FavouritesCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFDF0D5),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFDF0D5),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const UserInformation(),
      ),
    );
  }
}
