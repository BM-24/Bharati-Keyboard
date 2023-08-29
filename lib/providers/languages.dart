import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../languages/tamil.dart';
import '../languages/telugu.dart';
import '../languages/kannada.dart';
import '../languages/odia.dart';
import '../languages/gujarati.dart';
import '../languages/gurmukhi.dart';
import '../languages/malayalam.dart';
import '../languages/devanagari.dart';
import '../languages/bengali.dart';

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

  // Devanagari, Tamil, Telugu, Kannada, Malayalam, Bengali, Gurmukhi, Gujarati, Odia
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

  Devanagari devanagari = Devanagari();
  Bengali bengali = Bengali();
  Telugu telugu = Telugu();
  Tamil tamil = Tamil();
  Kannada kannada = Kannada();
  Malayalam malayalam = Malayalam();
  Gurmukhi gurmukhi = Gurmukhi();
  Gujarati gujarati = Gujarati();
  Odia odia = Odia();

  int _mode = 0;

  int _choosenLanguageIndex = 0;
  List<List<String>> characterSet = Devanagari().getCharacterSet();
  List<List<String>> extraCharacterSet = Devanagari().getExtraCharacterSet();
  List<List<bool>> isEnabled = Devanagari().getEnabled();

  int get mode => _mode;

  void setMode(int mode) {
    _mode = mode;
    notifyListeners();
  }

  String getMappedText(String text) {
    if (_choosenLanguageIndex == 0) {
      return devanagari.getMappedText(text);
    } else if (_choosenLanguageIndex == 1) {
      return tamil.getMappedText(text);
    } else if (_choosenLanguageIndex == 2) {
      return telugu.getMappedText(text);
    } else if (_choosenLanguageIndex == 3) {
      return kannada.getMappedText(text);
    } else if (_choosenLanguageIndex == 4) {
      return malayalam.getMappedText(text);
    } else if (_choosenLanguageIndex == 5) {
      return bengali.getMappedText(text);
    } else if (_choosenLanguageIndex == 6) {
      return gurmukhi.getMappedText(text);
    } else if (_choosenLanguageIndex == 7) {
      return gujarati.getMappedText(text);
    } else if (_choosenLanguageIndex == 8) {
      return odia.getMappedText(text);
    }

    return text;
  }

  List<List<String>> getCharacterSet() {
    if (_choosenLanguageIndex == 0) {
      return devanagari.getCharacterSet();
    } else if (_choosenLanguageIndex == 1) {
      return tamil.getCharacterSet();
    } else if (_choosenLanguageIndex == 2) {
      return telugu.getCharacterSet();
    } else if (_choosenLanguageIndex == 3) {
      return kannada.getCharacterSet();
    } else if (_choosenLanguageIndex == 4) {
      return malayalam.getCharacterSet();
    } else if (_choosenLanguageIndex == 5) {
      return bengali.getCharacterSet();
    } else if (_choosenLanguageIndex == 6) {
      return gurmukhi.getCharacterSet();
    } else if (_choosenLanguageIndex == 7) {
      return gujarati.getCharacterSet();
    } else {
      return odia.getCharacterSet();
    }
  }

  List<List<String>> getExtraCharacterSet() {
    if (_choosenLanguageIndex == 0) {
      return devanagari.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 1) {
      return tamil.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 2) {
      return telugu.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 3) {
      return kannada.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 4) {
      return malayalam.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 5) {
      return bengali.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 6) {
      return gurmukhi.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 7) {
      return gujarati.getExtraCharacterSet();
    } else {
      return odia.getExtraCharacterSet();
    }
  }

  int get choosenLanguageIndex => _choosenLanguageIndex;

  // void setChoosenLanguageIndex(int index) {
  //   bengali.setDefaultEnabled();
  //   isEnabled = bengali.getEnabled();
  //   notifyListeners();
  // }

  void setChoosenLanguageIndex(int index) {
    _choosenLanguageIndex = index;
    if (_choosenLanguageIndex == 0) {
      characterSet = devanagari.getCharacterSet();
      extraCharacterSet = devanagari.getExtraCharacterSet();
      devanagari.setDefaultEnabled();
      isEnabled = devanagari.getEnabled();
    } else if (_choosenLanguageIndex == 5) {
      characterSet = bengali.getCharacterSet();
      extraCharacterSet = bengali.getExtraCharacterSet();
      bengali.setDefaultEnabled();
      isEnabled = bengali.getEnabled();
    } else if (_choosenLanguageIndex == 2) {
      characterSet = telugu.getCharacterSet();
      extraCharacterSet = telugu.getExtraCharacterSet();
      telugu.setDefaultEnabled();
      isEnabled = telugu.getEnabled();
    } else if (_choosenLanguageIndex == 1) {
      characterSet = tamil.getCharacterSet();
      extraCharacterSet = tamil.getExtraCharacterSet();
      tamil.setDefaultEnabled();
      isEnabled = tamil.getEnabled();
    } else if (_choosenLanguageIndex == 3) {
      characterSet = kannada.getCharacterSet();
      extraCharacterSet = kannada.getExtraCharacterSet();
      kannada.setDefaultEnabled();
      isEnabled = kannada.getEnabled();
    } else if (_choosenLanguageIndex == 4) {
      characterSet = malayalam.getCharacterSet();
      extraCharacterSet = malayalam.getExtraCharacterSet();
      malayalam.setDefaultEnabled();
      isEnabled = malayalam.getEnabled();
    } else if (_choosenLanguageIndex == 6) {
      characterSet = gurmukhi.getCharacterSet();
      extraCharacterSet = gurmukhi.getExtraCharacterSet();
      gurmukhi.setDefaultEnabled();
      isEnabled = gurmukhi.getEnabled();
    } else if (_choosenLanguageIndex == 7) {
      characterSet = gujarati.getCharacterSet();
      extraCharacterSet = gujarati.getExtraCharacterSet();
      gujarati.setDefaultEnabled();
      isEnabled = gujarati.getEnabled();
    } else if (_choosenLanguageIndex == 8) {
      characterSet = odia.getCharacterSet();
      extraCharacterSet = odia.getExtraCharacterSet();
      odia.setDefaultEnabled();
      isEnabled = odia.getEnabled();
    }
    notifyListeners();
  }

  void addTopChars(String char) {
    if (_choosenLanguageIndex == 0) {
      devanagari.addTopChars(char);
      characterSet = devanagari.getCharacterSet();
      extraCharacterSet = devanagari.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 1) {
      tamil.addTopChars(char);
      characterSet = tamil.getCharacterSet();
      extraCharacterSet = tamil.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 2) {
      telugu.addTopChars(char);
      characterSet = telugu.getCharacterSet();
      extraCharacterSet = telugu.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 3) {
      kannada.addTopChars(char);
      characterSet = kannada.getCharacterSet();
      extraCharacterSet = kannada.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 4) {
      malayalam.addTopChars(char);
      characterSet = malayalam.getCharacterSet();
      extraCharacterSet = malayalam.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 5) {
      bengali.addTopChars(char);
      characterSet = bengali.getCharacterSet();
      extraCharacterSet = bengali.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 6) {
      gurmukhi.addTopChars(char);
      characterSet = gurmukhi.getCharacterSet();
      extraCharacterSet = gurmukhi.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 7) {
      gujarati.addTopChars(char);
      characterSet = gujarati.getCharacterSet();
      extraCharacterSet = gujarati.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 8) {
      odia.addTopChars(char);
      characterSet = odia.getCharacterSet();
      extraCharacterSet = odia.getExtraCharacterSet();
    }
    notifyListeners();
  }

  void removeTopChars() {
    if (_choosenLanguageIndex == 0) {
      devanagari.removeTopChars();
      characterSet = devanagari.getCharacterSet();
      extraCharacterSet = devanagari.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 1) {
      tamil.removeTopChars();
      characterSet = tamil.getCharacterSet();
      extraCharacterSet = tamil.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 2) {
      telugu.removeTopChars();
      characterSet = telugu.getCharacterSet();
      extraCharacterSet = telugu.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 3) {
      kannada.removeTopChars();
      characterSet = kannada.getCharacterSet();
      extraCharacterSet = kannada.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 4) {
      malayalam.removeTopChars();
      characterSet = malayalam.getCharacterSet();
      extraCharacterSet = malayalam.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 5) {
      bengali.removeTopChars();
      characterSet = bengali.getCharacterSet();
      extraCharacterSet = bengali.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 6) {
      gurmukhi.removeTopChars();
      characterSet = gurmukhi.getCharacterSet();
      extraCharacterSet = gurmukhi.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 7) {
      gujarati.removeTopChars();
      characterSet = gujarati.getCharacterSet();
      extraCharacterSet = gujarati.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 8) {
      odia.removeTopChars();
      characterSet = odia.getCharacterSet();
      extraCharacterSet = odia.getExtraCharacterSet();
    }
    notifyListeners();
  }

  String getType4Char(int row, int col, String char, int prevRow, int prevCol) {
    if (_choosenLanguageIndex == 0) {
      return devanagari.getType4(char, row, col, prevRow, prevCol);
    } else if (_choosenLanguageIndex == 1) {
      return tamil.getType4(char, row, col, prevRow, prevCol);
    } else if (_choosenLanguageIndex == 2) {
      return telugu.getType4(char, row, col, prevRow, prevCol);
    } else if (_choosenLanguageIndex == 3) {
      return kannada.getType4(char, row, col, prevRow, prevCol);
    } else if (_choosenLanguageIndex == 4) {
      return malayalam.getType4(char, row, col, prevRow, prevCol);
    } else if (_choosenLanguageIndex == 5) {
      return bengali.getType4(char, row, col, prevRow, prevCol);
    } else if (_choosenLanguageIndex == 6) {
      return gurmukhi.getType4(char, row, col, prevRow, prevCol);
    } else if (_choosenLanguageIndex == 7) {
      return gujarati.getType4(char, row, col, prevRow, prevCol);
    } else if (_choosenLanguageIndex == 8) {
      return odia.getType4(char, row, col, prevRow, prevCol);
    }
    return char;
  }

  void updateType3(int row, int col, String char) {
    if (_choosenLanguageIndex == 0) {
      devanagari.setNewType3(row, col, char);
      characterSet = devanagari.getCharacterSet();
      extraCharacterSet = devanagari.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 1) {
      tamil.setNewType3(row, col, char);
      characterSet = tamil.getCharacterSet();
      extraCharacterSet = tamil.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 2) {
      telugu.setNewType3(row, col, char);
      characterSet = telugu.getCharacterSet();
      extraCharacterSet = telugu.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 3) {
      kannada.setNewType3(row, col, char);
      characterSet = kannada.getCharacterSet();
      extraCharacterSet = kannada.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 4) {
      malayalam.setNewType3(row, col, char);
      characterSet = malayalam.getCharacterSet();
      extraCharacterSet = malayalam.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 5) {
      bengali.setNewType3(row, col, char);
      characterSet = bengali.getCharacterSet();
      extraCharacterSet = bengali.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 6) {
      gurmukhi.setNewType3(row, col, char);
      characterSet = gurmukhi.getCharacterSet();
      extraCharacterSet = gurmukhi.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 7) {
      gujarati.setNewType3(row, col, char);
      characterSet = gujarati.getCharacterSet();
      extraCharacterSet = gujarati.getExtraCharacterSet();
    } else if (_choosenLanguageIndex == 8) {
      odia.setNewType3(row, col, char);
      characterSet = odia.getCharacterSet();
      extraCharacterSet = odia.getExtraCharacterSet();
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
    } else if (_choosenLanguageIndex == 1) {
      tamil.updateEnabled(row, col);
      isEnabled = tamil.getEnabled();
      debugPrint(isEnabled[2][0].toString());
    } else if (_choosenLanguageIndex == 2) {
      telugu.updateEnabled(row, col);
      isEnabled = telugu.getEnabled();
      debugPrint(isEnabled[2][0].toString());
    } else if (_choosenLanguageIndex == 3) {
      kannada.updateEnabled(row, col);
      isEnabled = kannada.getEnabled();
      debugPrint(isEnabled[2][0].toString());
    } else if (_choosenLanguageIndex == 4) {
      malayalam.updateEnabled(row, col);
      isEnabled = malayalam.getEnabled();
      debugPrint(isEnabled[2][0].toString());
    } else if (_choosenLanguageIndex == 5) {
      bengali.updateEnabled(row, col);
      isEnabled = bengali.getEnabled();
      debugPrint(isEnabled[2][0].toString());
    } else if (_choosenLanguageIndex == 6) {
      gurmukhi.updateEnabled(row, col);
      isEnabled = gurmukhi.getEnabled();
      debugPrint(isEnabled[2][0].toString());
    } else if (_choosenLanguageIndex == 7) {
      gujarati.updateEnabled(row, col);
      isEnabled = gujarati.getEnabled();
      debugPrint(isEnabled[2][0].toString());
    } else if (_choosenLanguageIndex == 8) {
      odia.updateEnabled(row, col);
      isEnabled = odia.getEnabled();
      debugPrint(isEnabled[2][0].toString());
    }
    notifyListeners();
  }
}
