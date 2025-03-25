import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/ProductBloc/product_event.dart';
import 'package:shopping_cart/bloc/ProductBloc/product_state.dart';
import 'package:shopping_cart/model/category_list_model.dart';
import 'package:shopping_cart/model/data_model.dart';
import 'package:shopping_cart/service/api_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductStateLoadingState()) {
    on<ProductEventGetInitialProducts>(_onGetInitialProducts);
    on<ProductEventLoadMoreProducts>(_onLoadMoreProducts);
  }

  final ApiService _apiService = ApiService();
  final int _perPage = 5; 

  FutureOr<void> _onGetInitialProducts(
      ProductEventGetInitialProducts event, Emitter<ProductState> emit) async {
    emit(ProductStateLoadingState(isFirstLoad: true));
    
    try {
      CategoryListModel? categoriesList = await _apiService.getCategoryList();

      if (categoriesList != null) {
        Map<int, DataModel> map = {};
        Map<int, bool> hasMore = {};
        Map<int, int> currentPage = {};

        for (int i = 0; i < categoriesList.categories.length; i++) {
          String section = categoriesList.categories[i];
          DataModel? dataModel = await _apiService.getProductsByCategory(section, limit: _perPage);
          if (dataModel != null) {
            map[i] = dataModel;
            hasMore[i] = dataModel.products.length == _perPage;
            currentPage[i] = 1;
          }
        }

        emit(ProductStateLoadedState(
          categoryListModel: categoriesList,
          data: map,
          hasMore: hasMore,
          currentPage: currentPage,
        ));
      } else {
        emit(ProductStateErrorState(message: 'Failed to load categories'));
      }
    } catch (e) {
      emit(ProductStateErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _onLoadMoreProducts(
      ProductEventLoadMoreProducts event, Emitter<ProductState> emit) async {
    if (state is! ProductStateLoadedState) return;

    final currentState = state as ProductStateLoadedState;
    final categoryIndex = event.categoryIndex;

    if (!currentState.hasMore[categoryIndex]!) return;

    emit(ProductStateLoadingState(isFirstLoad: false));

    try {
      final nextPage = currentState.currentPage[categoryIndex]! + 1;
      final section = currentState.categoryListModel.categories[categoryIndex];
      
      DataModel? newData = await _apiService.getProductsByCategory(
        section,
        limit: _perPage,
        skip: (nextPage - 1) * _perPage,
      );

      if (newData != null) {
        final updatedData = Map<int, DataModel>.from(currentState.data);
        updatedData[categoryIndex] = DataModel(
          products: [
            ...currentState.data[categoryIndex]!.products,
            ...newData.products
          ],
          total: newData.total,
          skip: newData.skip,
          limit: newData.limit,
        );
        
        emit(currentState.copyWith(
          data: updatedData,
          hasMore: {
            ...currentState.hasMore,
            categoryIndex: newData.products.length == _perPage
          },
          currentPage: {
            ...currentState.currentPage,
            categoryIndex: nextPage
          },
        ));
      }
    } catch (e) {
      emit(ProductStateErrorState(message: e.toString()));
    }
  }
}