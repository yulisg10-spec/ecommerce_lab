import 'package:flutter/material.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.shopping_cart_outlined,
            size: 80.0,
            color: Color(0xFFC5C5D4),
          ),
          SizedBox(height: 16.0),
          Text(
            'Tu carrito está vacío',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF454652),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Agrega productos para comenzar',
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF757684),
            ),
          ),
        ],
      ),
    );
  }
}
