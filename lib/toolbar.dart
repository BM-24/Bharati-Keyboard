import 'package:bharati_keyboard/providers/languages.dart';
import 'package:bharati_keyboard/providers/text_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ToolBar extends StatefulWidget {
  ToolBar({super.key, required this.language, required this.currentLang});

  int language;
  String currentLang;
  List<String> languageList = Languages.languageList;
  List<String> languageNames = Languages.languageNames;
  // int mode = 0;

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  String bharatiLanguage = "";
  String currentLanguage = "";
  int mode = 0;

  @override
  void initState() {
    super.initState();
    bharatiLanguage = 'भारति';
    currentLanguage = widget.currentLang;
    // mode = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 4.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.orange[300],
        //borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              // Share the app link
              Share.share(
                  'Checkout this awesome bharati keyboard app at: <APP LINK>');
            },
            icon: const Icon(Icons.share),
          ),
          Text(
            bharatiLanguage,
            style: mode == 0
                ? const TextStyle(
                    fontFamily: 'NavBharati',
                    fontSize: 20,
                  )
                : const TextStyle(
                    fontSize: 20,
                  ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                mode = (mode + 1) % 2;
                context.read<Languages>().setMode(mode);

                String temp = bharatiLanguage;
                bharatiLanguage = currentLanguage;
                currentLanguage = temp;
              });
            },
            icon: const Icon(Icons.compare_arrows_rounded),
          ),
          Text(
            currentLanguage,
            // widget.languageNames[widget.language],
            style: mode == 1
                ? const TextStyle(
                    fontFamily: 'NavBharati',
                    fontSize: 20,
                  )
                : const TextStyle(
                    fontSize: 20,
                  ),
          ),
          // Drop down menu
          DropdownButton<String>(
            value: widget.languageList[widget.language],
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            alignment: Alignment.center,
            underline: Container(
              height: 2,
              color: Colors.grey,
            ),
            onChanged: (String? newValue) {
              setState(() {
                widget.language = widget.languageList.indexOf(newValue!);
                context
                    .read<Languages>()
                    .setChoosenLanguageIndex(widget.language);

                if (mode == 1) {
                  bharatiLanguage = widget.languageNames[widget.language];
                } else {
                  currentLanguage = widget.languageNames[widget.language];
                  widget.currentLang = currentLanguage;
                }

                // debugPrint(currentLanguage);
                // debugPrint(bharatiLanguage);
                // debugPrint("mode : $mode");

                context.read<TextProvider>().setText("");

                debugPrint("Mode : ${context.read<Languages>().mode}");
              });
            },
            items: widget.languageList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
          ),

          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {},
            icon: const Icon(Icons.help),
          ),
        ],
      ),
    );
  }
}
