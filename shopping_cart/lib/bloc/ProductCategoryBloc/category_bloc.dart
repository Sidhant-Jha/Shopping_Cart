import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/ProductCategoryBloc/category_state.dart';
import 'package:shopping_cart/model/data_model.dart';
import 'package:shopping_cart/service/api_service.dart';
import 'package:shopping_cart/bloc/ProductCategoryBloc/category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  CategoryBloc():super(CategoryStateInitial()){
    on<CategoryEventGetSectionProducts>(_onCategoryEventGetSectionProducts);
  }

  final ApiService _apiService = ApiService();

  Future<FutureOr<void>> _onCategoryEventGetSectionProducts(CategoryEventGetSectionProducts event, Emitter<CategoryState> emit) async {
    emit(CategoryStateLoading());
    DataModel? data = await _apiService.getProducts(event.section);
    if(data != null){
      emit(CategoryStateLoadedState(data: data));
    }else{
      emit(CategoryStateError());
    }
  }

}
