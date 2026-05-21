import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ...List<Widget>.generate(5, (int index) {
          final double starValue = index + 1.0;
          final IconData iconData;
          if (rating >= starValue) {
            iconData = Icons.star;
          } else if (rating >= starValue - 0.5) {
            iconData = Icons.star_half;
          } else {
            iconData = Icons.star_border;
          }
          return Icon(iconData, color: Colors.amber, size: 20.0);
        }),
        const SizedBox(width: 4.0),
        Text(
          '($reviewCount reviews)',
          style: const TextStyle(fontSize: 14.0, color: Color(0xFF757684)),
        ),
      ],
    );
  }
}
