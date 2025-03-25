
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/model/products_model.dart';

abstract class ShopState extends Equatable {
  const ShopState();
  
  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<ProductsModel> products;
  final Map<ProductsModel, int> cartItems; 
  final double totalPrice;
  
  const ShopLoaded({
    required this.products,
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  List<Object> get props => [products, cartItems, totalPrice];
}

class CartUpdating extends ShopState {
  final Map<ProductsModel, int> cartItems;
  
  const CartUpdating(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class CartError extends ShopState {
  final String message;
  
  const CartError(this.message);

  @override
  List<Object> get props => [message];
}