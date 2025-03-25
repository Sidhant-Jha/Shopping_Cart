// part of 'shop_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/model/products_model.dart';

abstract class ShopState extends Equatable{
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopPageLoadedState extends ShopState {
  ProductsModel shopData;
  ProductsModel cartData;

  ShopPageLoadedState({required this.cartData, required this.shopData});
}

class ItemAddingCartState extends ShopState {
  ProductsModel cartData;
  List<ProductsModel> cartItems;

  ItemAddingCartState({required this.cartData, required this.cartItems});
}

class ItemAddedCartState extends ShopState {
  List<ProductsModel> cartItems;

  ItemAddedCartState({required this.cartItems});
}

class ItemDeletingCartState extends ShopState {
  List<ProductsModel> cartItems;

  ItemDeletingCartState({required this.cartItems});
}
