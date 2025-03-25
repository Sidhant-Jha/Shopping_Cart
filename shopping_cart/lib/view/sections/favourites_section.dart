import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/FavouritesCubit/favourites_cubit.dart';
import 'package:shopping_cart/widgets/custom_gridview.dart';

class FavouritesSection extends StatelessWidget {
  const FavouritesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit,Favourites>(
      builder: (context,state){
        if(state.products.isEmpty)
        {
          return Center(child: Text("No Favourite Items"),);
        }
        return CustromProductGridView(products: state.products.toSet());
      },
    );
  }
}