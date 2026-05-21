import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_lab/core/api/api_endpoints.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/cart_item_entity.dart';
import 'quantity_selector_widget.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onDecrement,
    required this.onIncrement,
  });

  final CartItemEntity item;
  final VoidCallback onRemove;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ProductThumbnail(imagePath: item.imagePath),
          const SizedBox(width: 16.0),
          Expanded(
            child: _ItemDetails(
              item: item,
              onRemove: onRemove,
              onDecrement: onDecrement,
              onIncrement: onIncrement,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductThumbnail extends StatelessWidget {
  const _ProductThumbnail({required this.imagePath});

  final String imagePath;

  String _resolveUrl(String path) {
    if (path.isEmpty) return '';
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    return ApiEndpoints.buildProductImageUrl(path);
  }

  @override
  Widget build(BuildContext context) {
    final String url = _resolveUrl(imagePath);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 84.0,
        height: 84.0,
        color: const Color(0xFFF3F4F5),
        padding: const EdgeInsets.all(8.0),
        child: url.isEmpty
            ? const Icon(
                Icons.image_not_supported_outlined,
                color: Color(0xFF757684),
              )
            : CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.contain,
                placeholder: (BuildContext context, String url) {
                  return const Center(
                    child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    ),
                  );
                },
                errorWidget: (BuildContext context, String url, Object error) =>
                    const Icon(
                  Icons.image_not_supported_outlined,
                  color: Color(0xFF757684),
                ),
              ),
      ),
    );
  }
}

class _ItemDetails extends StatelessWidget {
  const _ItemDetails({
    required this.item,
    required this.onRemove,
    required this.onDecrement,
    required this.onIncrement,
  });

  final CartItemEntity item;
  final VoidCallback onRemove;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                item.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1D),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(
                Icons.delete,
                color: Color(0xFFBA1A1A),
                size: 22.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '\$${(item.price * item.quantity).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF191C1D),
              ),
            ),
            QuantitySelectorWidget(
              quantity: item.quantity,
              onDecrement: onDecrement,
              onIncrement: onIncrement,
              iconSize: 16.0,
              buttonPadding: 7.0,
              countHorizontalPadding: 10.0,
              countVerticalPadding: 5.0,
              fontSize: 13.0,
            ),
          ],
        ),
      ],
    );
  }
}
