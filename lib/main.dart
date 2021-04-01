import 'package:flutter/material.dart';
import 'home.dart';
import 'data_source.dart';
import 'localization/localiztion_methods.dart';
import 'localization/set_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  __MyAppState createState() => __MyAppState();

  static void setLocale(BuildContext context, Locale locale) {
    __MyAppState state = context.findAncestorStateOfType<__MyAppState>();
    state.setLocale(locale);
  }
}

class __MyAppState extends State<MyApp> {
  var pos;
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  Locale _locale;

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return ChangeNotifierProvider(create: (_) {
        return themeChangeProvider;
      }, child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: _locale,
            supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
            localizationsDelegates: [
              SetLocalization.localizationsDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (locale.languageCode == deviceLocale.languageCode &&
                    locale.countryCode == deviceLocale.countryCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            //    theme: ThemeData(
            //    fontFamily: 'Circular',
            //    primaryColor: primaryBlack
            //  ),
            home: HomePage()
            //('lib/assets/images/health.gif')
            //HomePage(),
            );
      }));
    }
  }
}
