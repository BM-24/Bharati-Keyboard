import 'package:bharati_keyboard/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(
            title: 'Bhararti Keyboard',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.deepPurple[500],
      body: Container(
        margin: const EdgeInsets.all(48.0),
        alignment: Alignment.center,
        child: Image.asset(
          'images/onescript.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
