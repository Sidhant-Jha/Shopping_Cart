import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/bloc/CartBloc/shop_event.dart';
import 'package:shopping_cart/bloc/CartBloc/shop_state.dart';
import 'package:shopping_cart/model/products_model.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial()) {
    on<LoadShopData>(_onLoadShopData);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  final Map<ProductsModel, int> _cartItems = {};  // Changed to Map
  List<ProductsModel> _products = [];

  Future<void> _onLoadShopData(
    LoadShopData event,
    Emitter<ShopState> emit,
  ) async {
    emit(ShopLoading());
    try {
      _products = []; // Initialize with empty list
      
      emit(ShopLoaded(
        products: _products,
        cartItems: _cartItems,
        totalPrice: _calculateTotalPrice(),
      ));
    } catch (e) {
      emit(CartError('Failed to load products: ${e.toString()}'));
    }
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<ShopState> emit,
  ) async {
    if (state is! ShopLoaded) return;

    final currentState = state as ShopLoaded;
    emit(CartUpdating(Map.from(_cartItems)));
    
    // Add or increment quantity
    if (_cartItems.containsKey(event.product)) {
      _cartItems[event.product] = _cartItems[event.product]! + 1;
    } else {
      _cartItems[event.product] = 1;
    }
    
    emit(ShopLoaded(
      products: currentState.products,
      cartItems: _cartItems,
      totalPrice: _calculateTotalPrice(),
    ));
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<ShopState> emit,
  ) async {
    if (state is! ShopLoaded) return;

    final currentState = state as ShopLoaded;
    emit(CartUpdating(Map.from(_cartItems)));
    
    if (_cartItems.containsKey(event.product)) {
      if (event.removeAll) {
        _cartItems.remove(event.product);
      } else {
        final currentQuantity = _cartItems[event.product]!;
        if (currentQuantity > 1) {
          _cartItems[event.product] = currentQuantity - 1;
        } else {
          _cartItems.remove(event.product);
        }
      }
    }
    
    emit(ShopLoaded(
      products: currentState.products,
      cartItems: _cartItems,
      totalPrice: _calculateTotalPrice(),
    ));
  }

  Future<void> _onClearCart(
    ClearCart event,
    Emitter<ShopState> emit,
  ) async {
    if (state is! ShopLoaded) return;

    emit(CartUpdating(Map.from(_cartItems)));
    
    _cartItems.clear();
    
    emit(ShopLoaded(
      products: _products,
      cartItems: _cartItems,
      totalPrice: _calculateTotalPrice(),
    ));
  }

  double _calculateTotalPrice() {
    return _cartItems.entries.fold(0, (total, entry) {
      return total + (entry.key.discountPrice * entry.value);
    });
  }
}