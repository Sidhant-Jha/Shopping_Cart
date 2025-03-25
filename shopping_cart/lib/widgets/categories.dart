import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/ProductBloc/product_bloc.dart';
import 'package:shopping_cart/bloc/ProductBloc/product_event.dart';
import 'package:shopping_cart/bloc/ProductCategoryBloc/category_bloc.dart';
import 'package:shopping_cart/bloc/ProductCategoryBloc/category_event.dart';
import 'package:shopping_cart/model/products_model.dart';
import 'package:shopping_cart/view/product_screens/products_screen.dart';
import 'package:shopping_cart/widgets/custom_card.dart';

class Categories extends StatefulWidget {
  const Categories({
    super.key,
    required this.category,
    required this.products,
    required this.hasMore,
    required this.categoryIndex,
  });

  final String category;
  final List<ProductsModel> products;
  final bool hasMore;
  final int categoryIndex;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == 
        _scrollController.position.maxScrollExtent) {
      if (widget.hasMore && !_isLoadingMore) {
        _isLoadingMore = true;
        context.read<ProductBloc>().add(
          ProductEventLoadMoreProducts(categoryIndex: widget.categoryIndex)
        );
        // Reset after a small delay to prevent multiple triggers
        Future.delayed(const Duration(seconds: 1), () => _isLoadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsSectionScreen(
                    category: widget.category,
                  ),
                ),
              );
              context.read<CategoryBloc>().add(
                CategoryEventGetSectionProducts(section: widget.category)
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.category.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 20
                  ),
                ),
                const Icon(Icons.arrow_forward, size: 25),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: height * 0.3,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.products.length + (widget.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == widget.products.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return CustomCard(
                    cardWidth: 200,
                    product: widget.products[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}