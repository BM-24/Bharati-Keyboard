import 'package:flutter/material.dart';

class TextProvider with ChangeNotifier {
  String _text = '';

  String get text => _text;
  final List<Map<String, int>> _keyPoints = [];

  void setText(String text) {
    _text = text;
    notifyListeners();
  }

  void addText(String text, String lang, int row, int col) {
    _text += text;
    _keyPoints.add({'row': row, 'col': col});
    debugPrint('addText() called for $_text');
    notifyListeners();
  }

  void removeText() {
    if (_text.isNotEmpty) {
      _text = _text.substring(0, _text.length - 1);
      _keyPoints.removeLast();
    }
    debugPrint('removeText() called for $_text');
    notifyListeners();
  }

  void function(String char) {
    debugPrint('function() called for $char');
  }

  Map<String, int> getLatestKeyPoint() {
    if (_keyPoints.isNotEmpty) {
      return _keyPoints.last;
    }
    return {'row': -1, 'col': -1};
  }

  String getLatestChar() {
    if (_text.isNotEmpty) {
      return _text[_text.length - 1];
    }
    return '';
  }
}
