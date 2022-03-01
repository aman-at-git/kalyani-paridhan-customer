import 'package:flutter/foundation.dart';

enum ThemeUIKit {
  barbera,
  bellcommerce,
  foodiy,
  furney,
  restoria,
  shuppy,
  treshop,
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ThemeUIKit _themeUIKit = ThemeUIKit.barbera;
  ThemeUIKit get themeUIKit => _themeUIKit;
  set themeUIKit(ThemeUIKit val) {
    _themeUIKit = val;
    notifyListeners();
  }

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
