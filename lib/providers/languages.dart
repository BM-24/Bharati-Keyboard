import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Languages with ChangeNotifier {
  static List<String> languageList = ['अक', 'Hindi', 'Bengali', 'Tamil'];

  static const String devaNagari = 'देवनागरी';
  List<List<String>> devaNagariChars = [
    [
      '\u0905',
      '\u0906',
      '\u0907',
      '\u0908',
      '\u0909',
      '\u090A',
      '\u090B',
      '\u094D',
    ],
    [
      'a',
      '\u090F',
      '\u0910',
      'b',
      '\u0913',
      '\u0914',
      '\u0902',
      '\u0903',
    ],
    [
      '.',
      '\u0915',
      '\u091A',
      '\u091F',
      '\u0924',
      '\u092A',
      '\u0928',
      '\u0923',
    ],
    [
      '|',
      '\u092E',
      '\u092F',
      '\u0930',
      '\u0932',
      '\u0935',
      '\u0938',
      '\u0939',
      '-1',
    ],
    [
      'a',
      '\u091E',
      '_',
      'space',
      '=',
      '\u0919',
      'nl',
    ]
  ];

  List<List<String>> extraDevaNagariChars = [
    [
      ' ',
      '\u093E',
      '\u093F',
      '\u0940',
      '\u0941',
      '\u0942',
      '\u0943',
      '\u094D',
    ],
    [
      ' ',
      '\u0947',
      '\u0948',
      '',
      '\u094B',
      '\u094C',
      '\u0902',
      '\u0903',
    ],
  ];

  List<List<String>> getDevaNagariChars() {
    return devaNagariChars;
  }

  void addTopChars(String char) {
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < devaNagariChars[i].length; j++) {
        String temp = devaNagariChars[i][j];
        devaNagariChars[i][j] = char + extraDevaNagariChars[i][j];
        extraDevaNagariChars[i][j] = temp;
      }
    }
    debugPrint('addTopChars() called for $char');
    notifyListeners();
  }

  void removeTopChars() {
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < devaNagariChars[i].length; j++) {
        if (devaNagariChars[i][j].length > 1) {
          String temp = devaNagariChars[i][j];
          devaNagariChars[i][j] = extraDevaNagariChars[i][j];
          extraDevaNagariChars[i][j] = temp[1];
        }
      }
    }
    notifyListeners();
  }

  int getCharacterType(int row, int col) {
    if (row == 0 || row == 1) {
      return 1;
    }

    if (row == 2) {
      if (col == 0) {
        return 3;
      }
      return 2;
    }

    if (row == 3) {
      if (col == 0) {
        return 3;
      }
      if (col == devaNagariChars[row].length - 1) {
        return -1;
      }
      return 2;
    }

    if (row == 4) {
      if (col == 0) {
        return 3;
      }
      if (col == 1 || col == 5) {
        return 2;
      }
      if(col == 2 || col == 4)
      {
        return 4;
      }
      return -1;
    }

    return -1;
  }
}
