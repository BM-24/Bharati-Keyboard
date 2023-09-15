import 'package:bharati_keyboard/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_intro/flutter_intro.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// import 'home_page.dart';
import 'providers/languages.dart';
import 'providers/text_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TextProvider()),
        ChangeNotifierProvider(create: (_) => Languages()),
      ],
      // child: Intro(
      //   maskClosable: false,
      //   padding: const EdgeInsets.all(8),
      //   buttonTextBuilder: (order) {
      //     return order == 2 ? 'Finish' : 'Next';
      //   },
      //   child: const MyApp(),
      // ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurple,
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return GetMaterialApp(
      title: 'Bhararti Keyboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Bhararti Keyboard'),
      home: const SplashScreen(),
    );
  }
}
