import 'package:flutter/material.dart';

class Devanagari 
{
  Devanagari(){
    setDefaultEnabled();
  }
  static const String languageName = 'देवनागरी';

  List<List<String>> characterSet = [
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
      '·',
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
      '| ·',
      '\u091E',
      '_',
      'space',
      '=',
      '\u0919',
      'nl',
    ]
  ];

  List<List<String>> extraCharacterSet = [
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
  List<List<bool>> enabled = [];

  List<List<String>> getCharacterSet() {
    return characterSet;
  }

  List<List<String>> getExtraCharacterSet() {
    return extraCharacterSet;
  }

  List<List<bool>> getEnabled() {
    return enabled;
  }

  void addTopChars(String char) {
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < characterSet[i].length; j++) {
        if (enabled[i][j] == false) continue;
        String temp = characterSet[i][j];
        characterSet[i][j] = char + extraCharacterSet[i][j];
        extraCharacterSet[i][j] = temp;
      }
    }
    debugPrint('addTopChars() called for devanagari $char');
  }

  void removeTopChars() {
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < characterSet[i].length; j++) {
        if (characterSet[i][j].length > 1) {
          if (enabled[i][j] == false) continue;
          String temp = characterSet[i][j];
          characterSet[i][j] = extraCharacterSet[i][j];
          extraCharacterSet[i][j] = temp[1];
        }
      }
    }
    debugPrint('removeTopChars() called for devanagari');
  }

  void setDefaultEnabled() {
    enabled.clear();
    for (int i = 0; i < characterSet.length; i++) {
      List<bool> temp = [];
      for (int j = 0; j < characterSet[i].length; j++) {
        if (j == 0 && i != 0) {
          temp.add(false);
        } else if (i == 1 && j == 3) {
          temp.add(false);
        } else if (i == 4 && (j == 2 || j == 4)) {
          temp.add(false);
        } else {
          temp.add(true);
        }
      }
      enabled.add(temp);
    }
  }

  void updateEnabled(int row, int col) {
    debugPrint("Hello");
    if (row == 2 && col > 0 && col < 6) {
      enabled[2][0] = true;
      enabled[3][0] = true;
      enabled[4][0] = true;
    } else if (row == 3 && (col == 3 || col == 4)) {
      enabled[4][2] = true;
    } else if (row == 3 && col == 6) {
      enabled[4][2] = true;
      enabled[4][4] = true;
    } else {
      setDefaultEnabled();
    }
    debugPrint(enabled[2][0].toString());
  }

  void setNewType3(int row, int col, String char) {
    if (row == 2 && col > 0 && col < 6) {
      String newChar1 = String.fromCharCode(char.codeUnitAt(0) + 1);
      String newChar2 = String.fromCharCode(char.codeUnitAt(0) + 2);
      String newChar3 = String.fromCharCode(char.codeUnitAt(0) + 3);

      characterSet[2][0] = newChar1;
      characterSet[3][0] = newChar2;
      characterSet[4][0] = newChar3;
    } else {
      setDefaultType3();
    }
  }

  void setDefaultType3() {
    characterSet[2][0] = '·';
    characterSet[3][0] = '|';
    characterSet[4][0] = '| ·';
  }

  String getType4(String char, int row, int col, int prevRow, int prevCol) {
    if (row == 4 && col == 4) {
      if (prevRow == 3 && prevCol == 6) {
        return String.fromCharCode(char.codeUnitAt(0) - 1);
      }
    } else {
      if (prevRow == 3 && prevCol == 6) {
        return String.fromCharCode(char.codeUnitAt(0) - 2);
      } else {
        return String.fromCharCode(char.codeUnitAt(0) + 1);
      }
    }
    return char;
  }
}
