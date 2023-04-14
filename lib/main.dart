import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helping_hand/screens/baymax.dart';
import 'package:helping_hand/screens/login.dart';
import 'package:helping_hand/screens/onBoarding.dart';
import 'package:helping_hand/screens/outline.dart';
import 'package:helping_hand/screens/splash.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //connecting the database before starting the application
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          theme: ThemeData(colorScheme: lightDynamic, useMaterial3: true),
          darkTheme: ThemeData(colorScheme: darkDynamic, useMaterial3: true),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const Splash(),
            '/onBoarding': (context) => const OnBoarding(),
            '/outline': (context) => const Outline(),
            '/login': (context) => const Login(),
            '/baymax': (context) => const Baymax(),
          },
        );
      },
    );
  }
}
