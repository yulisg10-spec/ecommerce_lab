import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class CardProductWidget extends StatelessWidget {
  const CardProductWidget({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  final String name;
  final String price;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.indigo.withAlpha(24),
            ),
            child: CachedNetworkImage(
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
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          name,
          maxLines: 1,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4.0),
        Text(
          price,
          maxLines: 1,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
