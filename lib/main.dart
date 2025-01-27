import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:e_commerce_app/route/route_constants.dart';
import 'package:e_commerce_app/route/router.dart' as router;
import 'package:e_commerce_app/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

// Import your state management classes
import 'package:e_commerce_app/providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Exclusive',
        theme: AppTheme.lightTheme(context),
        themeMode: ThemeMode.light,
        onGenerateRoute: router.generateRoute,
        initialRoute: _getInitialRoute(),
      ),
    );
  }

  String _getInitialRoute() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null ? entryPointScreenRoute : onboardingScreenRoute;
  }
}
