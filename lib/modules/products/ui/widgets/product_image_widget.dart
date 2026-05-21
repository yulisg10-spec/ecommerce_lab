import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
  });

  final String imagePath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ApiEndpoints.buildProductImageUrl(imagePath),
      width: width,
      height: height,
      fit: BoxFit.contain,
      placeholder: (BuildContext context, String url) {
        return const Center(
          child: SizedBox(
            width: 32.0,
            height: 32.0,
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ),
        );
      },
      errorWidget: (BuildContext context, String url, Object error) {
        return const Icon(Icons.error);
      },
    );
  }
}
