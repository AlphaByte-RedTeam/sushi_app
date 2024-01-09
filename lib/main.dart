import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sushi_app/pages/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "SECRETS.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Color secondarySeedColor = const Color(0xFFE0DFD5);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SafeArea(
        child: Welcome(),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange,
          accentColor: secondarySeedColor,
        ),
      ),
    );
  }
}
