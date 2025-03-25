abstract class ProductEvent {}

class ProductEventGetInitialProducts extends ProductEvent {}

class ProductEventLoadMoreProducts extends ProductEvent {
  final int categoryIndex;
  ProductEventLoadMoreProducts({required this.categoryIndex});
}