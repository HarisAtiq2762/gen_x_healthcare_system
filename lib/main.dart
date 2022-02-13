import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gen_x_healthcare_system/modals/vitals.dart';
import 'package:gen_x_healthcare_system/splashScreen.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'modals/darkTheme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Vitals()),
        ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_){
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context,value,Widget child){
          return ScreenUtilInit(
            designSize: Size(360, 750),
            builder: (){
              return MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  theme: Styles.themeData(Provider.of<DarkThemeProvider>(context).darkTheme, context),
                  home: SplashScreen()
              );
            },
          );
        },
      )
    );
  }
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }
}
