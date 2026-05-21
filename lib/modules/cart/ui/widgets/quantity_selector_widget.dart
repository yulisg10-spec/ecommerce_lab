import 'package:flutter/material.dart';

class QuantitySelectorWidget extends StatelessWidget {
  const QuantitySelectorWidget({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
    this.iconSize = 20.0,
    this.buttonPadding = 10.0,
    this.countHorizontalPadding = 16.0,
    this.countVerticalPadding = 8.0,
    this.fontSize = 16.0,
  });

  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final double iconSize;
  final double buttonPadding;
  final double countHorizontalPadding;
  final double countVerticalPadding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _QuantityButton(
          icon: Icons.remove,
          iconSize: iconSize,
          padding: buttonPadding,
          onPressed: onDecrement,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: countHorizontalPadding,
            vertical: countVerticalPadding,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo[200]!, width: 0.5),
          ),
          child: Text(
            '$quantity',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _QuantityButton(
          icon: Icons.add,
          isIncrement: true,
          iconSize: iconSize,
          padding: buttonPadding,
          onPressed: onIncrement,
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.iconSize,
    required this.padding,
    this.isIncrement = false,
    required this.onPressed,
  });

  final IconData icon;
  final double iconSize;
  final double padding;
  final bool isIncrement;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: isIncrement
              ? const BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
          color: Colors.indigo[400],
        ),
        child: Icon(icon, size: iconSize, color: Colors.white),
      ),
    );
  }
}
