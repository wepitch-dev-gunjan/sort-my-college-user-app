import 'package:flutter/material.dart';

class PaymentGateAway extends StatelessWidget {
  const PaymentGateAway({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
          "https://miro.medium.com/max/1200/0*Hn1q6W528VUw7kc3.png",
          fit: BoxFit.cover,
          height: 300,
        ),
      ),
    );
  }
}
