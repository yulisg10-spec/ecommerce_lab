import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';

class CategoryIconWidget extends StatelessWidget {
  const CategoryIconWidget({
    super.key,
    required this.name,
    required this.iconPath,
    required this.isSelected,
  });

  final String name;
  final String iconPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: isSelected
              ? Colors.indigo[400]
              : Colors.indigo.withAlpha(80),
          radius: 24,
          child: SvgPicture.network(
            ApiEndpoints.buildCategoryIconUrl(iconPath),
            width: 24.0,
            height: 24.0,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          name,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
