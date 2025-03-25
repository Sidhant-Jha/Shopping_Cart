import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/ProductBloc/product_bloc.dart';
import 'package:shopping_cart/bloc/ProductBloc/product_event.dart';
import 'package:shopping_cart/bloc/ProductBloc/product_state.dart';
import 'package:shopping_cart/widgets/categories.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductStateLoadingState && state.isFirstLoad) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state is ProductStateErrorState) {
          return Center(child: Text(state.message));
        }
        
        if (state is ProductStateLoadedState) {
          final hasAnyMore = state.hasMore.values.any((hasMore) => hasMore);
          
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollEndNotification) {
                final metrics = scrollNotification.metrics;
                if (metrics.pixels == metrics.maxScrollExtent && hasAnyMore) {
                  for (int i = 0; i < state.categoryListModel.categories.length; i++) {
                    if (state.hasMore[i] == true) {
                      context.read<ProductBloc>().add(
                        ProductEventLoadMoreProducts(categoryIndex: i)
                      );
                    }
                  }
                }
              }
              return false;
            },
            child: ListView.builder(
              itemCount: state.categoryListModel.categories.length + (hasAnyMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.categoryListModel.categories.length) {
                  return SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                
                return Categories(
                  category: state.categoryListModel.categories[index],
                  products: state.data[index]?.products ?? [],
                  hasMore: state.hasMore[index] ?? false,
                  categoryIndex: index,
                );
              },
            ),
          );
        }
        
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}