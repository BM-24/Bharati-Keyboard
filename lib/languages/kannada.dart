import 'keyboard_chars.dart';
import 'package:flutter/material.dart';

class Kannada {
  Kannada() {
    setDefaultEnabled();
  }

  static const String languageName = 'ಕನ್ನಡ';
  List<List<String>> characterSet = KeyBoardChars().characterSet;
  List<List<String>> extraCharacterSet = KeyBoardChars().extraCharacterSet;

  List<String> kannada = KeyBoardChars().kan;
  List<String> kannada_tel = KeyBoardChars().kantel;

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

  void setDefaultEnabled() {
    enabled.clear();
    for (int i = 0; i < characterSet.length; i++) {
      List<bool> temp = [];
      for (int j = 0; j < characterSet[i].length; j++) {
        if (j == 0 && i > 1) {
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

  String getMappedText(String text) {
    String ans = '';
    for (int i = 0; i < text.length; i++) {
      int index = kannada_tel.indexOf(text[i]);
      if (index == -1) {
        debugPrint("ERROR : Character not mapped $text[i]");
        ans += text[i];
      } else {
        ans += kannada[index];
      }
    }
    debugPrint('getMappedText() called for kannada $ans');
    return ans;
  }

  String getBharatiMapped(String text) {
    String ans = "";
    for (int i = 0; i < text.length; i++) {
      int index = kannada.indexOf(text[i]);
      if (index == -1) {
        ans += text[i];
      } else {
        ans += kannada_tel[index];
      }
    }
    return ans;
  }

  void addTopChars(String char) {
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < characterSet[i].length; j++) {
        // if (enabled[i][j] == false) continue;
        String temp = characterSet[i][j];
        characterSet[i][j] = char + extraCharacterSet[i][j];
        extraCharacterSet[i][j] = temp;
      }
    }
    debugPrint('addTopChars() called for kannada $char');
  }

  void removeTopChars() {
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < characterSet[i].length; j++) {
        if (characterSet[i][j].length > 1) {
          // if (enabled[i][j] == false) continue;
          String temp = characterSet[i][j];
          characterSet[i][j] = extraCharacterSet[i][j];
          extraCharacterSet[i][j] = temp[1];
        }
      }
    }
    debugPrint('removeTopChars() called for kannada');
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
