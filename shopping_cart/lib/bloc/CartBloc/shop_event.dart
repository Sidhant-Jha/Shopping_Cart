part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class ShopPageInitializedEvent extends ShopEvent {}

class ItemAddingCartEvent extends ShopEvent {
  List<ProductsModel> cartItems;

  ItemAddingCartEvent({required this.cartItems});
}

class ItemAddedCartEvent extends ShopEvent {
  List<ProductsModel> cartItems;

  ItemAddedCartEvent({required this.cartItems});
}

class ItemDeleteCartEvent extends ShopEvent {
  List<ProductsModel> cartItems;
  int index;
  ItemDeleteCartEvent({required this.cartItems, required this.index});
}
