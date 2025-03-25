import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/CartBloc/shop_bloc.dart';
import 'package:shopping_cart/bloc/CartBloc/shop_state.dart';
import 'package:shopping_cart/view/cart_page.dart';
import 'package:shopping_cart/view/cart_page.dart';

class CustomCartIcon extends StatelessWidget {
  const CustomCartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        int itemCount = 0;
        
        if (state is ShopLoaded) {
          itemCount = state.cartItems.length;
        }

        return Stack(
          children: [ 
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
            ),
            if (itemCount > 0)
              Positioned(
                right: 5,
                top: 2,
                child: Container(
                  padding: const EdgeInsets.all(0.5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 16,
                    minWidth: 16,
                  ),
                  child: Text(
                    itemCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}