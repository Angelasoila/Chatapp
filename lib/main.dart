import 'package:flutter/material.dart';
import 'package:flutter_application_4/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/auth/auth_gate.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Provide ThemeProvider here
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context)
          .themeData, // Access ThemeProvider here
      initialRoute: '/auth', // Start with AuthGate
      routes: {
        '/auth': (context) => AuthGate(), // AuthGate handles redirection
        '/home': (context) => HomePage(), // Home Page
      },
    );
  }
}
