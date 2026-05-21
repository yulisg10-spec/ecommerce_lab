import 'package:flutter/material.dart';

class EmptyCategoryWidget extends StatelessWidget {
  const EmptyCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.inventory_2_outlined,
            size: 80.0,
            color: Color(0xFFC5C5D4),
          ),
          SizedBox(height: 16.0),
          Text(
            'Sin productos disponibles',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF454652),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'No hay productos en esta categoría',
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
