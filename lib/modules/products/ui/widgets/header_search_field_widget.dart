import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderSearchFieldWidget extends StatelessWidget {
  const HeaderSearchFieldWidget({
    super.key,
    this.autofocus = true,
    this.readOnly = false,
    this.canRequestFocus = true,
    this.showBack = false,
    this.controller,
    this.onTap,
    this.onFieldSubmitted,
    this.onSuffixIconPressed,
  });

  final bool autofocus;
  final bool readOnly;
  final bool canRequestFocus;
  final bool showBack;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onSuffixIconPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Row(
        children: <Widget>[
          Visibility(
            visible: showBack,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                child: const Icon(Icons.arrow_back, size: 32.0),
                onTap: () => context.pop(),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              onTap: onTap,
              onFieldSubmitted: onFieldSubmitted,
              controller: controller,
              autofocus: autofocus,
              readOnly: readOnly,
              canRequestFocus: canRequestFocus,
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: const Icon(Icons.shopping_bag_outlined),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: onSuffixIconPressed,
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  borderSide: BorderSide(color: Colors.white, width: 20),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  borderSide: BorderSide(color: Colors.white, width: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
