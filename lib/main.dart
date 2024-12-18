import 'package:flutter/material.dart';
import 'package:jolz_app/features/webview/presentation/pages/splash_screen.dart';
import 'core/injection_container.dart' as di;


void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home:  const SplashScreen(),
    );
  }
}