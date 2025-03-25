import 'package:shopping_cart/model/category_list_model.dart';
import 'package:shopping_cart/model/data_model.dart';

class ProductState {}

class ProductStateLoadingState extends ProductState {
  final bool isFirstLoad;
  ProductStateLoadingState({this.isFirstLoad = true});
}

class ProductStateLoadedState extends ProductState {
  final Map<int, DataModel> data;
  final CategoryListModel categoryListModel;
  final Map<int, bool> hasMore; 
  final Map<int, int> currentPage;

  ProductStateLoadedState({
    required this.categoryListModel,
    required this.data,
    required this.hasMore,
    required this.currentPage,
  });

  ProductStateLoadedState copyWith({
    Map<int, DataModel>? data,
    Map<int, bool>? hasMore,
    Map<int, int>? currentPage,
  }) {
    return ProductStateLoadedState(
      categoryListModel: categoryListModel,
      data: data ?? this.data,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class ProductStateErrorState extends ProductState {
  final String message;
  ProductStateErrorState({required this.message});
}
