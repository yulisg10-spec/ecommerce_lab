import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.person_outline, size: 80.0, color: Color(0xFFC5C5D4)),
            SizedBox(height: 16.0),
            Text(
              'Perfil',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF454652),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Próximamente',
              style: TextStyle(fontSize: 14.0, color: Color(0xFF757684)),
            ),
          ],
        ),
      ),
    );
  }
}
