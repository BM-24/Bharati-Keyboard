import 'package:bharati_keyboard/keyboard.dart';
import 'package:bharati_keyboard/providers/languages.dart';
import 'package:bharati_keyboard/text_window.dart';
import 'package:bharati_keyboard/toolbar.dart';
import 'package:flutter/material.dart';

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
                )),
            // Transform.scale(
            //   scale: 2.0,
            //   child: Image(
            //     image: AssetImage(
            //       'images/Banner.png',
            //     ),
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height * 0.1,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            /*Text(
                  //'हि थिस इस म्य नमे ।',
                  'hello'.tr,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'Bharati',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.updateLocale(const Locale('en', 'US'));
                  },
                  child: const Text('Change Language'),
                ),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your text',
                  ),
                ),*/
            Expanded(child: TextWindow()),
            ToolBar(),
            Keyboard(
              lang: Languages.languageList[0],
            ),
          ],
        ),
      ),
    );
  }
}
