import 'package:flutter/material.dart';
import 'package:full_version_newsapp/controller/catagodyscreen_controller.dart';
import 'package:full_version_newsapp/controller/homeScreen_controller.dart';
import 'package:full_version_newsapp/view/home_screen/Home_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomescreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CatagoryscreenController(),
        )
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
