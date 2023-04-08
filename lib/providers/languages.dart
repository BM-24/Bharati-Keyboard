import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bharati_keyboard/languages/devanagari.dart';
import 'package:bharati_keyboard/languages/bengali.dart';

class Languages with ChangeNotifier {
  static List<String> languageList = [
    'अक',
    'அக',
    'అక',
    'ಅಕ',
    'അക',
    'অক',
    'ਅਕ',
    'અક',
    'ଅକ'
  ];

  // Devanagari, Tamil, Telugu, Kanada, Malayalam, Bengali, Gurmukhi, Gujarati, Odia
  static List<String> languageNames = [
    'देवनागरी',
    'தமிழ்',
    'తెలుగు',
    'ಕನ್ನಡ',
    'മലയാളം',
    'বাংলা',
    'ਗੁਰਮੁਖਿ',
    'ગુજરાતી',
    'ଓଡ଼ିଆ'
  ];

  int _choosenLanguageIndex = 0;

  List<List<String>> characterSet = [];
  List<List<String>> extraCharacterSet = [];
  List<List<bool>> isEnabled = [];

  Devanagari devanagari = Devanagari();
  Bengali bengali = Bengali();

  List<List<String>> getCharacterSet() {
    return devanagari.getCharacterSet();
  }

  List<List<String>> getExtraCharacterSet() {
    return devanagari.getExtraCharacterSet();
  }

  int get choosenLanguageIndex => _choosenLanguageIndex;

  void setChoosenLanguageIndex(int index) {
    _choosenLanguageIndex = index;
    if (_choosenLanguageIndex == 0) {
      characterSet = devanagari.getCharacterSet();
      extraCharacterSet = devanagari.getExtraCharacterSet();
      devanagari.setDefaultEnabled();
      isEnabled = devanagari.getEnabled();
    }
    //notifyListeners();
  }

  void addTopChars(String char) {
    if (_choosenLanguageIndex == 0) {
      devanagari.addTopChars(char);
      characterSet = devanagari.getCharacterSet();
      extraCharacterSet = devanagari.getExtraCharacterSet();
    }
    notifyListeners();
  }

  void removeTopChars() {
    if (_choosenLanguageIndex == 0) {
      devanagari.removeTopChars();
      characterSet = devanagari.getCharacterSet();
      extraCharacterSet = devanagari.getExtraCharacterSet();
    }
    notifyListeners();
  }

  String getType4Char(int row, int col, String char, int prevRow, int prevCol) {
    if (_choosenLanguageIndex == 0) {
      return devanagari.getType4(char, row, col, prevRow, prevCol);
    }
    return char;
  }

  void updateType3(int row, int col, String char) {
    if (_choosenLanguageIndex == 0) {
      devanagari.setNewType3(row, col, char);
      characterSet = devanagari.getCharacterSet();
      extraCharacterSet = devanagari.getExtraCharacterSet();
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
      if (col == characterSet[row].length - 1) {
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
      if (col == 2 || col == 4) {
        return 4;
      }
      return -1;
    }

    return -1;
  }

  void updateEnabled(int row, int col) {
    if (_choosenLanguageIndex == 0) {
      devanagari.updateEnabled(row, col);
      isEnabled = devanagari.getEnabled();
      debugPrint(isEnabled[2][0].toString());
    }
    notifyListeners();
  }
}
