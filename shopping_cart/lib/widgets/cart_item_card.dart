import 'package:flutter/material.dart';
import 'package:shopping_cart/model/products_model.dart';

class CartItemCard extends StatelessWidget {
  final ProductsModel product;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.thumbnail,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Text('\$${product.originalPrice.toString()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 13
                            ),),
                      Text(
                        '\$${product.discountPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
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
                    ),
                  SizedBox(height: 50,)
                ],
              ),
            ),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: onRemove,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: onDecrease,
                    ),
                    Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: onIncrease,
                    ),
                  ],
                ),
                
              ],
            )
          ],
        ),
      ),
    );
  }
}