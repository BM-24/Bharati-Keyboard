import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

//import 'LocaleString.dart';
import 'home_page.dart';
import 'providers/languages.dart';
import 'providers/text_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => TextProvider()),
    ChangeNotifierProvider(create: (_) => Languages()),
  ], child: const MyApp()));
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
      //translations: LocaleString(),
      //locale: const Locale('hi', 'IN'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bhararti Keyboard'),
    );
  }
}
