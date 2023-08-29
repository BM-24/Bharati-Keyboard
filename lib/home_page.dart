import 'package:bharati_keyboard/keyboard.dart';
import 'package:bharati_keyboard/providers/languages.dart';
import 'package:bharati_keyboard/splash_screen.dart';
import 'package:bharati_keyboard/text_window.dart';
import 'package:bharati_keyboard/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      // ),
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                    ),
                    child: const Image(
                      alignment: Alignment.topCenter,
                      image: AssetImage(
                        'images/Banner.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: TextWindow(
                      chosenLanguage:
                          context.watch<Languages>().choosenLanguageIndex,
                    ),
                  ),
                  ToolBar(
                    language: context.watch<Languages>().choosenLanguageIndex,
                    // currentLang: Languages.languageNames[0],
                    currentLang: Languages.languageNames[
                        context.watch<Languages>().choosenLanguageIndex],
                  ),
                  Keyboard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
