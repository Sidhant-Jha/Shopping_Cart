import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/CartBloc/shop_bloc.dart';
import 'package:shopping_cart/bloc/CartBloc/shop_event.dart';
import 'package:shopping_cart/bloc/CartBloc/shop_state.dart';
import 'package:shopping_cart/model/products_model.dart';
import 'package:shopping_cart/widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
      ),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoaded) {
            if (state.cartItems.isEmpty) {
              return const Center(
                child: Text('Your cart is empty'),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = state.cartItems.keys.elementAt(index);
                      final quantity = state.cartItems[product]!;

                      return CartItemCard(
                        product: product,
                        quantity: quantity,
                        onIncrease: () => context.read<ShopBloc>().add(AddToCart(product)),
                        onDecrease: () {
                          if (quantity > 1) {
                            context.read<ShopBloc>().add(RemoveFromCart(product));
                          } else {
                            _showRemoveDialog(context, product);
                          }
                        },
                        onRemove: () => _showRemoveDialog(context, product),
                      );
                    },
                  ),
                ),
                _buildTotalSection(context, state),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, ProductsModel product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Item'),
        content: const Text('Are you sure you want to remove this item from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ShopBloc>().add(RemoveFromCart(product, removeAll: true));
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

 Widget _buildTotalSection(BuildContext context, ShopLoaded state) {
  final totalItems = state.cartItems.values.fold(0, (sum, quantity) => sum + quantity);

  return Container(
    height: 100,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Amount Price'),
              Spacer(),
              Text(
                '\$${state.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Check Out",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white,
                  ),
                  Text(
                    totalItems.toString(), 
                    style: const TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

}
      