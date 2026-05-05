import 'package:flutter/material.dart';

import '../../product_module.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: SafeArea(
        child: HeaderSearchFieldWidget(
          autofocus: true,
          showBack: true,
          onTap: () {},
        ),
      ),
    );
  }
}
