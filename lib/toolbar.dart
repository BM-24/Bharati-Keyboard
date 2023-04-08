import 'package:bharati_keyboard/providers/languages.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ToolBar extends StatefulWidget {
  ToolBar({super.key, required this.language});

  int language;
  String language1 = 'भारति';
  List<String> languageList = Languages.languageList;
  List<String> languageNames = Languages.languageNames;

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
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
            widget.language1,
            style: const TextStyle(
              fontFamily: 'Bharati',
              fontSize: 20,
            ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {},
            icon: const Icon(Icons.compare_arrows_rounded),
          ),
          Text(
            widget.languageNames[widget.language],
            style: const TextStyle(
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
