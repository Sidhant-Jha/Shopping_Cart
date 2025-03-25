import 'package:equatable/equatable.dart';
import 'package:shopping_cart/model/products_model.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();
  
  @override
  List<Object> get props => [];
}

class LoadShopData extends ShopEvent {}

class AddToCart extends ShopEvent {
  final ProductsModel product;
  
  const AddToCart(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFromCart extends ShopEvent {
  final ProductsModel product;
  final bool removeAll;
  
  const RemoveFromCart(this.product, {this.removeAll = false});

  @override
  List<Object> get props => [product, removeAll];
}

class ClearCart extends ShopEvent {}