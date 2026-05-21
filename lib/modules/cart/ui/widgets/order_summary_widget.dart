import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
  });

  final num subtotal;
  final num deliveryFee;

  @override
  Widget build(BuildContext context) {
    final num total = subtotal + deliveryFee;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: const Border(
          left: BorderSide(color: Color(0xFF3F51B5), width: 4.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(
                Icons.receipt_long_outlined,
                color: Color(0xFF3F51B5),
                size: 22.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Detalle del pago',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C1D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _SummaryRow(
            label: 'Subtotal',
            value: '\$${subtotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8.0),
          _SummaryRow(
            label: 'Valor de entrega',
            value: '\$${deliveryFee.toStringAsFixed(2)}',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(color: Color(0xFFC5C5D4), height: 1.0),
          ),
          _SummaryRow(
            label: 'Total',
            value: '\$${total.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.0 : 14.0,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
            color: isTotal ? const Color(0xFF191C1D) : const Color(0xFF757684),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18.0 : 14.0,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
            color: isTotal ? const Color(0xFF3F51B5) : const Color(0xFF191C1D),
          ),
        ),
      ],
    );
  }
}
