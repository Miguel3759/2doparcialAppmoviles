import 'package:rmgmapp/data_provider.dart';
import 'package:rmgmapp/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider())
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}