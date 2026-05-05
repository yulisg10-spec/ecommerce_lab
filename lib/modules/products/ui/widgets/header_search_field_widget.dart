import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderSearchFieldWidget extends StatelessWidget {
  const HeaderSearchFieldWidget({
    super.key,
    this.onTap,
    this.autofocus = true,
    this.readOnly = false,
    this.canRequestFocus = true,
    this.showBack = false,
  });

  final VoidCallback? onTap;
  final bool autofocus;
  final bool readOnly;
  final bool canRequestFocus;
  final bool showBack;

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
              autofocus: autofocus,
              readOnly: readOnly,
              canRequestFocus: canRequestFocus,
              decoration: const InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: Icon(Icons.shopping_bag_outlined),
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  borderSide: BorderSide(color: Colors.white, width: 20),
                ),

                focusedBorder: OutlineInputBorder(
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
