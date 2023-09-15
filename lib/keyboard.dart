import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:provider/provider.dart';
import 'providers/text_provider.dart';
import 'providers/languages.dart';

class Keyboard extends StatelessWidget {
  Keyboard({super.key});

  //final int lang;

  // 2d Grid of keyboard characters
  //static List<List<String>> charArray = Languages.devaNagariChars;

  /*bool firstInit = true;

  void setUp(BuildContext context) {
    if (firstInit) {
      firstInit = false;
      context.read<Languages>().setChoosenLanguageIndex(lang);
      debugPrint('Keyboard: setUp: lang: $lang');
    }
  }*/

  Widget getButton(String text, int row, int col, BuildContext context) {
    if (text == 'space') {
      return Container(
        margin: const EdgeInsets.all(2),
        width: 120.0,
        height: 60.0,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[300],
            disabledBackgroundColor: Colors.grey[200],
          ),
          onPressed: () {
            // HapticFeedback.heavyImpact();
            Vibrate.feedback(FeedbackType.medium);
            context.read<Languages>().removeTopChars();
            context.read<TextProvider>().addText(' ', row, col);
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
              backgroundColor: Colors.grey[300],
            ),
            onPressed: () {
              // HapticFeedback.heavyImpact();
              // if (await Vibration.hasVibrator() == true) {
              //   Vibration.vibrate();
              // }
              Vibrate.feedback(FeedbackType.medium);

              context.read<Languages>().removeTopChars();
              context.read<TextProvider>().removeText();
              Map<String, int> prevKey =
                  context.read<TextProvider>().getLatestKeyPoint();
              int prow = prevKey['row']!;
              int pcol = prevKey['col']!;
              String prevText = context.read<TextProvider>().getLatestChar();

              if (context.read<Languages>().getCharacterType(prow, pcol) == 2) {
                context
                    .read<Languages>()
                    .addTopChars(context.read<TextProvider>().getLatestChar());
              }

              context.read<Languages>().updateEnabled(prow, pcol);
              context.read<Languages>().updateType3(prow, pcol, prevText);
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
              backgroundColor: Colors.grey[300],
            ),
            onPressed: () {
              // HapticFeedback.heavyImpact();
              Vibrate.feedback(FeedbackType.medium);
              context.read<Languages>().removeTopChars();
              context.read<TextProvider>().addText('\n', row, col);
              context.read<Languages>().updateEnabled(row, col);
            },
            child: const Icon(
              Icons.keyboard_return_outlined,
              color: Colors.deepPurpleAccent,
            ),
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
            backgroundColor: Colors.grey[300],
            disabledBackgroundColor: Colors.grey[200],
          ),
          onPressed: !context.watch<Languages>().isEnabled[row][col]
              ? null
              : () {
                  // HapticFeedback.heavyImpact();
                  Vibrate.feedback(FeedbackType.medium);
                  int type =
                      context.read<Languages>().getCharacterType(row, col);
                  if (type == 3) {
                    context.read<Languages>().removeTopChars();
                    String prevChar =
                        context.read<TextProvider>().getLatestChar();
                    Map<String, int> prevKey =
                        context.read<TextProvider>().getLatestKeyPoint();
                    context.read<TextProvider>().removeText();
                    context
                        .read<TextProvider>()
                        .addText(text, prevKey['row']!, prevKey['col']!);
                    context.read<Languages>().addTopChars(text);
                  }

                  if (type == 4) {
                    context.read<Languages>().removeTopChars();
                    String prevChar =
                        context.read<TextProvider>().getLatestChar();
                    Map<String, int> prevKey =
                        context.read<TextProvider>().getLatestKeyPoint();
                    context.read<TextProvider>().removeText();
                    text = context.read<Languages>().getType4Char(
                        row, col, prevChar, prevKey['row']!, prevKey['col']!);
                    debugPrint("text: $text");
                    context
                        .read<TextProvider>()
                        .addText(text, prevKey['row']!, prevKey['col']!);
                    context.read<Languages>().addTopChars(text);
                  }

                  if (type == 2) {
                    context.read<Languages>().removeTopChars();
                    context.read<TextProvider>().addText(text, row, col);
                    context.read<Languages>().addTopChars(text);
                  }

                  if (type == 1) {
                    if (row == 0 && col == 0) {
                      context.read<Languages>().removeTopChars();
                      if (text.length == 1) {
                        context.read<TextProvider>().addText(text, row, col);
                      }
                    } else {
                      context.read<Languages>().removeTopChars();
                      if (text.length > 1) text = text[1];
                      context.read<TextProvider>().addText(text, row, col);
                    }
                  }

                  context.read<Languages>().updateEnabled(row, col);
                  context.read<Languages>().updateType3(row, col, text);
                },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'NavBharati',
              fontWeight: FontWeight.bold,
              color: (row == 0 || row == 1)
                  ? Colors.red.withOpacity(
                      context.watch<Languages>().isEnabled[row][col] ? 1 : 0.5)
                  : (col == 0)
                      ? Colors.green.withOpacity(
                          context.watch<Languages>().isEnabled[row][col]
                              ? 1
                              : 0.5)
                      : (row == 4 && (col == 2 || col == 4))
                          ? Colors.green.withOpacity(
                              context.watch<Languages>().isEnabled[row][col]
                                  ? 1
                                  : 0.5)
                          : Colors.deepPurpleAccent.withOpacity(
                              context.watch<Languages>().isEnabled[row][col]
                                  ? 1
                                  : 0.5),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //setUp(context);
    return Container(
      margin:
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 4.0),
      child: context.watch<Languages>().mode == 1
          ? Container()
          : Column(
              children: [
                for (int i = 0;
                    i < context.watch<Languages>().getCharacterSet().length;
                    // i < KeyBoardChars().keyboardChars.length;
                    //i < Bengali().bengaliChars.length;
                    i++)
                  Row(
                    children: [
                      for (int j = 0;
                          j <
                              context
                                  .watch<Languages>()
                                  .getCharacterSet()[i]
                                  .length;
                          //j < KeyBoardChars().keyboardChars[i].length;
                          //j < Bengali().bengaliChars[i].length;
                          j++)
                        getButton(
                          context.watch<Languages>().getCharacterSet()[i][j],
                          //KeyBoardChars().keyboardChars[i][j],
                          i,
                          j,
                          context,
                        ),
                      //getButton(Bengali().bengaliChars[i][j], i, j, context),
                    ],
                  ),
              ],
            ),
    );
  }
}
