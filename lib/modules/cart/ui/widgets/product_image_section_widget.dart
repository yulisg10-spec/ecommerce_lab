import 'package:ecommerce_lab/modules/products/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      color: Colors.indigo.withAlpha(24),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24.0),
      child: imagePath.isEmpty
          ? const Icon(
              Icons.image_not_supported_outlined,
              size: 80.0,
              color: Color(0xFF757684),
            )
          : ProductImageWidget(
              imagePath: imagePath,
              width: double.infinity,
              height: double.infinity,
            ),
    );
  }
}
