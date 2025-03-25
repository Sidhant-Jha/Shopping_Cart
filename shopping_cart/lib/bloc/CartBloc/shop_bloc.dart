import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/bloc/CartBloc/shop_state.dart';
// import 'package:shop_cart/model/shop.dart';
// import 'package:shop_cart/repository/shop_data_repository.dart';
import 'package:shopping_cart/model/products_model.dart';

part 'shop_event.dart';
// part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopDataProvider shopDataProvider = ShopDataProvider();
  ShopBloc() : super(ShopInitial()) {
    add(ShopPageInitializedEvent());
  }
//
  @override
  Stream<ShopState> mapEventToState(
    ShopEvent event,
  ) async* {
    if (event is ShopPageInitializedEvent) {
      ProductsModel shopData = await shopDataProvider.getShopItems();
      ProductsModel cartData = await shopDataProvider.geCartItems();
      yield ShopPageLoadedState(shopData: shopData, cartData: cartData);
    }
    if (event is ItemAddingCartEvent) {
      yield ItemAddingCartState(cartItems: event.cartItems, cartData: event.);
    }
    if (event is ItemAddedCartEvent) {
      yield ItemAddedCartState(cartItems: event.cartItems);
    }
    if (event is ItemDeleteCartEvent) {
      yield ItemDeletingCartState(cartItems: event.cartItems);
    }
  }
}
