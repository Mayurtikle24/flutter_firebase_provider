import 'package:flutter/foundation.dart';

class GenderProvider extends ChangeNotifier {
  String _selectedGender = '';

  String get selectedGender => _selectedGender;

  void selectGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }
}
