import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ultimate_bundle/helpers/routes.dart';
import 'package:ultimate_bundle/helpers/themes.dart';
import 'package:ultimate_bundle/l10n/l10n.dart';
import 'package:ultimate_bundle/providers/locale_provider.dart';
import 'package:ultimate_bundle/providers/theme_provider.dart';
import 'package:ultimate_bundle/src/shuppy/main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, _theme, snapshot) {
        return GetMaterialApp(
          title: 'Kalyani Paridhan',
          debugShowCheckedModeBanner: false,
          theme: themeLight(context),
          darkTheme: themeDark(context),
          themeMode:
            (_theme.isDarkTheme == true) ? ThemeMode.dark : ThemeMode.light,
          supportedLocales: L10n.all,
          getPages: allRoutesFurney,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const ShuppySplashScreen(),
        );
      }),
    );
  }
}
