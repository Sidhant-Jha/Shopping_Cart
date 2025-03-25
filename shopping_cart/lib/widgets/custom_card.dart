import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/FavouritesCubit/favourites_cubit.dart';
import 'package:shopping_cart/bloc/ProductBloc/product_state.dart';
import 'package:shopping_cart/model/products_model.dart';
import 'package:shopping_cart/view/product_screens/product_information.dart';
import '../bloc/ProductBloc/product_bloc.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.cardWidth,
    required this.product,
  });

  final double cardWidth;
  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductStateLoadedState) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: SizedBox(
              width: cardWidth,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductInformation(product: product)));
                  },
                  child: Card(
                    elevation: 2,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: AspectRatio(
                                aspectRatio: 2,
                                child: Image(
                                  image: NetworkImage(product.thumbnail),
                                  fit: BoxFit.contain,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                  : null,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                width: cardWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.title,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      maxLines: 1,
                                                      product.brand == 'null'
                                                          ? ''
                                                          : product.brand,
                                                      style: const TextStyle(  
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        BlocBuilder<FavouritesCubit, Favourites>(
                                          builder: (context, state) {
                                            return Expanded(
                                              flex: 3,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.transparent,
                                                    shape: BoxShape.circle
                                                ),
                                                child: Center(
                                                  child: IconButton(
                                                    onPressed: () => context.read<FavouritesCubit>().addRemoveFavourites(product),
                                                    icon: state.products.contains(product) ? const Icon(Icons.favorite_rounded) : const Icon(Icons.favorite_outline),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    //   child: Text(
                                    //     '\$${product.discountPrice.toString()}',
                                    //     style: const TextStyle(
                                    //         fontSize: 18,
                                    //         fontWeight: FontWeight.bold),
                                    //   ),
                                      
                                    // ),
                                    Row(
                                      children: [
                                        Text('\$${product.originalPrice.toString()}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            decoration: TextDecoration.lineThrough,
                                            fontSize: 13
                                          ),),
                                        SizedBox(width: 6,),
                                        Text(
                                        '\$${product.discountPrice.toString()}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ],
                                    ),

                                    Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        '${product.discountPercentage}% OFF',
                                        style: TextStyle(
                                          color: Colors.red
                                        ),
                                      ),
                                    )
                                    // SizedBox(height: 200,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 6,
                          bottom: 0.5,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: cardWidth / 2,
                            ),
                            child: TextButton(
                              // style: ButtonStyle(
                              //   backgroundColor: WidgetStateProperty.all(
                              //     const Color(0xFFF58686),
                              //   ),
                              // ),
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF58686),
                                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12), // smaller padding
                                minimumSize: Size(0, 0), // removes default minimum size
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // reduces tap area
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             ProductInformation(product: product)));
                              },
                              child: const Text(
                                'Add',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      return const Text('Loading..');
    });
  }
}
