import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ultimate_bundle/helpers/colors.dart';
import 'package:ultimate_bundle/providers/theme_provider.dart';

ThemeData themeLight(BuildContext context) {
  final _theme = Provider.of<ThemeProvider>(context);

  Color _primaryLight(ThemeUIKit val) {
    switch (val) {
      case ThemeUIKit.barbera:
        return PrimaryColorLight.barbera;
      case ThemeUIKit.bellcommerce:
        return PrimaryColorLight.bellcommerce;
      case ThemeUIKit.foodiy:
        return PrimaryColorLight.foodiy;
      case ThemeUIKit.furney:
        return PrimaryColorLight.furney;
      case ThemeUIKit.restoria:
        return PrimaryColorLight.restoria;
      case ThemeUIKit.shuppy:
        return PrimaryColorLight.shuppy;
      case ThemeUIKit.treshop:
        return PrimaryColorLight.treshop;
      default:
        return PrimaryColorLight.barbera;
    }
  }

  return ThemeData(
    brightness: Brightness.light,
    backgroundColor: ColorLight.background,
    cardColor: ColorLight.card,
    disabledColor: ColorLight.disabledButton,
    errorColor: ColorLight.error,
    hintColor: ColorLight.fontSubtitle,
    indicatorColor: _primaryLight(_theme.themeUIKit),
    primaryIconTheme: const IconThemeData(
      color: ColorLight.fontTitle,
    ),
    primaryColor: _primaryLight(_theme.themeUIKit),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _primaryLight(_theme.themeUIKit),
    ),
    scaffoldBackgroundColor: ColorLight.background,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),
    colorScheme: const ColorScheme.light(secondary: PrimaryColorLight.barbera),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headline1: GoogleFonts.poppins(
        color: ColorLight.fontTitle,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headline2: GoogleFonts.poppins(
        color: ColorLight.fontTitle,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headline3: GoogleFonts.poppins(
        color: ColorLight.fontTitle,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headline4: GoogleFonts.poppins(
        color: ColorLight.fontTitle,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      headline5: GoogleFonts.poppins(
        color: ColorLight.fontTitle,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: GoogleFonts.poppins(
        color: ColorLight.fontTitle,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: GoogleFonts.poppins(
        color: ColorLight.fontTitle,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      subtitle1: GoogleFonts.poppins(
        color: ColorLight.fontSubtitle,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      subtitle2: GoogleFonts.poppins(
        color: ColorLight.fontSubtitle,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      button: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

ThemeData themeDark(BuildContext context) {
  final _theme = Provider.of<ThemeProvider>(context);

  Color _primaryDark(ThemeUIKit val) {
    switch (val) {
      case ThemeUIKit.barbera:
        return PrimaryColorDark.barbera;
      case ThemeUIKit.bellcommerce:
        return PrimaryColorDark.bellcommerce;
      case ThemeUIKit.foodiy:
        return PrimaryColorDark.foodiy;
      case ThemeUIKit.furney:
        return PrimaryColorDark.furney;
      case ThemeUIKit.restoria:
        return PrimaryColorDark.restoria;
      case ThemeUIKit.shuppy:
        return PrimaryColorDark.shuppy;
      case ThemeUIKit.treshop:
        return PrimaryColorDark.treshop;
      default:
        return PrimaryColorDark.barbera;
    }
  }

  return ThemeData(
    brightness: Brightness.dark,
    backgroundColor: ColorDark.background,
    cardColor: ColorDark.card,
    disabledColor: ColorDark.disabledButton,
    errorColor: ColorDark.error,
    hintColor: ColorDark.fontSubtitle,
    indicatorColor: _primaryDark(_theme.themeUIKit),
    primaryIconTheme: const IconThemeData(
      color: ColorDark.fontTitle,
    ),
    primaryColor: _primaryDark(_theme.themeUIKit),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _primaryDark(_theme.themeUIKit),
    ),
    scaffoldBackgroundColor: ColorDark.background,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),
    colorScheme: const ColorScheme.dark(secondary: PrimaryColorDark.barbera),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headline1: GoogleFonts.poppins(
        color: ColorDark.fontTitle,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headline2: GoogleFonts.poppins(
        color: ColorDark.fontTitle,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headline3: GoogleFonts.poppins(
        color: ColorDark.fontTitle,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headline4: GoogleFonts.poppins(
        color: ColorDark.fontTitle,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      headline5: GoogleFonts.poppins(
        color: ColorDark.fontTitle,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: GoogleFonts.poppins(
        color: ColorDark.fontTitle,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: GoogleFonts.poppins(
        color: ColorDark.fontTitle,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      subtitle1: GoogleFonts.poppins(
        color: ColorDark.fontSubtitle,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      subtitle2: GoogleFonts.poppins(
        color: ColorDark.fontSubtitle,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      button: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
