import 'package:bharati_keyboard/providers/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'providers/text_provider.dart';

class TextWindow extends StatefulWidget {
  const TextWindow(
      {super.key,
      required this.chosenLanguage,
      required this.screenshotController});

  final int chosenLanguage;
  final ScreenshotController screenshotController;

  @override
  State<TextWindow> createState() => _TextWindowState();
}

class _TextWindowState extends State<TextWindow> {
  // Text Controller
  final _controller = TextEditingController();
  String currentLanguage = "";

  void _textChanged() {
    setState(() {});
    context.read<TextProvider>().setText(_controller.text);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_textChanged);
    _controller.text = context.read<TextProvider>().text;
    // _controller.text = "বাংলা";
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
    // _controller.text = "বাংলা";
    // _controller.text = "ன";
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
                child: context.watch<Languages>().mode ==
                        0 // Indian language to Bharati
                    ? Screenshot(
                        controller: widget.screenshotController,
                        child: Text(
                          context.watch<TextProvider>().text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28.0,
                            fontFamily: 'NavBharati',
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Screenshot(
                        controller: widget.screenshotController,
                        child: Text(
                          context.read<Languages>().getBharatiMapped(
                              _controller.text), // mapped text required
                          // _controller.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28.0,
                            fontFamily: 'NavBharati',
                            color: Colors.white,
                          ),
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
