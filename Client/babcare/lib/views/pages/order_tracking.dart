import 'package:babcare/theme/style.dart';
import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تابع طلب",
        ),
        foregroundColor: Colors.black,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
    );
  }
}
