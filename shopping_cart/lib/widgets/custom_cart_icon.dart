import 'package:flutter/material.dart';

class CustomCartIcon extends StatelessWidget {
  const CustomCartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children : [ 
        IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.shopping_cart_outlined,
          size: 30,
        ),
      ),
      Positioned(
        right: 5,
        top: 2,
        child: Container(
        padding: EdgeInsets.all(0.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(100)
        ),
        constraints: BoxConstraints(
          minHeight: 16,
          minWidth: 16
        ),
        child: Text( '0',
          style: TextStyle(
            color: Colors.white, fontSize: 13
          ),
          textAlign: TextAlign.center,
        ),
      ))
    ]
      
    );
  }
}