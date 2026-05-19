import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({required this.imagePath, super.key});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ApiEndpoints.buildProductImageUrl(imagePath),
      width: 150,
      height: 150,
      fit: BoxFit.contain,
      placeholder: (BuildContext context, String url) {
        return const CircularProgressIndicator();
      },
      errorWidget: (BuildContext context, String url, Object error) {
        return const Icon(Icons.error);
      },
    );
  }
}
