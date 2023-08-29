import 'package:bharati_keyboard/providers/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/text_provider.dart';

class TextWindow extends StatefulWidget {
  const TextWindow({super.key, required this.chosenLanguage});

  final int chosenLanguage;

  @override
  State<TextWindow> createState() => _TextWindowState();
}

class _TextWindowState extends State<TextWindow> {
  // Text Controller
  final _controller = TextEditingController();
  String currentLanguage = "";

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<TextProvider>().text;
    debugPrint(widget.chosenLanguage.toString());
    currentLanguage = Languages.languageNames[widget.chosenLanguage];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("Lang : $currentLanguage");
    // debugPrint(widget.chosenLanguage.toString());
    currentLanguage = Languages.languageNames[widget.chosenLanguage];

    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[600],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(12.0),
                child: context.watch<Languages>().mode == 0
                    ? Text(
                        context.watch<TextProvider>().text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28.0,
                          fontFamily: 'NavBharati',
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Hello",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28.0,
                          fontFamily: 'NavBharati',
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.all(12.0),
                child: context.watch<Languages>().mode == 1
                    ? TextField(
                        keyboardType: TextInputType.multiline,
                        controller: _controller,
                        autofocus: true,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter text in $currentLanguage',
                          hintMaxLines: 5000,
                          hintStyle: const TextStyle(
                            fontSize: 28.0,
                            color: Colors.grey,
                          ),
                        ),
                        // context.read<Languages>().getMappedText(context.watch<TextProvider>().text),
                        // KeyBoardChars().getMappedText(context.watch<TextProvider>().text),
                        // context.watch<TextProvider>().text,
                        //'भारति',
                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        context
                            .read<Languages>()
                            .getMappedText(context.watch<TextProvider>().text),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
