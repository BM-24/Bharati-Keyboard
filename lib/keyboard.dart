import 'package:bharati_keyboard/text_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/text_provider.dart';
import 'providers/languages.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key, required this.lang});

  final String lang;

  // 2d Grid of keyboard characters
  //static List<List<String>> charArray = Languages.devaNagariChars;
  static TextWindow tw = const TextWindow();

  Widget getButton(String text, int row, int col, BuildContext context) {
    if (text == 'space') {
      return Container(
        margin: const EdgeInsets.all(2),
        width: 120.0,
        height: 60.0,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[200],
          ),
          onPressed: () {
            context.read<TextProvider>().addText(' ', lang, row, col);
          },
          child: const Text(" "),
        ),
      );
    }
    if (text == '-1') {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(2),
          width: 120.0,
          height: 60.0,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
            ),
            onPressed: () {
              context.read<TextProvider>().removeText();
              Map<String, int> prevKey =
                  context.read<TextProvider>().getLatestKeyPoint();
              int prow = prevKey['row']!;
              int pcol = prevKey['col']!;
              if (context.read<Languages>().getCharacterType(prow, pcol) == 2) {
                context
                    .read<Languages>()
                    .addTopChars(context.read<TextProvider>().getLatestChar());
              } else {
                context.read<Languages>().removeTopChars();
              }
            },
            child: const Icon(
              Icons.backspace_outlined,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ),
      );
    }
    if (text == 'nl') {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(2),
          height: 60.0,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
            ),
            onPressed: () {
              context.read<TextProvider>().addText('\n', lang, row, col);
            },
            child: const Text(""),
          ),
        ),
      );
    }
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(2),
        height: 60.0,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[200],
          ),
          onPressed: () {
            if (text.length > 1) text = text[1];
            context.read<Languages>().removeTopChars();
            context.read<TextProvider>().addText(text, lang, row, col);

            if (context.read<Languages>().getCharacterType(row, col) == 2) {
              context.read<Languages>().addTopChars(text);
            }

            /*if (row == 2 || row == 3){
              if (col > 0){
                if(!(row == 3 && col == 8)){
                  context.read<Languages>().addTopChars(text);
                }
              }
            }*/
            //context.read<Languages>().addTopChars(text);
            //tw.function(text);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'Bharati',
              /* color: context.read()<Languages>().getCharacterType(row, col) == 2
                  ? Colors.deepPurpleAccent
                  : context.read()<Languages>().getCharacterType(row, col) == 1
                      ? Colors.red
                      : Colors.green,*/
              color: (row == 0 || row == 1)
                  ? Colors.red
                  : (col == 0)
                      ? Colors.green
                      : (row == 4 && (col == 2 || col == 4))
                          ? Colors.green
                          : Colors.deepPurpleAccent,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 4.0),
      child: Column(
        children: [
          for (int i = 0;
              i < context.watch<Languages>().getDevaNagariChars().length;
              i++)
            Row(
              children: [
                for (int j = 0;
                    j <
                        context
                            .watch<Languages>()
                            .getDevaNagariChars()[i]
                            .length;
                    j++)
                  getButton(
                      context.watch<Languages>().getDevaNagariChars()[i][j],
                      i,
                      j,
                      context),
              ],
            ),

          // for (var row in charArray)
          //   Row(
          //     children: [
          //       for (var char in row) getButton(char),
          //     ],
          //   ),
        ],
      ),
    );
  }
}
